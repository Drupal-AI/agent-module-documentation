# Configure a slideshow

There is **no admin settings form** (`configure` is null). All configuration is **per View
display**, stored in the View's config.

## Steps (Views UI)

1. Enable `views_slideshow` **and** an engine — normally `views_slideshow_cycle` (most users
   want both). Without an engine the style form shows "no Views Slideshow plugin enabled".
2. Edit a View → set the display **Format** to **Slideshow**.
3. Open **Format → Settings**. The form (`Plugin/views/style/Slideshow`) has three sections:
   - **Style** → `Skin` (only `default` ships with core module).
   - **Slides** → `Slideshow Type` (the engine, e.g. `Cycle`) plus that engine's option
     fieldset.
   - **Widgets** → per-location (`top` / `bottom`) checkboxes for each widget type.
4. Set the pager to *Display a specified number of items* or *Display all* (grouping is not
   reliably supported).

## Style option keys (`views.style.slideshow` schema)

Stored under the display's `style.options`:

| Key | Default | Meaning |
|---|---|---|
| `slideshow_skin` | `default` | Skin plugin id |
| `slideshow_type` | `views_slideshow_cycle` | Slideshow type (engine) plugin id |
| `widgets.top` / `widgets.bottom` | — | Control groups placed above/below the slides |
| `row_class_custom`, `row_class_default` | `''`, `TRUE` | Per-row CSS classes |

Each widget entry (`views_slideshow_control_group` → `views_slideshow_widget`) carries:
`enable` (bool), `weight` (sort order), `hide_on_single_slide`, and for controls/pager a
`type` id. The engine's own options live in a sub-mapping keyed by the type id (e.g.
`views_slideshow_cycle` — see the cycle submodule doc for its many keys).

The style sets `usesRowPlugin`, `usesRowClass`, `usesFields = TRUE` and `usesGrouping = FALSE`,
so slides can be rendered entities or arbitrary fields. Settings export with the View via
`drush config:export`.
