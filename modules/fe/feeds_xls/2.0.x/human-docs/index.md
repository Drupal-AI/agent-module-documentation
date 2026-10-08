# Feeds XLS — manual setup guide

**Feeds XLS** (`feeds_xls`) adds an XLS/XLSX *parser* plugin to the
[Feeds](https://www.drupal.org/project/feeds) module, so you can import from
Microsoft Excel spreadsheets and map their columns to your entity fields — much as
you would with Feeds' built-in CSV parser, but reading a native Excel file.

On Drupal 10 and 11 it targets Excel's XLS format specifically and integrates
directly with Feeds. A handy option lets you **choose which sheet** in the workbook
to process. If you need the XLSX format instead, use the separate
[Feeds XLSX](https://www.drupal.org/project/feeds_xlsx) module.

Because the parser reads spreadsheets server-side, run imports as trusted users and
validate the data you're bringing in.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Feeds.

There is **no site-wide configuration page** for this module — it has no settings
form of its own. You select the parser (and its sheet option) on each Feed type, as
described below.

## Where it lives in the admin menu

Feeds XLS adds no admin page of its own. You use it from a Feed type at
**Structure → Feed types** (`/admin/structure/feeds`), where it appears in the
**Parser** list.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Feed types** and add a new Feed type, or edit an existing
   one.
3. Set the Feed type's fetcher to one that supplies a file (for example the upload
   fetcher), and change the **parser** to the XLS parser.
4. Configure the parser options — notably which **sheet** of the workbook to
   process.
5. Map the spreadsheet's columns to your target entity's fields in the processor
   section, then create a feed of that type and import.
