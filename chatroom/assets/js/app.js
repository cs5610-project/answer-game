// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed
// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".
import socket from "./socket"

var channel = socket.channel('room:*', {});

channel.on('shout', function (input) 
  var li = document.createElement("li");
  var name = input.name;    
  li.innerHTML = '<b>' + name + '</b>: ' + input.message; 
  ul.appendChild(li);                 
});

channel.join(); 


var ul = document.getElementById('msg-list');        
var name = document.getElementById('name');          
var message = document.getElementById('message');           

// "listen" for the [Enter] keypress event to send a message:
message.addEventListener('keypress', function (event) {
  if (event.which == 13 && message.value.length > 0) {
    channel.push('shout', { 
      name: name.value,     
      message: message.value    
    });
    message.value = '';        
  }
});
