# Table Bootstrap Filter — manual setup guide

**Table Bootstrap Filter** (`table_bs_filter`) is a text-format filter that automatically
adds Bootstrap table styling to every `<table>` in your rich-text content. Editors keep
authoring tables normally in the WYSIWYG; on output the filter wraps each table in a
responsive container and adds the Bootstrap `table` class (plus any modifier classes you
switch on) — no hand-editing of HTML classes required.

Because it is a filter, you enable and tune it **per text format** (for example on *Full
HTML*). Five checkboxes let you decide the look: borders, compact spacing, row hover
highlighting, zebra striping, and whether to strip hard-coded cell widths and heights so
Bootstrap controls sizing. Existing `id`, `class`, `style` and `dir` attributes on your
tables are preserved, and the whole table is wrapped in `<div class="table-responsive">` so
wide tables scroll horizontally on small screens.

The module depends only on core's **Editor** and **Filter** modules, and it assumes your
theme is Bootstrap-based (it adds the `table-*` classes; your theme's CSS provides the actual
styling). It transforms output only — your stored content is never changed.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There is no central settings page — the filter is configured on each text format you want it
to act on.

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and **edit a format** (e.g. *Full HTML*).
2. Under **Enabled filters**, tick **"Add Bootstrap Class to any tables"**.
3. In **Filter settings**, open the *Table Bootstrap Filter* section and choose the options
   you want (all off by default):

   | Option | What it does |
   |---|---|
   | **Bordered** (`table_bordered`) | Adds `table-bordered` when on; adds `table-borderless` when off. |
   | **Condensed** (`table_condensed`) | Adds `table-condensed` for tighter, more compact cells. |
   | **Row hover** (`table_row_hover`) | Adds `table-hover` to highlight the row under the cursor. |
   | **Striping** (`table_striping`) | Adds `table-striped` for zebra-striped rows. |
   | **Remove width/height** (`remove_width_height`) | Strips inline `width`/`height` from the table and its cells so Bootstrap governs layout. |

4. Check the **filter processing order** on the same page. Place this filter so it runs on the
   final table markup — **after** the "Limit allowed HTML tags" filter, and make sure that
   filter permits `<table>`, `<div>`, and the `class` attribute, otherwise the wrapper and
   classes will be stripped.
5. **Save configuration**.

From then on, any table authored in that format renders with the Bootstrap classes and the
responsive wrapper. To style a specific format only (say a "Full HTML" used by trusted
editors), enable the filter on that format alone. Repeat per format if you want different
table styling in different places.
