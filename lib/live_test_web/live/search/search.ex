defmodule LiveTestWeb.SearchLive.Search do
  use Phoenix.LiveView
  import Logger

  alias LiveTestWeb.Router.Helpers, as: Routes
  alias LiveTestWeb.Endpoint

  def render(assigns) do
    ~L"""
    <form class="bg-lightplain rounded px-2 pt-2 pb-0 mb-4 w-80 md:w-auto md:mb-0 md:px-0" phx-change="suggest" phx-submit="search">
      <div class="search-container">
      <input class="search-box shadow appearance-none border rounded w-full py-1 px-1 w-80"  type="text" name="q"
        value="<%= if @result, do: @result, else: @query %>" list="matches" placeholder="Search Stuff.. " phx-debounce="300"
        <%= if @loading, do: "readonly" %>/>
      <button class="search-button">Go</button>
      <datalist id="matches">
        <%= for match <- @matches do %>
          <option class="block px-4 py-2 text-sm leading-5 text-green hover:bg-green hover:text-green focus:outline-none focus:bg-green focus:text-green" value="<%= match %>"><%= match %></option>
        <% end %>
      </datalist>
      </div>

    </form>
    """
  end

  def mount(_, _session, socket) do
    {:ok, assign(socket, query: nil, result: nil, loading: false, matches: [])}
  end

  def handle_event("suggest", %{"q" => query}, socket) when byte_size(query) <= 100 do

    {:noreply, assign(socket, matches: [])}
  end

  def handle_event("search", %{"q" => query}, socket) when byte_size(query) <= 100 do

    Logger.info "doing a search"
    {:noreply, socket |> push_redirect(to:  Routes.live_path(socket, LiveTestWeb.SearchLive.Results, query ))}

        # {:noreply, socket |> push_redirect(to:  Routes.live_path(socket, CollegevalueWeb.FieldsLive.Show, query ))}
        # {:noreply, socket |> redirect(to: Routes.live_path(socket, CollegeValueWeb.FieldsLive.Show, query )) }

  end

end
