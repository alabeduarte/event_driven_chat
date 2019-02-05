defmodule EventDrivenChat.Repo do
  use Ecto.Repo,
    otp_app: :event_driven_chat,
    adapter: Ecto.Adapters.Postgres
end
