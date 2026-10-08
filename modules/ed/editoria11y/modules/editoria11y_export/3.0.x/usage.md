Editoria11y CSV Exports is a thin submodule that adds filterable bulk-export Views so Editoria11y dashboard reports can be downloaded as CSV via the Views Data Export module.

---

This submodule ships no PHP logic of its own; it exists to declare dependencies (`views_data_export` + `editoria11y`) and install pre-built Views. On install it adds filterable Views for Editoria11y pages-with-issues, recent results, and dismissals, each with a matching Data Export display, and attaches export links to the Editoria11y dashboard so leads can pull the current, filtered report as a CSV file. The provided Views are meant to be customized: you can add filters and fields to fit your site, but you should edit both the Page display and the Data Export display together so the export matches what is shown, and keep a copy of your config since module updates may reset the default Views. It is the right choice when accessibility findings need to leave Drupal for spreadsheets, tickets, or compliance reporting.

---

- Export the Editoria11y dashboard's pages-with-issues list to CSV.
- Download recent accessibility results as a spreadsheet.
- Export the list of dismissed issues for auditing.
- Add export/download links directly on the dashboard.
- Filter results (by issue type, page, date) before exporting.
- Feed accessibility findings into an external ticketing system.
- Produce a periodic compliance report of outstanding issues.
- Share a CSV of issues with an editorial team that lacks dashboard access.
- Customize the export Views with extra fields for your workflow.
- Add site-specific filters to the export while keeping page/export displays in sync.
- Archive point-in-time snapshots of accessibility debt.
- Import Editoria11y data into BI/analytics tools via CSV.
- Give managers a downloadable KPI report of accessibility progress.
- Bulk-export dismissals to review "marked OK" decisions.
- Provide data for a remediation backlog spreadsheet.
