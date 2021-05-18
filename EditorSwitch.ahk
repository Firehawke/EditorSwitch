; This whole mess could be turned into a bunch of environment variables
; called EDITOR1 and EDITOR2, but you'd need to figure out how to tell
; this if it needs to override the terminal or not.

; At least until wt.exe is the standard shell shipping with Windows and it
; stops auto-sending all terminal access to the older terminal.

Process, Exist, Code.exe ; check to see if VSCode is running
{
	; First, parse commandline and prepare to send it through.

	; Some chunks of code from AutoHotkey thread because why reinvent the wheel
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
		; First, let's figure out where vim actually is.

		; ---- Program Files install location (manual installer, WinGet) ----
		Loop, Files, %ProgramFiles%\Vim\vim*, D
		{
			VimExe = %A_LoopFileFullPath%\vim.exe
		}

		; ---- Chocolatey: tools\vim ----
		If (%VimExe% = "")
		{
			; Put the contents of environment variable "ChocolateyToolsLocation" into ChocoTools
			; We'll search for a Vim subfolder from there.
			EnvGet, ChocoTools, ChocolateyToolsLocation
			Loop, Files, %ChocoTools%\vim*, D
			{
				VimExe = %A_LoopFileFullPath%\vim.exe
			}
		}
 
		; Next, let's see if Windows Terminal is present.
		EnvGet, LocalAppData, LOCALAPPDATA
		Loop Files, %LocalAppData%\*.exe, R  ; Recurse into subfolders.
		{
			if A_LoopFileFullPath contains wt.exe
				WinTermLocation := A_LoopFileFullPath
		}
		If (%WinTermLocation% = )
		{
			; We don't have Windows Terminal, so run Vim directly.
			RunWait,"%VinExe%" "%LongPath%"
		}
		Else
		{
			; Windows Terminal, so use it.
			; We don't actually use %WinTermLocation% because Windows Terminal
			; automatically adds itself to the path.
			RunWait,"wt.exe" new-tab %VimExe% "%LongPath%"
		}

		; We are done here, so we exit.        
		Return		
	}
	else
	{
		; VSCode is currently running, so we use it.
		; This should be changed later to do a scan for code.exe since you may
		; have an insider build or Codium that you'd want it to detect and use.
		RunWait,"%A_ProgramFiles%\Microsoft VS Code\Code.exe" "--wait %LongPath%"
		Return
	}
}