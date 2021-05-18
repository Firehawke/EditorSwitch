# EditorSwitch
AutoHotkey script to switch editors depending on if VSCode is running or not.
## About

Sometimes you don't want to use VSCode for whatever reason-- because you might need to spare CPU cycles for a compile, or perhaps it's not currently running and you'd like to just get a quick editor job done.

This AutoHotkey script calls code.exe if it's already running. If it isn't, it goes straight to vim. 

## Usage
Put a compiled copy of this script in a folder such as c:\utils. You can then tell other programs (e.g. Git via the GITEDITOR or EDITOR environment variables) to use EditorSwitch.exe as the editor binary, and it'll pass along all command line parameters to the editor.

## Known Issues

* In this initial version, some paths/executables for the editors are hardcoded. This could be improved by using environment variables like EDITOR1, EDITOR2. 
* The script attempts to find the use of Windows Terminal, but if you have multiple instances of it (such as Preview and Release) it will go with the LAST one it finds from the set.
* While it similarly attempts to automagically find Vim, there's a chance that may not work on all setups. Open an issue if this hits you.

This script works fine for my usage so fine-tuning it will require seeing setups where it actually does fail. If you have time and inclination to fix anything that happens on different machine configurations, send me a Pull Request.
