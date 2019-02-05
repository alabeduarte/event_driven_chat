defmodule EventDrivenChatWeb.RoomChannel do
  use EventDrivenChatWeb, :channel
  alias EventDrivenChat.TheBus
  alias EventDrivenChat.Message

  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      TheBus.publish(:user_joined, %{data: payload})

      send(self(), :after_join)

      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Need to figure out a way to put this in a subscriber
  def handle_info(:after_join, socket) do
    Message.get_messages()
    |> Enum.each(fn msg ->
      push(socket, "message_loaded", %{
        name: msg.name,
        message: msg.message
      })
    end)

    {:noreply, socket}
  end

  def handle_in("ping", payload, socket) do
    TheBus.publish(:pinged, %{data: payload})
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("message_received", payload, socket) do
    TheBus.publish(:message_received, %{data: payload})
    broadcast(socket, "message_received", payload)
    {:noreply, socket}
  end

  defp authorized?(_payload) do
    true
  end
end
