Views Exposed Form Layout (VEFL) adds a Views "exposed form" style that lets you place each exposed filter, sort, and action into the regions of a layout, instead of rendering them all in a single flat row.

---

VEFL provides a Views **exposed form plugin** `vefl_basic` ("Basic (with layout)") that extends core's `Basic` exposed form via `VeflTrait`. Choosing it on a view's *Exposed form* settings adds a "Layout settings" fieldset where you pick a layout (any layout registered with core `layout_discovery` / Layout API — Display Suite and Panels layouts work too) and assign every exposed widget (each filter, plus the actions `sort_by`, `sort_order`, `items_per_page`, `offset`, `submit`, `reset`, and any exposed operators) to one of that layout's regions. The choices are stored in the view's exposed_form options under `layout.layout_id` and `layout.widget_region` (a map of widget id → region id). At render time the module's `template_preprocess_vefl_views_exposed_form()` groups the form elements by region and calls the chosen layout plugin's `build()` to produce the markup, using the `vefl_views_exposed_form` theme hook (overridable like any exposed form template, e.g. `views-exposed-form--VIEWNAME.html.twig`). The module ships one simple layout, `vefl_onecol` (a single "middle" region), declared in `vefl.layouts.yml`, and exposes a `vefl.layout` helper service for enumerating layouts and form actions. A bundled submodule, `vefl_bef`, provides the same capability for the Better Exposed Filters module (`vefl_bef` exposed form plugin).

---

- Arrange a view's exposed filters into columns instead of one long horizontal row.
- Put the search keyword field, category filter, and submit button into separate layout regions.
- Group sort-by and sort-order controls together in their own region of the exposed form.
- Move the "Items per page" selector into a sidebar region of the filter form.
- Build a multi-column faceted-search-style filter bar without custom code.
- Assign each exposed filter to a named region for precise theming control.
- Use a Display Suite or Panels layout to structure a complex exposed filter form.
- Define a custom layout (via layout_discovery) with the regions you want for filters.
- Place the reset button in a dedicated region separate from the submit button.
- Keep an "exposed form in block" tidy by laying its widgets out in regions.
- Lay out exposed operators (when "expose operator" is on) alongside their filters.
- Give a product catalog's filters a two-column responsive arrangement.
- Override `views-exposed-form--VIEWNAME.html.twig` to fine-tune per-view filter markup.
- Standardize exposed-filter layouts across multiple views using a shared custom layout.
- Combine with Better Exposed Filters (via vefl_bef) to lay out BEF widgets in regions.
- Move rarely used filters into a collapsible or secondary region of the form.
- Position the submit/apply button at the end of a specific region.
- Create a compact filter toolbar for a data table view.
- Improve mobile filter UX by stacking widgets into a single-column layout.
- Separate primary and secondary filters visually within the exposed form.
- Reuse the single-column `vefl_onecol` layout as a starting point for a custom one.
- Theme exposed forms consistently with the rest of a layout-driven site.
- Let site builders rearrange filter placement without touching Twig.
- Output an exposed sort widget in a header region above the results.
