# Simple Datatables Integration — manual setup guide

**Simple Datatables Integration** (`simple_datatables_integration`) brings the
lightweight [Simple DataTables](https://fiduswriter.github.io/simple-datatables/)
JavaScript library to Drupal, adding a new **Views display format** that turns a
view's table into an interactive one — with client‑side sorting, searching, and
pagination — without you writing any JavaScript.

You use it through Views. When you build a view, you choose **Simple DataTable** as
the display format, then open the format settings to configure the library's
options for that table. It is presented by the project as a lighter alternative to
the older DataTables module. Because everything happens in the browser on data the
page has already sent, it is a display convenience: the sorting and searching are
cosmetic and do **not** restrict which rows a visitor can see — access control still
belongs to the view and to Drupal's permissions.

The module has no dependencies beyond Drupal core and no global settings form of
its own — all of its configuration lives in the per‑view format settings. Note that
this project is **not covered by Drupal's security advisory policy**, which is worth
weighing if that matters for your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. Go to **Structure → Views** and add or edit a view that produces a table.
2. In the view's **Format** setting, choose **Simple DataTable**.
3. Click the format's settings link and configure the Simple DataTables options
   (such as which interactive features to enable) for this table.
4. **Save** the view.

The rendered view now behaves as an interactive table — visitors can sort columns,
type to filter, and page through rows entirely in their browser.
