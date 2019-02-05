import css from "../css/app.css"
import "phoenix_html"
import socket from "./socket"

let channel = socket.channel('room:lobby', {});

channel.on('message_received', function (payload) {
  let li = document.createElement("li");
  let name = payload.name || 'guest';
  li.innerHTML = '<b>' + name + '</b>: ' + payload.message;
  ul.appendChild(li);
});

channel.join();


let ul = document.getElementById('msg-list');
let name = document.getElementById('name');
let msg = document.getElementById('msg');

msg.addEventListener('keypress', function (event) {
  if (event.keyCode == 13 && msg.value.length > 0) {
    channel.push('message_received', {
      name: name.value,
      message: msg.value
    });
    msg.value = '';
  }
});
