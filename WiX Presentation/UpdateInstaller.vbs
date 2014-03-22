On Error Resume Next

Dim MSIobj, MSIdb, MSIView, MSIrecords
Dim propName, propValue
Dim message, errorRec

MSIfile = "HelloWixInstaller\bin\Release\Hello WiX.msi"
propName = "Manufacturer"
propValue = "Wayne Enterprises"

' Open the Installer file
Set MSIobj = CreateObject("WindowsInstaller.Installer")	'http://msdn.microsoft.com/en-us/library/aa369432(v=vs.85).aspx
Set MSIdb = MSIobj.OpenDatabase(MSIfile, 1)							'http://msdn.microsoft.com/en-us/library/aa369434(v=vs.85).aspx

' Modify the property and commit the change
Set MSIView = MSIdb.OpenView ( _
	"UPDATE Property SET Value = '" & _
	propValue & _
	"' WHERE Property = '" & _
	propName & "'" _
)
MSIView.Execute()
MSIdb.Commit()
		
Set MSIdb = Nothing
Set MSIobj = Nothing
Set MSIView = Nothing

If Err.number = 0 Then WScript.Echo "Installer Modified"
