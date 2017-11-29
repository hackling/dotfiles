echo 'Adding Login Items'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Alfred 3.app", name:"Alfred", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Divvy.app", name:"Divvy", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Hammerspoon.app", name:"Alfred", hidden:true}'
