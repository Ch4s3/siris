defmodule SirisWeb.PageController do
  use SirisWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
