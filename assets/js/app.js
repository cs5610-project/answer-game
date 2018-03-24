// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

import socket from "./socket";

import game_init from "./answer";

var channel = socket.channel('games:' + window.gameName, {});

channel.on('shout', function (input){
  var li = document.createElement("li");
  var name = input.name;
  li.innerHTML = '<b>' + name + '</b>: ' + input.message;
  ul.appendChild(li);
});

$("#confirm-btn-new").click( () => {
  let name = $("#name-input").val();
  window.location = `/games/${name}`;
})


$("#confirm-btn-old").click( () => {
  let name = $("#select-input option:selected").val();
  window.location = `/games/${name}`;
})



var ul = document.getElementById('msg-list');
var name = document.getElementById('name');
name.value = window.username;
var message = document.getElementById('message');

// "listen" for the [Enter] keypress event to send a message:
message.addEventListener('keypress', function (event) {
  if (event.which == 13 && message.value.length > 0) {
    channel.push('shout', {
      name: name.value,
      message: message.value,
      game_name: window.gameName
    });
    message.value = '';
  }
});


channel
  .join()
  .receive('ok', resp => {
    console.log('Joined successfully', resp);
  })
  .receive('error', resp => {
    console.log('Unable to join', resp);
  });


function init() {

  let root = document.getElementById('game');
  if(!root) {
    return;
  }

  let channel = socket.channel("games:" + window.gameName, {});
  game_init(root, channel);

}


// Use jQuery to delay until page loaded.
$(init);

