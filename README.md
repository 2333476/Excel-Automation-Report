# Process Dashboard – Excel Automation Project

### Project Overview
The Process Dashboard provides an automated, data-driven view of document workflow performance using Excel, SQL Server, Power Query, and VBA.  
It integrates live database queries, KPI metrics, and visual insights into a single dynamic dashboard, with an automated PDF export feature.

---

### Key Features
- Database integration – Automatically retrieves data from SQL Server views (`v_KPI`, `v_WeeklyApprovals`, `v_PhaseDurations`, `v_DocumentsCycle`).
- Dynamic Power Query – Refreshes data on demand, transforming and cleaning inputs before updating visuals.
- Interactive dashboard – Displays KPIs and charts side by side for quick process evaluation.
- One-click export – The `Rafraîchir & Exporter PDF` button refreshes all data and exports a clean, one-page PDF report.
- Modular structure – Includes separate folders for SQL setup and VBA automation code.

---

### Technologies Used
- Microsoft Excel (.xlsm)
- SQL Server (using SQL Server Management Studio)
- Power Query for data connection and transformation
- VBA (Visual Basic for Applications) for automation
- Pivot Charts & Tables for visualization

---

### Dashboard Components
| Section | Description |
|----------|--------------|
| Top KPIs | Displays Backlog, Median Cycle Time (days), and % of documents approved within 14 days |
| Chart 1 – Weekly Approvals | Bar chart of total approvals by week |
| Chart 2 – Average Phase Duration | Bar chart showing average processing time (hours) per workflow phase |
| Chart 3 – Cycle Time by Document | Comparison of documents and their respective cycle durations |
| PDF Button | Executes `RefreshAndExportPDF` macro – refreshes all queries and exports the dashboard to PDF |

---

### How It Works
1. **SQL Setup:**  
   Run the script `ProcessDashboard_DDL.sql` in **SQL Server Management Studio (SSMS)** to create the database, tables, and views.  
   Then, import the datasets (`documents.csv` and `workflowSteps.csv`) into their respective SQL tables (`dbo.Documents` and `dbo.WorkflowSteps`).  
   The views automatically calculate KPI values, weekly aggregates, and phase durations.

2. **Excel Setup:**  
   Connect each Power Query to the corresponding SQL view (`v_KPI`, `v_PhaseDurations`, `v_WeeklyApprovals`, `v_DocumentsCycle`).  
   Ensure that your `Dashboard` sheet matches the query outputs.

3. **Automation:**  
   The VBA script (`RefreshAndExportPDF.bas`) refreshes all Power Query data, adjusts the page layout, and exports the Dashboard as a PDF on the desktop.

---

### Project Structure
