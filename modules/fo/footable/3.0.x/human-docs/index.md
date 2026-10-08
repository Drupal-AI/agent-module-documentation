# FooTable — manual setup guide

**FooTable** (`footable`) brings the jQuery [FooTable](https://footable.com/)
plugin into Drupal as a **Views table style**. Pick it as the format for a table
view and your table becomes mobile-responsive: instead of overflowing off the
screen on a phone, the columns you mark as low-priority collapse into an
expandable detail row at breakpoints you define. You can also switch on
client-side filtering (an instant search box), paging, and column sorting — all
without a page reload.

The plugin's JavaScript and CSS are **not bundled** with the module for licensing
reasons — you download the FooTable library separately into `libraries/footable`
(see [Installation](installation/index.md)). A small global settings form lets you
choose which build of the library to load, and a breakpoints admin area lets you
manage the named pixel breakpoints (xs/sm/md/lg by default) that columns collapse
at. Everything else is configured per view, in the Views UI.

This guide is written for a **human** setting this up in the admin UI. If you want
a terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, add
   the FooTable jQuery library, and enable it.
2. **Global settings, breakpoints, and per-view options** — below on this page.

## Where it lives in the admin menu

- **Global settings**: **Configuration → User interface → FooTable → Settings**
  (`/admin/config/user-interface/footable/settings`).
- **Breakpoints**: **Configuration → User interface → FooTable**
  (`/admin/config/user-interface/footable`).

Both require the **Administer FooTable** (`administer footable`) permission, which
you grant under **People → Permissions**.

## How to use it

### 1. Global settings

On the FooTable settings form you choose which copy of the plugin to load:

- **Plugin variant** — **Standalone** (default) or **Bootstrap**. Use *Bootstrap*
  only if your theme already ships Bootstrap CSS; the standalone build needs Font
  Awesome for its expand/collapse icons.
- **Compression** — **Minified** (production, default) or **Source** (uncompressed,
  for debugging).

These two choices together pick the matching asset library the module attaches to
every FooTable.

### 2. Breakpoints

Breakpoints are named pixel widths at which columns are allowed to collapse. The
module ships four defaults — `xs` (480px), `sm` (768px), `md` (992px), and `lg`
(1200px) — and you can add, edit, or delete your own from the breakpoints admin
area. Every breakpoint is made available to each view, and in the view you assign
individual columns to collapse at whichever breakpoints you pick.

### 3. Per-view options (the Views UI)

This is where most configuration happens.

1. Edit a view whose display shows a table, and set its **Format** to **FooTable**.
2. In the FooTable format settings you can:
   - Assign each column the breakpoint(s) at which it should collapse into the
     detail row (or `all` to always collapse it).
   - Choose which column carries the expand/collapse toggle, and whether to expand
     all rows or just the first by default.
   - Enable **filtering** (with options for debounce delay, minimum characters,
     placeholder text, position, and AND/OR matching).
   - Enable **paging** (page size, count format such as `{CP} of {TP}`, pager
     position) and **sorting**.
   - Persist filter/paging/sort **state** across interactions.
   - When using the Bootstrap variant, add striped/bordered/hover/condensed table
     classes.
3. Save the view.

The module translates those options into the HTML5 `data-*` attributes the FooTable
plugin reads, and column values pulled from rendered fields are stripped of tags
before being placed into those attributes, so there is no untrusted-input risk.

### Reusing FooTable in custom code

Developers can also use a `footable` render element (it extends core's table
element) to get a FooTable-powered table outside of Views — see the sibling
[`agent/`](../agent/api/element.md) docs for the property list.
