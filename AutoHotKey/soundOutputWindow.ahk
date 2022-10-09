; Audio Output Default cycle
F20:: 
Run, mmsys.cpl
WinWait,Sound
ControlSend,SysListView321,{Up 2}
ControlGet, isEnabled, Enabled,,&Set Default
if(!isEnabled)
{
  ControlSend,SysListView321,{Down}
}
ControlClick,&Set Default
ControlClick,OK
return