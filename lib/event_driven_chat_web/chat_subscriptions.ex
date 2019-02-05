defmodule EventDrivenChatWeb.ChatSubscriptions do
  use GenServer
  alias EventDrivenChat.TheBus
  alias EventDrivenChatWeb.OnUserJoined
  alias EventDrivenChatWeb.OnMessageReceived

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(initial_state) do
    init_subscriptions()

    {:ok, initial_state}
  end

  defp init_subscriptions() do
    TheBus.subscribe(:pinged)
    TheBus.subscribe(:user_joined, OnUserJoined)
    TheBus.subscribe(:message_received, OnMessageReceived)
  end
end
