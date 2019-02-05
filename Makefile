install:
	@mix deps.get
	cd assets && npm install && cd ..
	@mix ecto.create
	@mix ecto.migrate

start:
	@mix phx.server

.PHONY: install, start
