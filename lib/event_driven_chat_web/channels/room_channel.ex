defmodule EventDrivenChatWeb.RoomChannel do
  use EventDrivenChatWeb, :channel
  alias EventDrivenChatWeb.TheBus

  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      TheBus.publish(:user_joined, %{data: payload})
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    TheBus.publish(:pinged, %{data: payload})
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    TheBus.publish(:shouted, %{data: payload})
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
