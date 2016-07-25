Option Explicit
Dim ObjExec, ObjShell, result
Dim ArrWlanProfiles
Dim strFromProc, strOutput, tmp
 
Set ObjShell = WScript.CreateObject("WScript.Shell")
Set ObjExec = ObjShell.Exec("netsh wlan show profiles")

Do
    strFromProc =  ObjExec.StdOut.ReadLine()
    tmp = split(strFromProc, ":")
    if ubound(tmp) = 1 then
        ArrWlanProfiles = ArrWlanProfiles & Trim(tmp(1)) & vbCRLF
    end if
Loop While Not ObjExec.Stdout.atEndOfStream

If UBOUND(SPLIT(ArrWlanProfiles, vbCRLF)) = 1 Then
    MsgBox("No Profiles found, I will exit now")
    WScript.Quit
End If

result = MsgBox ("Profiles listed below will be deleted!" & vbCRLF & ArrWlanProfiles, vbYesNo + vbCritical , "Are you sure?")

Select Case result
Case vbYes
    For Each tmp In split(ArrWlanProfiles, vbCRLF)
        If tmp <> "" Then
            objShell.Run("netsh wlan delete profile " & tmp)
        End If
    Next
Case vbNo
    MsgBox("Ok, will not do anything")
End Select

unset ObjShell
unset ObjExec
