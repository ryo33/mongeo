defmodule Border.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "room:*", Border.RoomChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(Border.Endpoint, "channel", token) do
      {:ok, client} ->
        socket = socket
                 |> assign(:user, client.user)
                 |> assign(:room, client.room)
        {:ok, socket}
      _ -> :error
    end
  end

  def id(_socket), do: nil
end
