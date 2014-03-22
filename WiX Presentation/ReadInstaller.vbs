On Error Resume Next

Dim MSIobj, MSIdb, MSIView, MSIrecords
Dim propName, propValue
Dim message

MSIfile = "HelloWixInstaller\bin\Release\Hello WiX.msi"

' Open the Installer file
Set MSIobj = CreateObject("WindowsInstaller.Installer")	'http://msdn.microsoft.com/en-us/library/aa369432(v=vs.85).aspx
Set MSIdb = MSIobj.OpenDatabase(MSIfile, 0)							'http://msdn.microsoft.com/en-us/library/aa369434(v=vs.85).aspx

' Retrieve the list of properties and values
Set MSIView = MSIdb.OpenView("SELECT Property,Value FROM Property")
MSIView.Execute()

PropCount = 0

' Loop through and display all the properties and their values
Set MSIrecords = MSIView.Fetch
message = ""
propValue = MSIrecords.StringData(2)
propName = MSIrecords.StringData(1)

Do While Err.number = 0
	If propName <> "" Then
		propCount = propCount + 1
		message = message & propName & " = " & propValue & vbNewLine & vbNewLine
	End If

	Set MSIrecords = MSIView.Fetch
	propName = MSIrecords.StringData(1)
	propValue = MSIrecords.StringData(2)
Loop

WScript.Echo message

Set MSIdb = Nothing
Set MSIobj = Nothing
Set MSIView = Nothing
