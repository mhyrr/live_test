defmodule LiveTestWeb.SearchLive.Results do
  use Phoenix.LiveView

  import Logger

  alias LiveTestWeb.Router.Helpers, as: Routes
  alias LiveTestWeb.Endpoint
  alias Phoenix.LiveView.Socket

  @message ""
  @query ""

  def render(assigns) do
    Phoenix.View.render(LiveTestWeb.SearchView, "results.html", assigns)
  end


  def mount(_, _, socket) do
      {:ok, socket}
  end

  def handle_params(%{"query" => query}, _url, socket) do

    {:noreply, socket |> assign(query: query) |> fetch()}
  end

  defp fetch(%Socket{assigns: %{query: query}} = socket) do

    Logger.info "delayed"

    case String.length(query) > 2 do
      false ->
        assign(socket, message: "Too short a search.. I need a little more to work with here! Give me at least 3 characters.", query: "")
      true ->
        assign(socket, message: "", query: query)
    end


  end


  # @spec mount(any, any, any) :: {:ok, any}
  # def mount(_, _, socket) do
  #   {:ok, assign(socket, message: "", colleges: @colleges, fields: @fields)}
  # end

end
