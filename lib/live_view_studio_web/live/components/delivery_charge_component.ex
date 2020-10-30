defmodule LiveViewStudioWeb.DeliveryChargeComponent do
  use LiveViewStudioWeb, :live_component

  import Number.Currency

  alias LiveViewStudio.SandboxCalculator

  def mount(socket) do
    socket = assign(socket, delivery_charge: 0, zip: nil)
    {:ok, socket}
  end
  def render(assigns) do
    ~L"""
    <form phx-change="calc_delivery_charge" phx-target="<%= @myself %>">
      <div class="field">
        <label for="zip">Zip Code:</label>
        <input type="text" name="zip" value="<%= @zip %>" />
        <span class="unit"><%= number_to_currency(@delivery_charge) %></span>
      </div>
    </form>
    """
  end

  def handle_event("calc_delivery_charge", %{"zip" => zip}, socket) do
    IO.inspect(zip, label: "zip")
    delivery_charge = SandboxCalculator.calculate_delivery_charge(zip)

    socket = assign(socket, zip: zip, delivery_charge: delivery_charge)
    send(self(), {:delivery_charges, delivery_charge})
    {:noreply, socket}
  end
end
