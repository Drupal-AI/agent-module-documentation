Generates interactive, self-contained HTML reports from API Orchestrator data, with charts, metrics, health scores and prose insights over a chosen date range.

---

The Reports submodule adds a report generator at `/admin/config/services/api-orchestrator/report`. A `ReportController` provides a configuration page plus generate, stream (for large datasets) and AJAX preview routes. A pipeline of small services — `ReportDataCollector` (parameterized aggregate SQL), `ReportHealthCalculator`, `ReportChartBuilder`, `ReportHtmlBuilder`, `ReportStylesProvider`, `ReportScriptsProvider`, `ReportDocumentBuilder`, and the coordinating `ReportGeneratorService` — assembles a downloadable HTML document with Chart.js visualizations, KPI metrics, computed health/trend scores and narrative insights. Reports accept a date preset or explicit from/to range and optional branding (company name, logo). Requires `api_orchestrator`.

---

- Produce a shareable HTML report of API activity for a date range.
- Include KPI metrics (totals, success rate, average duration, error counts).
- Embed charts for timeline, status distribution, top services/endpoints.
- Show a computed health score and trend for the period.
- Add narrative insights highlighting notable changes.
- Choose a quick date preset (e.g. last 30 days) or set explicit from/to dates.
- Brand the report with a company name and logo.
- Preview the report via AJAX before downloading.
- Stream large reports to avoid memory pressure.
- Generate a self-contained document (inline CSS/JS) suitable for archiving or emailing.
