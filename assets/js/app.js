import css from "../css/app.css"
import "phoenix_html"
import socket from "./socket"

const channel = socket.channel('room:lobby', {});

const displayNewMessage = (payload) => {
  const li = document.createElement("li");
  const name = payload.name || 'guest';
  li.innerHTML = '<b>' + name + '</b>: ' + payload.message;
  ul.appendChild(li);
}

channel.on('message_received', displayNewMessage);
channel.on('message_loaded', displayNewMessage);

channel.join();

const ul = document.getElementById('msg-list');
const name = document.getElementById('name');
const msg = document.getElementById('msg');

msg.addEventListener('keypress', function (event) {
  if (event.keyCode == 13 && msg.value.length > 0) {
    channel.push('message_received', {
      name: name.value,
      message: msg.value
    });
    msg.value = '';
  }
});
