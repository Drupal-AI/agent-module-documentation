# Configuration

Views Bootstrap 5 has no global settings page — every option lives inside a view.
You pick a Bootstrap style as a view display's **Format**, then fill in the
settings form for that style. This page walks through selecting a style and the
main options for each one.

## Select a Bootstrap style

1. Go to **Structure → Views** (`/admin/structure/views`) and add or edit a view.
2. In the display, find the **Format** section and click the current format
   (often *Unformatted list* or *Table*).
3. Choose one of the Bootstrap styles — **Cards**, **Carousel**, **Accordion**,
   **Tab**, **Grid**, **List group**, **Dropdown**, **Media object**, or the
   Bootstrap **Table** — and click **Apply**.
4. On the follow-up **settings** dialog, configure the options described below,
   then apply and save the view.

> **Fields vs. rendered rows.** The card, media-object, and table styles let you
> map *specific fields* (title, image, body) to parts of the component, so those
> displays generally need **Fields** rows. Cards also offer a "display row
> content" mode that drops the fully rendered row into the card body instead of
> selected fields.

## The styles and their options

### Cards (`views_bootstrap_cards`)

A responsive group of Bootstrap cards. Choose whether each card is built from
**selected fields** or from **rendered row content**; pick the **title**,
**content**, and **image** fields; set the number of **columns**; optionally wrap
them as a **card group**; and add custom row/column/group CSS classes.

### Carousel (`views_bootstrap_carousel`)

An image/content slider. Options include the **interval** between slides, the
**ride** (autoplay) mode, **keyboard** navigation, slide **indicators**,
**pause-on-hover**, and **captions** (with a breakpoint below which captions
hide). You also choose the **image**, **title**, and **description** fields and
the number of columns.

### Accordion (`views_bootstrap_accordion`)

Collapsible panels. Choose **panel output** — one panel per row, or panels
**grouped** by a field — set the **panel title** field, optionally use the
**flush** style, and pick the open/closed **behavior** (start closed, open all,
or specify which sections open).

### Tab (`views_bootstrap_tab`)

Tabbed content. Choose **tab output** (single vs. grouped), the **tab** field, the
**tab type** (tabs, pills, or list), the **tab position** (top, left, right,
below, justified, or stacked), and whether tabs **fade** on switch.

### Grid (`views_bootstrap_grid`)

A responsive multi-column grid. Set custom grid/row classes and the number of
**columns per breakpoint** (`col_xs` through `col_xxl`) for fine-grained
responsive control.

### List group (`views_bootstrap_list_group`)

A Bootstrap list group. Choose the **title** field and an optional custom
list-group CSS class.

### Dropdown (`views_bootstrap_dropdown`)

A dropdown menu populated from the view's rows.

### Media object (`views_bootstrap_media_object`)

An image beside a heading and body. Choose the **heading**, **image**, and
**body** fields, the **image placement** (left or right), and an image CSS class.

### Table (`views_bootstrap_table`)

Extends the core Views table with Bootstrap styling. Make it horizontally
**responsive** at a chosen breakpoint and apply **Bootstrap styles** — bordered,
borderless, small/condensed, hover, striped — plus a custom class.

## Overriding the markup (optional)

Each style renders through a `views-bootstrap-*.html.twig` template. To change the
markup, copy the relevant template into your theme's `templates/` folder and edit
it. The module also registers per-view and per-display **theme suggestions** — for
example `views-bootstrap-cards--frontpage.html.twig` — so you can override a single
view without affecting the rest. See the sibling [`agent/`](../agent/start.md)
docs for the full list of templates and suggestion patterns.

## A note on config export

Because all of these options are stored as part of the view, your Bootstrap-styled
listings are exportable configuration and deploy between environments with your
normal config workflow.
