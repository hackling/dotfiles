echo 'Adding Login Items'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Alfred.app", name:"Alfred", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Divvy.app", name:"Divvy", hidden:true}'
osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Karabiner.app", name:"Karabiner", hidden:true}'
