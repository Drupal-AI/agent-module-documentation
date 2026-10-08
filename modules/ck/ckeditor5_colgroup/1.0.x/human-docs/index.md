# CKEditor5 colgroup — manual setup guide

**CKEditor5 colgroup** (`ckeditor5_colgroup`) teaches CKEditor 5 about the
`<colgroup>` and `<col>` HTML table elements. These elements let you define
column-level styling and widths for a table, but CKEditor 5's table plugin has a
bug that strips them out — so even if you add them by hand in **Source editing**,
they disappear when the table plugin is active. This module defines a schema and
converter for `colgroup`/`col` so those elements survive editing and can be added
manually through Source editing.

It is a narrowly targeted workaround, most useful on sites that need
column-group markup but do **not** use CKEditor 5's interactive table column
resizing. There is no toolbar button and nothing to click; the module works
behind the scenes so that `<colgroup>`/`<col>` you type in Source editing is
preserved rather than deleted.

Being a bug workaround, the module is explicitly meant to become obsolete: if the
upstream CKEditor issue (#3397556) is fixed, it will no longer be needed. It
depends only on core's CKEditor 5 module and runs on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** and no button to add. Enabling the module is
all it takes; you then add `colgroup`/`col` via Source editing, described below.

## How to use it

1. Make sure the **Source editing** button is available in your CKEditor 5 text
   format at **Administration → Configuration → Content authoring → Text formats
   and editors** (`/admin/config/content/formats`), and that the format's allowed
   HTML tags permit `<colgroup>` and `<col>` (with the attributes you need) so
   they are not stripped by the filter.
2. While editing content, insert your table as usual, then open **Source editing**
   and add the `<colgroup>` and `<col>` markup for the columns.
3. Save. With this module enabled, the elements are preserved rather than removed
   by the table plugin.
