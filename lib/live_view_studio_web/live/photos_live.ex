defmodule LiveViewStudioWeb.PhotosLive do
  use LiveViewStudioWeb, :live_view
  alias LiveViewStudio.Photos

  def categories() do
    ["nature", "architecture", "bw"]
  end

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        photos: Photos.list_photos(),
        filter: %{user: "", title: "", categories: []},
        grid: %{columns: 3, increase_enabled: true, decrease_enabled: true}
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div id="photos">
      <h1 class="text-5xl">Fotohäcker on Elixir!</h1>
      <!-- Filter Navigation Bar -->
      <div class="p-4 mb-4 bg-gray-100 rounded-lg shadow-md">
        <form class="grid grid-cols-2 gap-2 flex-col md:flex md:flex-row items-center" phx-submit="filter" phx-change="filter">
          <input phx-debounce="250" class="p-2 rounded border-2" id="title" name="title" type="text" placeholder="filter by title" value="<%= @filter.title %>">
          <input phx-debounce="250" class="p-2 rounded border-2" id="user" name="user" type="text" placeholder="filter by username" value="<%= @filter.user %>">
          <fieldset class="bg-gray-200 rounded flex items-center justify-between">
            <input phx-click="grid_change" class="btn btn-darker rounded-r-none" type="button" name="-" value="-" />
            <span class="p-2">Zoom</span>
            <input phx-click="grid_change" class="btn btn-darker rounded-l-none" type="button" name="+" value="+" />
          </fieldset>
          <fieldset>
              <input type="hidden" name="categories[]" value="" />
              <%= for category <- categories() do %>
                <%= category_checkbox(category: category) %>
              <% end %>
          </fieldset>
          <%# <input class="p-2 rounded border-2" id="user" name="user" type="text" placeholder="search by title" value="">
          <input class="p-2 rounded border-2" id="user" name="user" type="text" placeholder="search by date" value=""> %>
          <button class="btn md:ml-auto">❌</button>
          <input class="btn btn-green" type="submit">
        </form>
      </div>
      <!--/ Filter Navigation Bar -->

      <%= if length(@photos) == 0 do %>
          <p class="text-center text-2xl mt-4">🤷🏻 No results found</p>
      <% end %>
      <!-- Photo Grid -->
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
            <div class="p-2 flex gap-1">
              <%= for category <- photo.categories do %>
                <span class="bg-blue-100 text-gray-700 px-2 rounded-md"><%= category %></span>
              <% end %>
            </div>
          </div>
        <% end %>
      </div>
      <!--/ Photo Grid -->
    </div>
    """
  end

  defp category_checkbox(assigns) do
    assigns = Enum.into(assigns, %{})

    ~L"""
      <input type="checkbox" id="categories_checkbox-<%= assigns.category %>" name="category_checkbox[]" value="<%= assigns.category %>">
      <label for="categories_checkbox-<%= assigns.category %>"><%= assigns.category %></label>
    """
  end

  def handle_event("filter", %{"user" => user, "title" => title}, socket) do
    IO.inspect([title, user], label: "title, user")
    socket =
      assign(socket,
        filter: Map.merge(socket.assigns.filter, %{user: user, title: title}),
        photos: Photos.list_photos([user: user, title: title])
      )

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
      'md' ->
        columns = columns - 1

      'sm' ->
        columns = columns - 2

      _ ->
        columns
    end
  end
end
