Sub RefreshAndExportPDF()
    Dim ws As Worksheet
    Dim filePath As String

    Set ws = ThisWorkbook.Sheets("Dashboard")

    ' 1) Refresh data
    ThisWorkbook.RefreshAll
    Application.Wait Now + TimeValue("0:00:05")

    ' 2) Define what to print (title + both charts)
    '    >>> ADJUST this range to fully include your dashboard <<<
    ws.PageSetup.PrintArea = ws.Range("A1:J28").Address

    ' 3) Page setup for a clean one-page PDF
    With ws.PageSetup
        .Orientation = xlLandscape
        .Zoom = False
        .FitToPagesWide = 1
        .FitToPagesTall = 1
        .LeftMargin = Application.InchesToPoints(0.3)
        .RightMargin = Application.InchesToPoints(0.3)
        .TopMargin = Application.InchesToPoints(0.5)
        .BottomMargin = Application.InchesToPoints(0.5)
        .HeaderMargin = Application.InchesToPoints(0.25)
        .FooterMargin = Application.InchesToPoints(0.25)
        .CenterHorizontally = True
        .CenterVertically = True
        .PrintGridlines = False
        .PrintHeadings = False
    End With

    ' 4) Export
    filePath = Environ("USERPROFILE") & "\Desktop\ProcessDashboard.pdf"
    ws.ExportAsFixedFormat Type:=xlTypePDF, Filename:=filePath, _
        Quality:=xlQualityStandard, IncludeDocProperties:=True, _
        IgnorePrintAreas:=False, OpenAfterPublish:=True

    MsgBox " PDF exporté proprement sur une page.", vbInformation
End Sub
