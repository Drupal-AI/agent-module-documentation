# Views Bootstrap Table — manual setup guide

**Views Bootstrap Table** (`bootstrap_table`) adds a new Views display format —
**Bootstrap Table** — that turns any view's results into a rich, interactive data
grid powered by the popular [wenzhixin/bootstrap-table](https://bootstrap-table.com/)
JavaScript library. Instead of a plain HTML table, your view can offer a
client-side search box, sortable columns, client-side pagination, a column
show/hide toggle, export and print buttons, a mobile "card view", a sticky header,
per-column filters, footer sums for numeric columns, and much more — all without
you writing a line of JavaScript.

It works by extending core's Views **Table** style, so you still map fields to
columns and set per-column sorting exactly as usual. The extra behaviour is driven
by `data-*` attributes the module adds to the table, and by the bootstrap-table
JavaScript. It even integrates with **Views Bulk Operations**, adding
click-to-select rows when a bulk-operations column is present.

One thing to know up front: the bootstrap-table library (version 1.27.0) and each
of its extensions are loaded as **external assets from a CDN**
(`cdn.jsdelivr.net`). If your site must self-host all assets, plan to override the
module's library definitions — see the note in [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   note the CDN/self-hosting consideration.

## Where it lives in the admin menu

There is no separate settings page. Everything is configured **inside a view**, at
*Structure → Views → (your view)*, by choosing the Bootstrap Table format and
opening its options. You need the **Administer views** permission, as with any
Views format change.

## How to use it

1. Edit a View and, in a display's **Format** row, choose **Bootstrap Table**.
2. Map your fields to columns just as you would with the standard table style.
3. Open the format's **Settings** to turn on the features you want. The options are
   grouped into sections:
   - **Widgets & Elements** — the search box, table info, a save-state cookie,
     refresh, column toggle, card view, fixed height, number formatting, and a
     token-supported export file name.
   - **Extensions** — auto-refresh, copy rows, print, export, per-column filter
     controls, advanced search, mobile responsiveness, group-by, multi-sort,
     jump-to-page, reorderable/resizable rows, sticky header, load-from-URL and
     server-side pagination, and locale.
   - **Pagination** — pagination style, whether users can change the page length,
     and the default page size.
   - **Bootstrap styles** — striped, bordered, hover, and condensed table styles.
   - **Footer Sum** — total up numeric columns in the table footer, with
     configurable decimal and thousands separators.
4. Save the view. Each enabled option becomes a `data-*` attribute on the rendered
   table and pulls in the matching bootstrap-table sub-library on demand.

Note that in the Views **live preview** some of the interactive elements are
intentionally skipped — view the page itself to see the full grid in action.
