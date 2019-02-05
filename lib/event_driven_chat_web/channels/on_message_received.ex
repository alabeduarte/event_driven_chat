defmodule EventDrivenChatWeb.OnMessageReceived do
  require Logger
  alias EventDrivenChat.Message
  alias EventDrivenChat.Repo

  def process(event_shadow) do
    GenServer.cast(__MODULE__, event_shadow)
    :ok
  end

  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_cast({topic, id}, state) do
    event = EventBus.fetch_event({topic, id})
    Message.changeset(%Message{}, event.data) |> Repo.insert()

    {:noreply, [{topic, id} | state]}
  end
end
