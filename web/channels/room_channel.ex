defmodule Border.RoomChannel do
  use Border.Web, :channel

  alias Border.Rooms
  alias Border.Room

  def join("room:" <> room, _params, socket) do
    user = socket.assigns.user
    room = socket.assigns.room
    pid = Rooms.pid(room)
    state = Room.state(pid)
    {:ok, %{user: user, match: state}, socket}
  end

  def handle_in("add_vertex", %{"x" => x, "y" => y}, socket) do
    user = socket.assigns.user
    room = socket.assigns.room
    pid = Rooms.pid(room)
    state = Room.add_vertex(pid, user, {x, y})
    broadcast! socket, "update", %{match: state}
    {:reply, :ok, socket}
  end
end
