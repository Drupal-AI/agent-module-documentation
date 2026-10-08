<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Viewer imports CSV, XLSX/XLS and PDF files from an upload, path, URL, FTP or SFTP and displays them on your site as tables, charts, calendars, tabs, accordions or PDF previews.

---

Install as usual (`composer require drupal/viewer` then enable it; the FTP/SFTP source plugins and XLSX support depend on the composer libraries `league/flysystem-ftp`, `league/flysystem-sftp-v3` and `phpoffice/phpspreadsheet`, and the `drupal:rest` module is required). Work in two steps. First create a **Source** at `/admin/structure/viewer-source`: pick a file type (**CSV**, **XLSX** or **PDF**) and where the file comes from (**upload**, absolute **path**, remote **URL**, **FTP** or **SFTP**), set parse options such as the CSV delimiter/enclosure, and optionally schedule automatic re-imports on cron with **Slack or email notifications** on success/failure. Then create one or more **Viewers** on that source at `/admin/structure/viewers`: choose a display plugin (Table, DataTables, FooTable, Spreadsheet, Chart.js or ApexCharts chart, Fullcalendar, PDF.js, Tabs, Vertical Tabs or Accordion), configure each column (override the header, hide it, reorder it, or run its values through a **cell converter** like image, link, money, number, percentage or Peity sparkline), and add row **filters**. Finally embed the viewer three ways: place the **Viewer block** at `/admin/structure/block`, add a **Viewer field** to a content type and reference it, or add the **Viewer** button and filter to a **CKEditor 5** text format and insert viewers directly into rich-text content. The data is not imported into Drupal entities — the parsed file is cached and rendered on the fly from a JSON endpoint, so re-importing the source updates every place the viewer appears. Run `drush viewer:import` (alias `vimp`) to trigger scheduled imports from the CLI.

---

- Show a CSV file as an interactive table on a page.
- Preview a PDF inline with PDF.js.
- Render spreadsheet data as a Chart.js or ApexCharts chart (bar, line, pie/doughnut, scatter, bubble, candlestick, treemap).
- Display an XLSX workbook with each worksheet in its own tab.
- Turn a CSV of events into a Fullcalendar calendar.
- Import a data file automatically from a remote URL on a schedule.
- Pull a report over FTP or SFTP and display it.
- Load a file from an absolute server path, using date tokens in the path.
- Let editors upload a CSV/XLSX and show it without a developer.
- Add a searchable, paginated DataTables view of tabular data.
- Group several data sets into tabs, vertical tabs or accordions.
- Override or rename spreadsheet column headers for display.
- Hide or reorder columns without editing the source file.
- Format a column as currency, a percentage, a number or a Peity sparkline.
- Convert URL columns into clickable links or inline images.
- Filter displayed rows by column value, date or list membership.
- Embed a data table or chart inside CKEditor 5 rich-text content.
- Place a data viewer in any region via the Viewer block.
- Reference a viewer from a content type through a Viewer field.
- Get a Slack or email alert when a scheduled import fails.
- Refresh all scheduled sources from the command line with `drush vimp`.
- Show financial, analytical or statistical data that lives in flat files.
- Extend the module with custom display, source, file-type or cell-converter plugins.
