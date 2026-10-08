# CKEditor 5 Responsive Table — manual setup guide

**CKEditor 5 Responsive Table** (`ckeditor_responsive_table`) adds a custom
**"Responsive Table"** button to the CKEditor 5 toolbar. Unlike core's built-in
table button, the tables it inserts collapse — or *stack* — gracefully on narrow
screens, so a wide data table stays readable on a phone instead of overflowing or
forcing a horizontal scroll.

When an editor clicks the button, an insert dialog asks for the number of rows and
columns, header placement, and a caption (which can be visible or hidden for
accessibility). Once inserted, all the usual CKEditor table controls are available
— insert and delete rows and columns, split and merge cells, toggle the caption.
On the front end the module loads a small script that reads each cell's header and
turns the table into a stacked, `data-label`-driven layout on small screens, using
the bundled `tabled` library. You get accessible, mobile-friendly tables without
writing any responsive-table CSS yourself.

You enable the button per **text format** (standard CKEditor 5 toolbar
configuration). The module also ships a small admin settings form that tunes how
the front-end script behaves — the CSS selector it targets, caption placement, and
the cell-width thresholds. It has no permissions of its own beyond core's
*Administer site configuration*, and it depends on core's **CKEditor 5** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

- You enable the button on each text format at **Configuration → Content authoring
  → Text formats and editors** (`/admin/config/content/formats`).
- The optional front-end settings form is at **Configuration → Content authoring →
  CKEditor Responsive Table** (`/admin/config/content/ckeditor-responsive-table`).

## How to use it

### Enable the button on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** on a format that uses **CKEditor 5** (for example Basic
   HTML).
3. Drag the **Responsive Table** icon from *Available buttons* into the *Active
   toolbar*.
4. **Save configuration.**

Editors using that format now get the Responsive Table button. Clicking it opens a
dialog to set rows, columns, headers, and a caption; after inserting, the standard
table tools handle further edits. A common approach is to enable it on the formats
your editorial team uses (e.g. Basic HTML) and leave others untouched.

### Optional: tune the front-end behavior

The module works out of the box, but a settings form lets you adjust how tables
respond on the front end. Open **Configuration → Content authoring → CKEditor
Responsive Table** (`/admin/config/content/ckeditor-responsive-table`; needs
*Administer site configuration*). Each field falls back to a sensible shipped
default when left empty:

- **Table selector** — the CSS selector the responsive script applies to. The
  default targets content tables while ignoring the editor's own preview table.
  Narrow it (for example to `.field--type-text-long table`) if you only want
  certain tables to become responsive.
- **Fail class** — the CSS class added to a table that can't be made responsive
  (default `tabled--stacked`).
- **Caption side** — whether captions sit at the **top** (default) or **bottom**
  of the table, site-wide.
- **Large character threshold** — the cell character count treated as a "large"
  width (default 50).
- **Small character threshold** — the cell character count treated as a "small"
  width (default 8).

Click **Save configuration**. The script is loaded automatically on all non-admin
pages, so your public content gets responsive tables while the admin area is left
alone.
