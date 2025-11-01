# Excel Process Automation Dashboard 📊

### 🎯 Project Overview
This project automates the monitoring and reporting of document workflow performance using **Excel**, **Power Query**, and **VBA**.  
It provides real-time metrics, charts, and an automatic PDF export feature — all within a single dashboard.

---

### ⚙️ Features
✅ Automated data refresh (Power Query + VBA macro)  
✅ Key performance indicators (KPIs):
- Backlog of non-approved documents  
- Median cycle time (in days)  
- % of documents approved within 14 days  

✅ Interactive charts and pivot tables:
- Documents approved per week  
- Average step duration per workflow phase  

✅ One-click PDF export button (`Rafraîchir & Exporter PDF`)

---

### 🧩 Tools and Technologies
- **Microsoft Excel (.xlsm)**  
- **Power Query** for data transformation  
- **VBA (Visual Basic for Applications)** for automation  
- **Pivot Tables and Charts** for visualization  

---

### 🧠 How It Works
1. Data is imported from `documents.csv` and `workflows.csv` through Power Query.  
2. Power Query cleans and transforms the data:
   - Calculates new columns like `CycleDays` and `StepDurationHours`.  
   - Normalizes workflow and document status fields.  
3. The Dashboard sheet calculates and displays all KPIs.  
4. A VBA macro refreshes data, updates the visuals, and exports the Dashboard as a PDF report.

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
