defmodule LiveViewStudioWeb.PhotosLive do
  use LiveViewStudioWeb, :live_view
  alias LiveViewStudio.Photos

  defp categories() do
    ["nature", "architecture", "bw"]
  end

  defp filter_default() do
    %{user: "", title: "", categories: []}
  end

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        photos: Photos.list_photos(),
        filter: filter_default(),
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
          <fieldset class="flex justify-between">
              <input type="hidden" name="category_checkbox[]" value="" />
              <%= for category <- categories() do %>
                <%= category_checkbox(category: category, checked: category in @filter.categories) %>
              <% end %>
          </fieldset>
          <%# <input class="p-2 rounded border-2" id="user" name="user" type="text" placeholder="search by title" value="">
          <input class="p-2 rounded border-2" id="user" name="user" type="text" placeholder="search by date" value=""> %>
          <input class="btn btn-green" type="submit">
        </form>
        <button phx-click="clear_filter" class="btn md:ml-auto">❌</button>
      </div>
      <!--/ Filter Navigation Bar -->

      <%= if length(@photos) == 0 do %>
          <p class="text-center text-2xl mt-4">🤷🏻 No results found</p>
      <% end %>
      <!-- Photo Grid -->
      <div class="grid grid-cols-<%= grid_columns(@grid.columns, 'sm') %> md:grid-cols-<%= grid_columns(@grid.columns, 'md') %> lg:grid-cols-<%= grid_columns(@grid.columns, 'lg') %> gap-6 max-w-xxl mx-auto mb-4">
        <%= for photo <- @photos do %>
          <div class="transition duration-75 ease-in-out bg-white rounded-lg overflow-hidden shadow-md hover:shadow-2xl">
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
      <%# <span> %>
        <input class="p-2" type="checkbox" <%= if @checked, do: "checked" %> id="categories_checkbox-<%= assigns.category %>" name="category_checkbox[]" value="<%= assigns.category %>">
        <label class="p-2" for="categories_checkbox-<%= assigns.category %>"><%= assigns.category %></label>
      <%# </span> %>
    """
  end

  def handle_event("filter", %{"user" => user, "title" => title, "category_checkbox" => categories}, socket) do
    categories = List.delete_at(categories, 0)
    IO.inspect([title, user, categories], label: "title, user, categories")
    socket =
      assign(socket,
        filter: Map.merge(socket.assigns.filter, %{user: user, title: title, categories: categories}),
        photos: Photos.list_photos([user: user, title: title, categories: categories])
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

  def handle_event("clear_filter", _, socket) do
    IO.write("clear!")
    socket = assign(socket, filter: filter_default(), photos: Photos.list_photos())
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
