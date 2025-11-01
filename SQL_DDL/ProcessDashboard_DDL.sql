-- SQL DDL for Process Dashboard

CREATE DATABASE ProcessDashboard;
GO
USE ProcessDashboard;
GO

CREATE TABLE dbo.Documents (
  DocumentId INT PRIMARY KEY,
  CreatedAtUtc DATETIME2 NOT NULL,
  ApprovedAtUtc DATETIME2 NULL,
  Status VARCHAR(32) NOT NULL
);
GO

CREATE TABLE dbo.WorkflowSteps (
  StepId INT IDENTITY PRIMARY KEY,
  DocumentId INT NOT NULL,
  Phase VARCHAR(64) NOT NULL,
  StartedAtUtc DATETIME2 NOT NULL,
  EndedAtUtc DATETIME2 NULL,
  CONSTRAINT FK_WorkflowSteps_Documents FOREIGN KEY (DocumentId)
      REFERENCES dbo.Documents(DocumentId)
);
GO

CREATE VIEW dbo.v_DocumentsCycle AS
SELECT
  d.DocumentId,
  DATEDIFF(DAY, d.CreatedAtUtc, d.ApprovedAtUtc) AS CycleDays,
  CASE WHEN d.ApprovedAtUtc IS NOT NULL AND DATEDIFF(DAY, d.CreatedAtUtc, d.ApprovedAtUtc) <= 14 THEN 1 ELSE 0 END AS Within14d
FROM dbo.Documents d
WHERE d.ApprovedAtUtc IS NOT NULL;
GO

CREATE VIEW dbo.v_WeeklyApprovals AS
SELECT
  CAST(DATEADD(DAY, - (DATEPART(WEEKDAY, ApprovedAtUtc)+5) % 7,
       CAST(ApprovedAtUtc AS DATE)) AS DATE) AS WeekStart,
  COUNT(*) AS ApprovedCount
FROM dbo.Documents
WHERE ApprovedAtUtc IS NOT NULL
GROUP BY CAST(DATEADD(DAY, - (DATEPART(WEEKDAY, ApprovedAtUtc)+5) % 7,
       CAST(ApprovedAtUtc AS DATE)) AS DATE);
GO

CREATE VIEW dbo.v_PhaseDurations AS
SELECT
  Phase,
  AVG(CAST(DATEDIFF(SECOND, StartedAtUtc, EndedAtUtc) AS FLOAT))/3600.0 AS AvgHours
FROM dbo.WorkflowSteps
WHERE EndedAtUtc IS NOT NULL
GROUP BY Phase;
GO

CREATE VIEW dbo.v_KPI AS
SELECT
  (SELECT COUNT(*) FROM dbo.Documents WHERE ApprovedAtUtc IS NULL) AS Backlog,
  (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY CycleDays)
     FROM dbo.v_DocumentsCycle) AS MedianCycleDays,
  (SELECT CASE WHEN COUNT(*) = 0 THEN 0.0 ELSE 100.0*SUM(Within14d)/COUNT(*) END
     FROM dbo.v_DocumentsCycle) AS PctWithin14d;
GO
