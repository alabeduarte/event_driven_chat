defmodule EventDrivenChatWeb.OnUserJoined do
  require Logger
  alias EventDrivenChat.Message

  def process(event_shadow) do
    GenServer.cast(__MODULE__, event_shadow)
    :ok
  end

  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_cast({topic, id}, state) do
    event = EventBus.fetch_event({topic, id})

    # Message.get_messages()
    # |> Enum.each(fn msg ->
    #   push(socket, Atom.to_string(topic), %{
    #     name: msg.name,
    #     message: msg.message
    #   })
    # end)

    {:noreply, [{topic, id} | state]}
  end
end
