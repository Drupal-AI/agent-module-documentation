# Theming the accordion output

## Theme hook & template

The style renders through theme hook **`views_accordion_view`**, default template
**`templates/views-accordion-view.html.twig`**. Preprocess:
`template_preprocess_views_accordion_view()` (in `views_accordion.module`) delegates to core's
`template_preprocess_views_view_unformatted()`, so the same variables are available.

Available Twig variables:

- `title` — the group title (only set when Views grouping is used; may be empty).
- `rows` — the row items, each with `attributes` and `content`.
- `view` — the view object.
- `default_row_class` — whether to add the default `views-row` class.

Override by copying `views-accordion-view.html.twig` into your theme (rename with view/display
suggestions as usual for Views templates) and clearing caches.

## Required markup structure (do not remove)

The accordion JS depends on the template's structure:

- Each row's content **must** be wrapped in a `<div>` — the template does this
  (`<div{{ row.attributes.addClass(row_classes) }}>…</div>`). jQuery UI needs a wrapping
  element per panel.
- When grouping is used, the group title is emitted as
  `<h3 class="js-views-accordion-group-header">{{ title }}</h3>` — that class is the trigger
  selector when "use group header as accordion header" is on.

## Header class & selectors (set in PHP, not the template)

In `preRender()` the style adds classes to the **first non-excluded field's** wrapper:
`views-accordion-header` plus a per-view `js-views-accordion-header-<dom_id>` class (any
user-set `element_wrapper_class` is preserved and prefixed). The header wrapper defaults to a
`div` if none is set. The JS reads `drupalSettings.views_accordion[<dom_id>]` for the header
selector, icons, event, easing, etc. Style with CSS targeting `.views-accordion-header` (and
the jQuery UI `ui-icon-*` classes) as needed; there is no bundled stylesheet in this version.
