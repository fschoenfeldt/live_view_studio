defmodule LiveViewStudioWeb.ServersLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Servers
  alias LiveViewStudio.Servers.Server
  # alias LiveViewStudioWeb.Router

  def mount(_params, _session, socket) do
    servers = Servers.list_servers()

    socket =
      assign(socket,
        servers: servers,
        selected_server: hd(servers)
      )

    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    id = String.to_integer(id)

    server = Servers.get_server!(id)

    socket =
      assign(socket,
        selected_server: server,
        page_title: "What's up #{server.name}?"
      )

    {:noreply, socket}
  end

  def handle_params(_, _url, socket) do
    if socket.assigns.live_action == :new do
      socket =
        assign(
          socket,
          changeset: Servers.change_server(%Server{})
        )

      IO.inspect(socket.assigns.changeset, label: "changeset")
      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  def handle_event("submit", %{"server" => params}, socket) do
    IO.inspect(params, label: "submitted server")

    case Servers.create_server(params) do
      {:ok, server} ->
        IO.inspect(server, label: "WORKED!")

        socket =
          assign(
            socket,
            servers: [server | socket.assigns.servers]
          )

        {:noreply,
         push_patch(
           socket,
           to: Routes.live_path(socket, __MODULE__, id: server.id)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset, label: "Didn't work!")

        socket =
          assign(
            socket,
            changeset: changeset
          )

        {:noreply, socket}
    end
  end

  def handle_event("validate", %{"server" => params}, socket) do
    changeset =
      %Server{}
      |> Servers.change_server(params)
      |> Map.put(:action, :insert)

    socket = assign(socket, changeset: changeset)
    {:noreply, socket}
  end

  def handle_event("toggle", %{"id" => id}, socket) do
    server = Servers.get_server!(id)

    {:ok, server} =
      Servers.update_server(server, %{
        status: if(server.status == "down", do: "up", else: "down")
      })

    socket =
      update(socket, :servers, fn servers ->
        for s <- servers do
          case s.id == id do
            true -> server
            _ -> s
          end
        end
      end)

    socket =
      assign(
        socket,
        selected_server: server
      )

    :timer.sleep(500)
    {:noreply, socket}
  end

  defp link_body(server) do
    assigns = %{name: server.name, status: server.status}

    ~L"""
    <span class="status <%= @status %>"></span>
    <img src="/images/server.svg">
    <%= @name %>
    """
  end
end
