<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds CSV, JSON, and printable-HTML export of a stored DrupalFit report via an export_type plugin system.

---

DrupalFit Report Export is an optional submodule of DrupalFit (depends on `drupalfit:drupalfit`). It
provides a single download route, `/admin/reports/drupalfit-report/export/{format}/{report_id}`, that
loads a saved `fit_report_history` report and streams it in the requested format. Three `export_type`
plugins ship — `csv`, `json`, and `pdf` (a standalone printable HTML page). When the submodule is
enabled, DrupalFit's report page shows export buttons for each discovered format. Access is gated by the
`export drupalfit reports` (or `view drupalfit reports`) permission. A runtime check reports whether a
PDF library (TCPDF, mPDF, or Dompdf) is installed; without one, the "PDF" export produces printable HTML.

---

- Export the latest DrupalFit report to CSV for spreadsheets or ticketing systems.
- Export a specific historical report by passing its `report_id` in the export URL.
- Export a report to JSON for pipelines, dashboards, or archival.
- Produce a printable HTML/"PDF" report to hand to clients or stakeholders.
- Add export buttons to the DrupalFit report page automatically once the submodule is enabled.
- Gate report downloads with the dedicated `export drupalfit reports` permission.
- Flatten grouped findings into a one-row-per-finding CSV with metadata and group-score columns.
- Strip HTML and normalize whitespace from finding messages so CSV cells stay clean and safe.
- Serialize the complete report data structure (scores, groups, findings, metadata) as pretty JSON.
- Render a self-contained HTML export that inlines the report CSS/JS for offline viewing or printing.
- Feed exported JSON/CSV into CI to track a site's score over time.
- Register a custom `export_type` plugin from another module to add a new export format.
- Configure a default export format, preferred PDF library, and max export size via
  `drupalfit_report_export.settings`.
- Provide auditors a downloadable, timestamped snapshot of a site's audit results.
