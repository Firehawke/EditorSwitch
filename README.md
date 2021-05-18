# EditorSwitch
AutoHotkey script to switch editors depending on if VSCode is running or not.
## About

Sometimes you don't want to use VSCode for whatever reason-- because you might need to spare CPU cycles for a compile, or perhaps it's not currently running and you'd like to just get a quick editor job done.

This AutoHotkey script calls code.exe if it's already running. If it isn't, it goes straight to vim. 

## Usage
Put a compiled copy of this script in a folder such as c:\utils. You can then tell other programs (e.g. Git via the GITEDITOR or EDITOR environment variables) to use EditorSwitch.exe as the editor binary, and it'll pass along all command line parameters to the editor.

## Known Issues
In this initial version, the paths and executables for the editors are hardcoded. This could be improved by using environment variables. Since I'm installing vim via Chocolatey, there may be a shim exe file that can end up in the path. It didn't appear to have created one in my case, and that's why the hardcoded path.

Issues will most likely be fixed later when I have more time to play with this.
