defmodule Discuss.ExtraController do
  use Discuss.Web, :controller

  def news(conn, _params) do
    render conn, "extra.html"
  end
end
