<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Bootstrap Grid adds a toolbar button to CKEditor 5 that inserts Bootstrap rows and columns into the body of a node, letting editors build multi-column layouts inside the WYSIWYG without touching HTML.

---

The module registers one CKEditor 5 plugin, `ckeditor_bs_grid_grid`, whose toolbar item is `bootstrapGrid` and whose PHP class `Drupal\ckeditor_bs_grid\Plugin\CKEditor5Plugin\BsGrid` is configurable per text format. Enabling it on a format at `/admin/config/content/formats` stores four keys under `editor.editor.<format>` → `settings.plugins.ckeditor_bs_grid_grid`: `use_cdn` (default TRUE), `cdn_url` (a grid-only Bootstrap 5 CSS URL used *only inside the editor*), `available_columns` (1–12) and `available_breakpoints` (`xs`…`xxl`). Clicking the button opens a three-step modal served by the route `ckeditor_bs_grid.dialog` (`/ckeditor_bs_grid/dialog/{editor}`, permission `access content`): *Select columns* → *Choose a layout* per breakpoint (plus "Add Container" with default/fluid/wrapper types and a "No Gutters" toggle) → optional *Advanced Settings* for extra classes on the container, wrapper, row and each column. The layouts offered per breakpoint and column count come from the site-wide config object `ckeditor_bs_grid.settings`, whose `breakpoints` map (`xs`/`sm`/`md`/`lg`/`xl`/`xxl`, each with a label, a Bootstrap prefix and a `columns` tree of named layouts such as "Equal Width", "25% / 75%" or "Full Width") is edited at `/admin/config/content/ckeditor_bs_grid` behind the `administer ckeditor_bs_grid` permission. Because the generated markup is plain `<div class="row"><div class="col-md-6">…`, the text format must allow `<div>` with `class` and `data-*` — the plugin declares those elements — and the module even removes core's "redundant source-editing tags" constraint via `hook_config_schema_info_alter()` so a `Source editing` configuration can also list them.

---

- Let editors build a two-column body section without writing HTML.
- Insert a Bootstrap `row` with three equal columns inside a node body.
- Offer a 25% / 75% sidebar-style split inside rich text.
- Restrict a text format to only 1, 2 and 3 column layouts for a simple site.
- Restrict the breakpoints editors can tune to just `xs` and `lg`.
- Wrap a grid in a Bootstrap `container` or `container-fluid` from the dialog.
- Add a full-width wrapper div around a contained grid for background colours.
- Toggle `g-0` (No Gutters) on a row from the dialog.
- Add utility classes (`bg-warning py-5`) to the row or an individual column.
- Use the site's own Bootstrap CSS by turning off the CDN option.
- Point the editor at a specific Bootstrap version by editing the CDN URL.
- Keep the CDN stylesheet scoped to CKEditor only, not the front end.
- Rename the breakpoint labels editors see (e.g. "Phone" instead of "Extra Small").
- Add or remove named layouts for a given breakpoint/column count site-wide.
- Set a default layout selection per breakpoint and column count.
- Give a landing-page text format grid support while leaving Basic HTML plain.
- Combine grid columns with embedded media inside each column.
- Reproduce a Bootstrap marketing layout inside a single body field.
- Avoid Layout Builder or Paragraphs for simple in-body column work.
- Migrate hand-written `<div class="row">` markup into an editable widget.
- Ensure the text format's allowed HTML permits `<div class data-*>` so grids survive filtering.
- Let editors adjust column widths per breakpoint for responsive behaviour.
- Give a multi-site set of formats consistent grid options from one settings page.

