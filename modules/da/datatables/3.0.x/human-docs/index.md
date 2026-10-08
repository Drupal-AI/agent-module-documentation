# DataTables — manual setup guide

**DataTables** (`datatables`) integrates the popular jQuery DataTables plugin into
Drupal **Views**. It gives you a new Views display format — "DataTables" — that turns
an ordinary Views table into an interactive one with a client-side search box, instant
column sorting, and paging, all without writing a line of JavaScript.

You build the view exactly as you normally would (add your fields, filters and sort),
then choose **DataTables** as the format instead of the plain Table style. From there
a rich set of options lets you toggle the search box and the "Displaying 1–10 of 57"
info line, save each user's table state between reloads, add copy/print/export buttons,
hide or make columns expandable, set a default sort, control page length, align columns,
and add per-column filters.

The one thing to be aware of is that DataTables needs the **jQuery DataTables
JavaScript library** at runtime. You can either host it locally in your site's
`/libraries` folder or load it from a CDN — a single **Use CDN** setting switches
between the two, and a status-report check tells you whether the local library is
present. The module depends on core's **Views** module.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, install
   the DataTables JavaScript library (local or CDN), and enable it.
2. [Configuration](configuration/index.md) — the Use CDN setting, and applying the
   DataTables format to a view with its options.

## How to use it

Once the module and the DataTables library are in place, build a view with **Fields**
(**Configuration → Views**), then in **Format** choose **DataTables** and open its
settings to pick the options you want. The full option list — search box, info line,
state saving, export buttons, pagination, per-column settings, hidden/expandable
columns and filters — is covered on the [Configuration](configuration/index.md) page.

> **Tip:** because DataTables paginates in the browser, set the view's own pager to
> show all items so DataTables has the full data set to work with.

## Where it lives in the admin menu

- **Settings:** the single Use CDN setting is at **Configuration → Web services →
  DataTables** (`/admin/config/services/datatables`).
- **Per-view options:** chosen on each view's **Format** settings under
  **Configuration → Views**.
- **Library status:** reported on **Reports → Status report**
  (`/admin/reports/status`).
