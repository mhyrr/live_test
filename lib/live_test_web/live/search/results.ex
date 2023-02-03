defmodule LiveTestWeb.SearchLive.Results do
  use Phoenix.LiveView

  import Logger

  alias LiveTestWeb.Router.Helpers, as: Routes
  alias LiveTestWeb.Endpoint
  alias Phoenix.LiveView.Socket

  @message ""

  def render(assigns) do
    Phoenix.View.render(LiveTestWeb.SearchView, "results.html", assigns)
  end


  def mount(_, _, socket) do
    # Logger.info "delayed"

    #   case String.length(query) > 2 do
    #     false ->
    #       {:ok, assign(socket, message: "I need a little more to work with here!", colleges: @colleges, fields: @fields)}
    #     true ->
    #       colleges = Colleges.match_colleges(query)
    #       fields = Fields.match_fields(query)
    #       {:ok, assign(socket, colleges: colleges, fields: fields, message: "")}
    #   end
      {:ok, socket}
  end

  def handle_params(%{"query" => query}, _url, socket) do

    # if connected?(socket), do: Demo.Accounts.subscribe(id)

    {:noreply, socket |> assign(query: query) |> hydrate()}
  end

  defp hydrate(%Socket{assigns: %{query: query}} = socket) do

    Logger.info "delayed"

    case String.length(query) > 2 do
      false ->
        assign(socket, message: "Too short a search.. I need a little more to work with here! Give me at least 3 characters.")
      true ->
        assign(socket, message: "")
    end


  end


  # @spec mount(any, any, any) :: {:ok, any}
  # def mount(_, _, socket) do
  #   {:ok, assign(socket, message: "", colleges: @colleges, fields: @fields)}
  # end

end
