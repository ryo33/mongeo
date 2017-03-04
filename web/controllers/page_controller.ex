defmodule Border.PageController do
  use Border.Web, :controller
  alias Border.Room
  alias Border.Rooms

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, %{"room" => room}) do
    {:ok, pid} = Room.start_link()
    Rooms.register(room, pid)
    render conn, "index.html"
  end

  def join(conn, %{"room" => room, "name" => name}) do
    pid = Rooms.pid(room)
    Room.join(pid, name)
    redirect conn, to: page_path(conn, :game, room: room, name: name)
  end

  def game(conn, %{"room" => room, "name" => name}) do
    client = %{room: room, user: name}
    token = Phoenix.Token.sign(Border.Endpoint, "channel", client)
    render conn, "game.html", token: token, room: room
  end
end
