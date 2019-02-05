# EventDrivenChat

Spike around abstracting event bus into a phoenix application to explore some
event-driven-architecture ideas.

Credits to https://github.com/dwyl/phoenix-chat-example

## Setup

Make sure you have postgress running on port `5432` (easiest way is to setup a
docker container via [Kitematic](https://kitematic.com/))

```
$ make install
```

## Running locally

```
$ make start
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
