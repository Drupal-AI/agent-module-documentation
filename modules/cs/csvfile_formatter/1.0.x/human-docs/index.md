# CSV File Formatter — manual setup guide

**CSV File Formatter** (`csvfile_formatter`) is a field formatter that takes a
CSV file uploaded through a standard Drupal **File** field and renders it as a
themable HTML table right on the page — instead of showing a download link that
makes the reader open a file just to see a few numbers.

It fits data that is produced somewhere else and published as-is: a results
table, a price list, a timetable, a register, a monthly statistics release. The
data lives in a spreadsheet because that is where whoever maintains it works, so
the publisher's workflow stays simple — upload the new CSV and the page is always
current, with no migration to build and no table to paste into a WYSIWYG editor.

The module works entirely through Drupal's **Manage display** screen — it has
**no configuration page of its own**. You add a File field, switch its display
format to *CSV File as Table*, and adjust the formatter's options there. It
depends only on core's File field. Optionally, it can use the DataTables
JavaScript library (loaded from a CDN, or installed locally) to add
sorting/searching to the rendered table.

A few things are worth knowing up front. A rendered table is only accessible if
it is genuinely marked up as one, so keep a proper header row. CSV is
under-specified — encoding, delimiter and quoting vary between the tools that
produce these files (a spreadsheet exported in one locale uses semicolons where
another uses commas), so the formatter's options need to match your actual files.
And because the file is untrusted input rendered into a page, cell contents are
escaped.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) add the DataTables library.

There is **no configuration page** for this module. Everything is set up on your
File field's display, described in "How to use it" below.

## How to use it

1. On a content type (or any fieldable entity), add a **File** field through
   **Structure → Content types → *(your type)* → Manage fields**, and allow the
   `csv` extension on it.
2. Go to that bundle's **Manage display** tab.
3. For the File field, choose the **CSV File as Table** format.
4. Click the format's gear/settings icon to configure the options. These let you:
   - optionally show a **download link** to the original file alongside the table;
   - control how rows and fields are processed;
   - provide **CSS classes** for the table and its parts, so your theme can style
     it;
   - enable **Smart URL handling**, which renders `https` URLs, email addresses,
     and a limited Markdown link syntax (`[text](url)`) found in the CSV as real
     links.
5. Save. Now any correctly formatted CSV uploaded through that field is displayed
   as an HTML table.
