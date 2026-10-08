# Configure the jQuery UI accordion Views style

There is **no admin settings page** for this module. Everything is configured inside a view.

## Setup

1. Enable `views_accordion` (and its dep `jquery_ui_accordion`).
2. Edit a view. Set **Format → Style** to **jQuery UI accordion** (plugin id `views_accordion`).
3. Set **Format → Row style** to **Fields** (required — the style errors otherwise).
4. Add **at least two fields**. The **first field in order of appearance** becomes the
   accordion **header/trigger**; the remaining fields form the panel shown when it opens.
5. Configure the style options (below).

## Style options

Config lives in the view's `display.*.display_options.style.options` (schema
`config/schema/views.style.views_accordion.schema.yml`). Keys, defaults, meaning:

| Option key | Default | Meaning |
|---|---|---|
| `row-start-open` | `0` | Which row starts open: a row number (1-based), `none`, or `random`. Row count offered = `items_per_page` (or 10 if unlimited). |
| `collapsible` | `0` | Allow all sections closed at once (collapse the active section). |
| `disableifone` | `0` | Do not render the accordion when fewer than 2 results. |
| `animated` | `slide`* | Easing effect (`none`, `linear`, `swing`, or a jQuery UI easing like `easeInOutQuart`). |
| `animation_time` | `300` | Animation duration in milliseconds. |
| `heightStyle` | `auto` | Panel/accordion height: `auto`, `fill`, or `content`. |
| `event` | `click` | Trigger event: `click` or `mouseover`. |
| `use_header_icons` | `TRUE` | Show jQuery UI header icons (uncheck for none). |
| `icon_header` | `ui-icon-triangle-1-e` | Icon class for a closed header. |
| `icon_active_header` | `ui-icon-triangle-1-s` | Icon class for an open header. |
| `grouping[i][use-grouping-header]` | `0` | Use the Views **group** header as the accordion trigger instead of the first field. |

\* `animated` default in `defineOptions()` is `slide`; the form's select does not list
`slide`, so a saved view typically stores one of the offered easing values.

## Validation rules (enforced by the style)

- Row style must be **Fields** ("Views accordion requires Fields as row style").
- To use a group header as the trigger, that grouping must have **"Use rendered output to
  group rows"** enabled.
- Setting `row-start-open` to **None** requires **Collapsible** enabled (otherwise a section
  must be open).

## Behavior notes

- Only one section is open at a time (standard jQuery UI accordion) unless `collapsible`
  lets the active one close.
- The style attaches library `views_accordion/views_accordion.accordion`; picking a
  non-default easing also attaches `core/jquery.ui.effects.core`.
- Multiple/nested accordion views are scoped by the view's `dom_id`, so they don't collide.
