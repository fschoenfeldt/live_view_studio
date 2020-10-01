defmodule LiveViewStudioWeb.PhotosLive do
  use LiveViewStudioWeb, :live_view
  alias LiveViewStudio.Photos

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        photos: Photos.list_photos(),
        grid: %{columns: 3, increase_enabled: true, decrease_enabled: true}
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div id="photos">
      <h1 class="text-5xl">Fotohäcker on Elixir!</h1>
      <div class="p-4 mb-4 bg-gray-100 rounded-lg shadow-md">
        <form class="flex gap-2 flex-col md:flex-row items-center" phx-submit="filter" phx-change="filter">
          <input phx-debounce="250" class="p-2 rounded border-2" id="user" name="user" type="text" placeholder="filter by username" value="">
          <fieldset class="bg-gray-200 rounded">
            <input phx-click="grid_change" class="btn btn-darker rounded-r-none" type="button" name="-" value="-" />
            <span class="p-2">Zoom</span>
            <input phx-click="grid_change" class="btn btn-darker rounded-l-none" type="button" name="+" value="+" />
          </fieldset>
          <%# <input class="p-2 rounded border-2" id="user" name="user" type="text" placeholder="search by title" value="">
          <input class="p-2 rounded border-2" id="user" name="user" type="text" placeholder="search by date" value=""> %>

          <input class="btn btn-green md:ml-auto" type="submit">
        </form>
      </div>
      <%= if length(@photos) == 0 do %>
          <p class="text-center text-2xl mt-4">🤷🏻 No results found</p>
      <% end %>
      <div class="grid grid-cols-<%= grid_columns(@grid.columns, 'sm') %> md:grid-cols-<%= grid_columns(@grid.columns, 'md') %> lg:grid-cols-<%= grid_columns(@grid.columns, 'lg') %> gap-4 max-w-xxl mx-auto mb-4">
        <%= for photo <- @photos do %>
          <div class="transition duration-75 ease-in-out bg-white rounded-lg overflow-hidden hover:opacity-75 shadow-md">
            <div>
              <%= img_tag(photo.url, class: "w-full") %>
            </div>
            <div class="p-2 flex justify-between">
              <h2><%= photo.title %></h2>
              <span class="text-gray-500">by <%= photo.user %></span>
            </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  def handle_event("filter", %{"user" => user}, socket) do
    socket = assign(socket, photos: Photos.list_photos(user: user))
    {:noreply, socket}
  end

  def handle_event("grid_change", %{"value" => "+"}, socket) do
    socket =
      assign(socket,
        grid: Map.replace!(socket.assigns.grid, :columns, socket.assigns.grid.columns - 1)
      )

    {:noreply, socket}
  end

  def handle_event("grid_change", %{"value" => "-"}, socket) do
    socket =
      assign(socket,
        grid: Map.replace!(socket.assigns.grid, :columns, socket.assigns.grid.columns + 1)
      )

    {:noreply, socket}
  end

  defp grid_columns(columns, breakpoint) do
    case breakpoint do
      'lg' ->
        columns

      'md' ->
        columns - 1

      'sm' ->
        columns - 2
    end
  end
end
