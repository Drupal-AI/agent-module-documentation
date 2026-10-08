# Responsive Tables Filter — manual setup guide

**Responsive Tables Filter** (`responsive_tables_filter`) makes the **HTML tables editors
create in rich‑text fields behave gracefully on small screens**. Wide data tables that look
fine on a desktop usually overflow or become unreadable on a phone; this module attaches the
[Tablesaw](https://github.com/filamentgroup/tablesaw) JavaScript library (from Filament Group)
and rewrites your `<table>` markup so those tables collapse, stack, or scroll nicely on narrow
viewports — with no custom CSS or JavaScript from you.

It works as a **text‑format filter**. You enable **"Apply responsive behavior to HTML tables."**
on whichever text formats your editors use (Basic HTML, Full HTML, and so on), and every table
with a `<thead>` in those fields becomes responsive. Three display modes are offered:
**stack** (each row becomes a stacked key/value list — the default), **column toggle** (readers
pick which columns to show), and **swipe** (readers swipe horizontally while the first column
stays pinned). You set a site‑wide default mode per format, and editors can override it on an
individual table — or opt a table out entirely — just by adding a CSS class in the editor.

Separately, a small **module settings form** can automatically apply Tablesaw to **all
Views‑generated and theme‑rendered tables** across the site, without touching any text format —
handy if you want responsive behavior everywhere at once. The module has no permissions or
Drush commands of its own and no dependencies beyond Drupal core (10, 11, or 12). The Tablesaw
library is bundled, so there's nothing extra to download.

This guide is written for a **human** enabling the filter in the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — enable the filter on a text format and pick a
   mode, plus the optional settings form for Views and theme tables.

## Where it lives in the admin menu

- **Configuration → Content authoring → Text formats and editors**
  (`/admin/config/content/formats`) — where you switch the filter on for a format and choose
  its default mode.
- **Configuration → Content authoring → Responsive Tables Filter**
  (`/admin/config/content/responsive_tables_filter`) — this module's settings form (its
  `configure` link) for auto‑applying Tablesaw to Views and theme tables.
