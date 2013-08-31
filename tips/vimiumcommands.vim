Description

The Hacker's Browser. Vimium provides keyboard shortcuts for navigation and control in the spirit of Vim.

*NOTE* Google does not allow Vimium to run on this gallery page and the Chrome New Tab page, by design.

*NOTE* Chrome has some alarmist messaging around the permissions that Vimium needs to run. Really all it's asking for is that its javascript be loaded into every page. Don't be alarmed. Vimium never talks to any servers and does absolutely nothing with your data. Read the open source code if you're paranoid.

*NOTE* You can search by regular expressions. See here: https://github.com/philc/vimium/wiki/Find-Mode

For more information on rebinding your keys, see the README at https://github.com/philc/vimium/blob/master/README.markdown

Modifier keys are specified as <c-x>, <m-x>, <a-x> for ctrl+x, meta+x, and alt+x respectively. See the next section for instructions on modifying these bindings.

Navigating the current page:

    ?       show the help dialog for a list of all available keys
    h       scroll left
    j       scroll down
    k       scroll up
    l       scroll right
    gg      scroll to top of the page
    G       scroll to bottom of the page
    d       scroll down half a page
    u       scroll up half a page
    f       open a link in the current tab
    F       open a link in a new tab
    r       reload
    gs      view source
    i       enter insert mode -- all commands will be ignored until you hit esc to exit
    yy      copy the current url to the clipboard
    yf      copy a link url to the clipboard
    gf      cycle forward to the next frame

Navigating to new pages:

    o       Open URL, bookmark, or history entry
    O       Open URL, bookmark, history entry in a new tab
    b       Open bookmark
    B       Open bookmark in a new tab

Using find:

    /       enter find mode -- type your search query and hit enter to search or esc to cancel
    n       cycle forward to the next find match
    N       cycle backward to the previous find match

Navigating your history:

    H       go back in history
    L       go forward in history

Manipulating tabs:

    J, gT      go one tab left
    K, gt      go one tab right
    g0         go to the first tab
    g$         go to the last tab
    t          create tab
    x          close current tab
    X          restore closed tab (i.e. unwind the 'x' command)
    T          search through your open tabs

Additional advanced browsing commands:

    ]]      Follow the link labeled 'next' or '>'. Helpful for browsing paginated sites.
    [[      Follow the link labeled 'previous' or '<'. Helpful for browsing paginated sites.
    <a-f>   open multiple links in a new tab
    gi      focus the first (or n-th) text input box on the page
    gu      go up one level in the URL hierarchy
    zH      scroll all the way left
    zL      scroll all the way right

Vimium supports command repetition so, for example, hitting '5t' will open 5 tabs in rapid succession. ESC (or <c-[>) will clear any partial commands in the queue and will also exit insert and find modes.

1.40 (10/27/2012)

- Bugfixes.
- Added options for search engines and regex find.
- Pressing unmapped keys in hints mode now deactivates the mode.

To see older release notes, go to http://github.com/philc/vimium/blob/master/README.markdown
