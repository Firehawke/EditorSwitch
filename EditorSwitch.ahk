; This whole mess could be turned into a bunch of environment variables
; called EDITOR1 and EDITOR2, but you'd need to figure out how to tell
; this if it needs to override the terminal or not.

; At least until wt.exe is the standard shell shipping with Windows and it
; stops auto-sending all terminal access to the older terminal.

Process, Exist, Code.exe ; check to see if VSCode is running
{
	; First, parse commandline and prepare to send it through.

	; This chunk of code from AutoHotkey thread because why reinvent the wheel
	; if someone already has perfectly working code ready to go?
	; https://autohotkey.com/board/topic/33659-if-program-is-not-running-then-start/

	Loop %0%
	{
		GivenPath := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
		Loop %GivenPath%, 1
		LongPath := A_LoopFileLongPath
	}
	If (ErrorLevel = 0) ; VSCode is not running
	{
		; VSCode is not running, so use Vim instead.
		RunWait,"wt.exe" new-tab C:\tools\vim\vim82\vim.exe "%LongPath%"
		Return		
	}
	else
	{
		; VSCode is currently running, use it
		RunWait,"%A_ProgramFiles%\Microsoft VS Code\Code.exe" "%LongPath%"
	Return
	}
}