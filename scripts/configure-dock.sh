dockutil --remove App\ Store
dockutil --remove System\ Preferences
dockutil --list | awk '{print $1}' | xargs -n 1 dockutil --remove
dockutil --add /Applications/Microsoft\ Outlook.app
dockutil --add /Applications/Messages.app
dockutil --add /Applications/Slack.app
dockutil --add /Applications/iTerm.app
dockutil --add /Applications/Firefox.app
dockutil --add /Applications/System\ Preferences.app
dockutil --add '/Applications' --view grid --display folder
dockutil --add '~/' --view grid --display folder
dockutil --add '~/Downloads' --view grid --display folder
