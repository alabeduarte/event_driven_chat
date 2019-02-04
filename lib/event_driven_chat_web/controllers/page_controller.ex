defmodule EventDrivenChatWeb.PageController do
  use EventDrivenChatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
