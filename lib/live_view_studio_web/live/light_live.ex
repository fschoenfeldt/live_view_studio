defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 10, temp: 3000)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style="background-color: <%= temp_color(@temp) %>;
                    width: <%= @brightness %>%">
          <%= @brightness %>%
        </span>
      </div>

      <button phx-click="off">
        <img src="images/light-off.svg">
      </button>

      <button phx-click="down">
        <img src="images/down.svg">
      </button>

      <button phx-click="up">
        <img src="images/up.svg">
      </button>

      <button phx-click="on">
        <img src="images/light-on.svg">
      </button>

      <form phx-change="update">
        <input type="range" min="0" max="100"
              name="brightness" value="<%= @brightness %>" />
      </form>

      <form phx-change="change-temp">
        <%=for temperature <- [3000, 4000, 5000] do %>
          <%= temp_radio_button(temperature: temperature, checked: temperature == @temp) %>
        <% end %>
      </form>

    </div>
    """
  end

  defp temp_radio_button(assigns) do
    assigns = Enum.into(assigns, %{})
    ~L"""
    <input type="radio" id="<%= @temperature %>" name="temp" value="<%= @temperature %>"
          <%= if @checked, do: "checked" %> />
        <label for="<%= @temperature %>"><%= @temperature %></label>
    """
  end

  def handle_event("update", %{"brightness" => brightness}, socket) do
    brightness = String.to_integer(brightness)
    socket = assign(socket, brightness: brightness)
    {:noreply, socket}
  end

  def handle_event("change-temp", %{"temp" => temp}, socket) do
    temp = String.to_integer(temp)
    socket = assign(socket, temp: temp)
    {:noreply, socket}
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &(&1 + 10))
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &(&1 - 10))
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

  defp temp_color(3000), do: "#F1C40D"
  defp temp_color(4000), do: "#FEFF66"
  defp temp_color(5000), do: "#99CCFF"

end
