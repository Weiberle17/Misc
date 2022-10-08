
; Version: 2022.07.01.1
; https://gist.github.com/b251cd8407a379d4965791585887cfce

/* ;region Example

NumpadAdd::AppVol("Spotify.exe", +5)
NumpadSub::AppVol("Spotify.exe", -5)

*/ ;endregion

F19::
AppVol("firefox.exe")
AppVol("discord.exe")
AppVol("spotify.exe")
AppVol("steamwebhelper.exe")
Return

AppVol(App)
{
	static cache := {}, wmi := ComObjGet("winmgmts:")
	Process Exist, % App
		if (!ErrorLevel)
			return
		pid := ErrorLevel
		if (cache.HasKey(App) && cache[App, "pid"] = pid) {
			Volume += cache[App, "vol"]
			cache[App, "vol"] := AppVol_Set(pid, 0)
			return
		}
		cache[App] := {}
		query := "SELECT * FROM Win32_Process WHERE Name = '" App "'"
		for item in wmi.ExecQuery(query) {
			currVol := AppVol_Get(item.ProcessId)
			if (currVol = 0)
			{
				cache[App, "pid"] := item.ProcessId
				cache[App, "vol"] := AppVol_Set(item.ProcessId, 100)
			}
			else {
				cache[App, "pid"] := item.ProcessId
				cache[App, "vol"] := AppVol_Set(item.ProcessId, 0)
			}
		}
}

; TODO: Rewrite this!

; Tweaked versions of:
; https://www.autohotkey.com/boards/viewtopic.php?p=210545#p210545

AppVol_Get(Pid)
{
	IMMDeviceEnumerator := ComObjCreate("{BCDE0395-E52F-467C-8E3D-C4579291692E}", "{A95664D2-9614-4F35-A746-DE8DB63617E6}")
	DllCall(NumGet(NumGet(IMMDeviceEnumerator+0)+4*A_PtrSize), "UPtr",IMMDeviceEnumerator, "UInt",0, "UInt",1, "UPtr*",IMMDevice:=0, "UInt")
	ObjRelease(IMMDeviceEnumerator)
	VarSetCapacity(GUID, 16)
	DllCall("Ole32\CLSIDFromString", "Str","{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}", "UPtr",&GUID)
	DllCall(NumGet(NumGet(IMMDevice+0)+3*A_PtrSize), "UPtr",IMMDevice, "UPtr",&GUID, "UInt",23, "UPtr",0, "UPtr*",IAudioSessionManager2:=0, "UInt")
	ObjRelease(IMMDevice)
	DllCall(NumGet(NumGet(IAudioSessionManager2+0)+5*A_PtrSize), "UPtr",IAudioSessionManager2, "UPtr*",IAudioSessionEnumerator:=0, "UInt")
	ObjRelease(IAudioSessionManager2)
	DllCall(NumGet(NumGet(IAudioSessionEnumerator+0)+3*A_PtrSize), "UPtr",IAudioSessionEnumerator, "UInt*",SessionCount:=0, "UInt")
	loop % SessionCount {
		DllCall(NumGet(NumGet(IAudioSessionEnumerator+0)+4*A_PtrSize), "UPtr",IAudioSessionEnumerator, "Int",A_Index-1, "UPtr*",IAudioSessionControl:=0, "UInt")
		IAudioSessionControl2 := ComObjQuery(IAudioSessionControl, "{BFB7FF88-7239-4FC9-8FA2-07C950BE9C6D}")
		ObjRelease(IAudioSessionControl)
		DllCall(NumGet(NumGet(IAudioSessionControl2+0)+14*A_PtrSize), "UPtr",IAudioSessionControl2, "UInt*",ProcessId:=0, "UInt")
		if (Pid = ProcessId) {
			ISimpleAudioVolume := ComObjQuery(IAudioSessionControl2, "{87CE5498-68D6-44E5-9215-6DA47EF883D8}")
			DllCall(NumGet(NumGet(ISimpleAudioVolume+0)+4*A_PtrSize), "UPtr",ISimpleAudioVolume, "Float*",MasterVolume:=0, "UInt")
			ObjRelease(ISimpleAudioVolume)
		}
		ObjRelease(IAudioSessionControl2)
	}
	ObjRelease(IAudioSessionEnumerator)
	if (MasterVolume ~= "[\d\.]+")
		return Round(MasterVolume * 100)
	return -1
}

AppVol_Set(Pid, MasterVolume)
{
	MasterVolume := Max(0, Min(100, MasterVolume))
	IMMDeviceEnumerator := ComObjCreate("{BCDE0395-E52F-467C-8E3D-C4579291692E}", "{A95664D2-9614-4F35-A746-DE8DB63617E6}")
	DllCall(NumGet(NumGet(IMMDeviceEnumerator+0)+4*A_PtrSize), "UPtr",IMMDeviceEnumerator, "UInt",0, "UInt",1, "UPtr*",IMMDevice:=0, "UInt")
	ObjRelease(IMMDeviceEnumerator)
	VarSetCapacity(GUID, 16)
	DllCall("Ole32\CLSIDFromString", "Str","{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}", "UPtr",&GUID)
	DllCall(NumGet(NumGet(IMMDevice+0)+3*A_PtrSize), "UPtr",IMMDevice, "UPtr",&GUID, "UInt",23, "UPtr",0, "UPtr*",IAudioSessionManager2:=0, "UInt")
	ObjRelease(IMMDevice)
	DllCall(NumGet(NumGet(IAudioSessionManager2+0)+5*A_PtrSize), "UPtr",IAudioSessionManager2, "UPtr*",IAudioSessionEnumerator:=0, "UInt")
	ObjRelease(IAudioSessionManager2)
	DllCall(NumGet(NumGet(IAudioSessionEnumerator+0)+3*A_PtrSize), "UPtr",IAudioSessionEnumerator, "UInt*",SessionCount:=0, "UInt")
	loop % SessionCount {
		DllCall(NumGet(NumGet(IAudioSessionEnumerator+0)+4*A_PtrSize), "UPtr",IAudioSessionEnumerator, "Int",A_Index-1, "UPtr*",IAudioSessionControl:=0, "UInt")
		IAudioSessionControl2 := ComObjQuery(IAudioSessionControl, "{BFB7FF88-7239-4FC9-8FA2-07C950BE9C6D}")
		ObjRelease(IAudioSessionControl)
		DllCall(NumGet(NumGet(IAudioSessionControl2+0)+14*A_PtrSize), "UPtr",IAudioSessionControl2, "UInt*",ProcessId:=0, "UInt")
		if (Pid = ProcessId) {
			ISimpleAudioVolume := ComObjQuery(IAudioSessionControl2, "{87CE5498-68D6-44E5-9215-6DA47EF883D8}")
			DllCall(NumGet(NumGet(ISimpleAudioVolume+0)+3*A_PtrSize), "UPtr",ISimpleAudioVolume, "Float",MasterVolume/100.0, "UPtr",0, "UInt")
			ObjRelease(ISimpleAudioVolume)
		}
		ObjRelease(IAudioSessionControl2)
	}
	ObjRelease(IAudioSessionEnumerator)
	return MasterVolume
}