echo 'Applying Karabiner Preferences'
rm ~/Library/Preferences/org.pqrs.Karabiner.plist
ln -s ~/.dotfiles/application-config/org.pqrs.Karabiner.plist ~/Library/Preferences/org.pqrs.Karabiner.plist

echo 'Applying Divvy Preferences'
rm ~/Library/Preferences/com.mizage.Divvy.plist
ln -s ~/.dotfiles/application-config/com.mizage.Divvy.plist ~/Library/Preferences/com.mizage.Divvy.plist

echo 'Applying iterm Preferences'
rm ~/Library/Preferences/com.googlecode.iterm2.plist
ln -s ~/.dotfiles/application-config/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

# Preferences are cached in 10.9. See http://hints.macworld.com/article.php?story=20130908042828630. If you edit a plist file directly or replace the plist of an application, the application will keep using the cached version even after you quit and reopen the application.
#
# You can run defaults read com.googlecode.iterm2 or killall cfprefsd to apply the changes:
#
# Quit iTerm
# Edit the plist
# Run defaults read com.googlecode.iterm2 or killall cfprefsd
# Open iTerm
# Changes made with defaults are applied after you just quit and reopen an application like in earlier versions of OS X.
