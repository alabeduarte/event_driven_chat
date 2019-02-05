defmodule EventDrivenChat.TheBusSupervisor do
  use GenServer
  alias EventDrivenChatWeb.TheBus

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(initial_state) do
    init_subscriptions()

    {:ok, initial_state}
  end

  defp init_subscriptions() do
    TheBus.subscribe(:user_joined)
    TheBus.subscribe(:pinged)
    TheBus.subscribe(:shouted)
  end
end
