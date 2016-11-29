Dim FileName,DesFileName
Dim Oldpatrn,Newpatrn,Text
Dim Args

set Args=wscript.arguments


FileName=Args(0)
'WScript.Echo FileName
Oldpatrn=Args(1)
Oldpatrn =Replace(Oldpatrn,"|",chr(34))
'WScript.Echo Oldpatrn
Newpatrn=Args(2)
Newpatrn =Replace(Newpatrn,"|",chr(34))
'WScript.Echo Newpatrn
DesFileName=Args(3)
'WScript.Echo DesFileName

Function ReadAllTextFile(filename)
  Const ForReading = 1, ForWriting = 2
  Dim fso, f
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set f = fso.OpenTextFile(filename, ForReading)
  ReadAllTextFile =   f.ReadAll
  f.close
End Function

Function ReplaceTest(str,patrn, replStr)
  Dim regEx, str1               
  Set regEx = New RegExp               
  regEx.Pattern = patrn   
  regEx.Global = True            
  'regEx.IgnoreCase = True               
  ReplaceTest = regEx.Replace(str, replStr)        
End Function

Sub WriteToTextFile(filename,textstr)
   Const ForReading = 1, ForWriting = 2, ForAppending = 8
   Dim fso, f
   Set fso = CreateObject("Scripting.FileSystemObject")
   Set f = fso.OpenTextFile(filename, ForWriting, True)
   f.Write textstr
   f.Close
End Sub

Text = ReadAllTextFile(filename)

Text = ReplaceTest(Text,Oldpatrn,Newpatrn)


Text = ReplaceTest(Text,",amqp",""",""amqp")
'WScript.Echo text

WriteToTextFile DesFileName,text
