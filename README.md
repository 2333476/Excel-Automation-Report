# Bombardier Tech Publications Dashboard 📊

### 🎯 Project Overview
This project automates the monitoring and reporting of technical publication processes for Bombardier.  
It uses **Excel + Power Query + VBA** to clean data, calculate KPIs, and export weekly reports automatically.

---

### ⚙️ Features
✅ Automated data refresh (Power Query + Macro)  
✅ Key performance indicators (KPIs):
- Backlog of non-approved documents
- Median cycle time (in days)
- % of on-time documents (≤ 14 days)
✅ Interactive Power Query transformations
✅ Dynamic visual charts:
- Documents approved per week
- Average step duration per workflow phase
✅ One-click PDF export button (`Rafraîchir & Exporter PDF`)

---

### 🧩 Tools and Technologies
- **Microsoft Excel (.xlsm)**
- **Power Query**
- **VBA (Visual Basic for Applications)**
- **Pivot Tables and Charts**

---

### 🧠 How It Works
1. Data from `documents.csv` and `workflows.csv` is imported via Power Query.
2. Power Query transforms raw data:
   - Adds `CycleDays` and `StepDurationHours` columns.
   - Standardizes document statuses.
3. The Dashboard sheet calculates KPIs using formulas and displays charts.
4. A VBA macro (`RefreshAndExportPDF`) automatically refreshes data and exports the Dashboard as a PDF.

---

### 🖱️ VBA Macro Overview
```vba
Sub RefreshAndExportPDF()
    ThisWorkbook.RefreshAll
    Application.Wait (Now + TimeValue("0:00:05"))
    Sheets("Dashboard").Activate
    Dim pdfPath As String
    pdfPath = ThisWorkbook.Path & "\Dashboard_Report.pdf"
    ActiveSheet.ExportAsFixedFormat Type:=xlTypePDF, Filename:=pdfPath, OpenAfterPublish:=True
End Sub
