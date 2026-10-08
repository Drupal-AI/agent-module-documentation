# Views Data Export — manual setup guide

**Views Data Export** (`views_data_export`) lets any View hand its results back to
the visitor as a **downloadable file** instead of an HTML page — CSV, XML, JSON,
or (with an add‑on) XLS/XLSX. Point it at a listing of nodes, users, taxonomy
terms, orders, or search results and it turns that same View into a "Download CSV"
link or a one‑click report, respecting the View's fields, filters, sorts,
contextual arguments, and access rules along the way.

It works by adding a new Views **display** called *Data export* and a matching
**style** that serializes the rows into a file. You add a Data Export display to a
View, choose one or more formats, and expose it either as its own standalone
download URL or as an attachment/link hanging off a normal page display. For big
jobs it can generate the file in **batches**, streaming tens of thousands of rows
without exhausting memory, and optionally saving the file and redirecting when it
finishes. Each format has its own options — CSV delimiter, enclosure, header row,
UTF‑8 BOM for Excel, HTML stripping; XML root and item node names; and so on.

The module works as soon as you enable it, but it does nothing until you add a
Data Export display to a View — there is **no global settings page**. Everything
is configured per View, inside the Views UI. It depends on core's **Views** and
**REST** modules plus the **CSV Serialization** module (`csv_serialization`,
pulled in automatically by Composer), and needs **PHP 8.1 or newer**. Two optional
extras widen what it can do: install **XLS Serialization**
(`drupal/xls_serialization`) to add Excel (XLS/XLSX) export, and **Search API**
(`drupal/search_api`) if you want to export Search API‑backed Views. There are no
submodules. A Drush command (`vde`) can run an export headless for cron or
scripting, and developers can adjust each row before it is written with
`hook_views_data_export_row_alter()`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and add optional format support.

## How to use it

Views Data Export has no configuration form of its own — you turn it on by adding
a Data Export display to a View:

1. Go to **Structure → Views** (`/admin/structure/views`) and edit the View whose
   results you want to export (or add a new one).
2. Next to **Displays**, click **Add** and choose **Data export**. This creates a
   new display alongside your Page or Block.
3. Give the display a **Path** to make it a standalone download URL (for example
   `/reports/members.csv`), or use **Attach to** to hang the export off an
   existing page display so a download link/icon appears on that page.
4. In the display's **Format** settings, tick the format(s) you want — **CSV**,
   **XML**, **JSON**, or **XLS/XLSX** (XLS appears only if you installed the XLS
   Serialization add‑on). Each format has its own options:
   - **CSV** — delimiter, enclosure, escape character, whether to strip HTML and
     trim values, encoding, a **UTF‑8 BOM** so Excel opens it cleanly, and whether
     to include the header row.
   - **XML** — encoding, the root and item node names, and pretty‑printing.
5. For large result sets, set the **export method** to **batch** and tune the
   batch size and row limit so the file streams without timing out; you can also
   choose where the user is redirected once the export completes.
6. Save the View and visit the export path (or the page you attached it to) — the
   file downloads.

For scheduled or scripted exports, developers can run a Data Export display from
the command line with `drush vde <view> <display>`; see the
[`agent/`](../agent/start.md) docs for the Drush command and row‑alter hook.
