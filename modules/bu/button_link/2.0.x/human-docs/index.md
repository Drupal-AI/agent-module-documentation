# Button Link — manual setup guide

**Button Link** (`button_link`) adds a display formatter — **"Link as Button"** — for
core Link fields that renders each link as a **Bootstrap‑style button**
(`<a class="btn btn-…">`) instead of a plain text link. It is the quick way to turn
a "Read more", "Buy now", or call‑to‑action link field into a proper button without
custom theming.

Under the hood it extends core's own Link formatter, so it keeps all the standard
link options (trim length, `rel`, open in a new window) and adds button‑specific
ones on the *Manage display* page: the button type (primary, secondary, success,
danger, and so on), a size, a full‑width block option, custom link text, extra CSS
classes, and an optional leading icon. You can configure it differently per view
mode — for example a large primary button in the full view and a small one in the
teaser.

One important note: Button Link only **emits** the Bootstrap `.btn` classes; it does
**not** ship Bootstrap's CSS. The links only look like buttons if your theme loads
Bootstrap (or equivalent `.btn` styles). There is no settings page, permission, or
Drush command — all configuration lives on the field's display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The formatter is configured per field, per view mode, on the *Manage display* page:

1. Go to **Manage display** for the bundle that has the Link field (for example
   `/admin/structure/types/manage/article/display`).
2. On the Link field's row, choose **Link as Button** in the *Format* column.
3. Click the cog to set the options, then **Update** and **Save**.

### The button options

- **Button type** — the colour/style class, one of `btn-default`, `btn-primary`,
  `btn-secondary`, `btn-success`, `btn-info`, `btn-warning`, `btn-danger`,
  `btn-light`, `btn-dark`, or `btn-link`. This is required.
- **Button size** — leave default, or choose `btn-lg`, `btn-sm`, or `btn-xs`.
- **Block level** — when ticked, adds `btn-block` so the button spans the full width
  of its container.
- **Link text** — override text used for every button (leave empty to use the
  link's own title).
- **Additional classes** — extra space‑separated CSS classes added to the `<a>`.
- **Icon class** — classes for a leading `<i>` icon, for example `fa fa-anchor`.
- **Disable button role** — drops the default `role="button"` attribute (useful when
  the anchor is genuinely navigation).

The formatter also inherits core's link settings (trim length, `rel`, target), so
you can, for instance, open the button in a new window or add `rel="nofollow"`.

### Remember the CSS

Because the module ships no CSS, the classes only render as buttons when your theme
provides Bootstrap's `.btn` styles. If your buttons look like plain links, that's
the missing piece.
