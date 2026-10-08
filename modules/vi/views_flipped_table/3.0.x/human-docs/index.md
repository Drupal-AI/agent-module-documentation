# Views Flipped Table — manual setup guide

**Views Flipped Table** (`views_flipped_table`) adds a new Views display style,
**Flipped Table**, that transposes a normal Views table: each result becomes a *column*
and each field becomes a *row*. That is exactly the shape you want for side‑by‑side
comparisons — a product comparison grid, a pricing‑plan matrix, a spec sheet with
attributes down the left and items across the top.

Under the hood it is just another table format. The Flipped Table style extends Drupal's
core Table style and reuses all of its behaviour, so sortable columns, a caption, sticky
headers, and per‑column settings all still work — the module simply flips the rows and
columns when it renders. It adds a single extra option (whether to treat the first field
as the table header) and hides the couple of core options that don't make sense once a
table is transposed.

Because it is a pure display style, there is **no configuration form, no permissions, no
Drush commands, and no settings of its own** — you turn it on by choosing it as the
**Format** of any view. It depends only on core's **Views** module and works on Drupal
10.3+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

There is no dedicated admin page. The style appears inside the **Views** UI
(**Structure → Views**, `/admin/structure/views`): when you edit a view and change its
**Format**, "Flipped Table" is offered alongside "Table", "Grid", and the rest.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit a view at **Structure → Views** (or create one).
3. Click the view's **Format** setting and choose **Flipped Table**, then apply.
4. In the style settings you get all the usual core **Table** options — columns,
   sortable, separators, caption, sticky header — **plus** one extra checkbox:
   - **Show the first field as the table header** (on by default) — renders the first
     field's row inside `<th>` header cells instead of plain `<td>` cells. Untick it if
     you don't want a header row/column.
5. Save the view.

Any existing table view can be switched to Flipped Table just by changing the Format —
all the inherited table options stay valid, so nothing else needs reconfiguring. The
core "row class" / "default row class" options are hidden, since they don't map cleanly
onto a flipped layout.

To change the markup, override the `views-view-flipped-table.html.twig` template in your
theme (theme hook `views_view_flipped_table`). The module ships no CSS of its own, so
styling is entirely up to your theme.
