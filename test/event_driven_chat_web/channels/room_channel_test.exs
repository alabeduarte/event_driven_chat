defmodule EventDrivenChatWeb.RoomChannelTest do
  use EventDrivenChatWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      socket(EventDrivenChatWeb.UserSocket, "user_id", %{some: :assign})
      |> subscribe_and_join(EventDrivenChatWeb.RoomChannel, "room:lobby")

    {:ok, socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push(socket, "ping", %{"hello" => "there"})
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "message_received broadcasts to room:lobby", %{socket: socket} do
    push(socket, "message_received", %{"hello" => "all"})
    assert_broadcast "message_received", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "broadcast", %{"some" => "data"})
    assert_push "broadcast", %{"some" => "data"}
  end
end
