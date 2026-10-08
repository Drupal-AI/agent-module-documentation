Better Exposed Filters Layout (vefl_bef) is a VEFL submodule that lets you place Better Exposed Filters (BEF) widgets into the regions of a layout, combining BEF's enhanced exposed-filter widgets with VEFL's region-based arrangement.

---

vefl_bef adds a Views exposed form plugin `vefl_bef` ("Better Exposed Filters (with layout)") whose class `VeflBef` extends the Better Exposed Filters `BetterExposedFilters` exposed form plugin and mixes in VEFL's `VeflTrait`. So on a view you get all of BEF's per-widget options (checkboxes, radios, sliders, links, autosubmit, secondary/collapsible options, etc.) **and** a "Layout settings" fieldset to assign each exposed widget to a layout region, exactly like the base `vefl_basic` plugin. It stores the same `layout.layout_id` + `layout.widget_region` options (plus the full `bef` settings tree) in the view's exposed_form config. Beyond the standard filters and action widgets, vefl_bef's region assignment also offers two BEF-specific placements: **secondary exposed form options** (shown only when BEF's "allow secondary" is enabled) and **combine sort order with sort by** (shown when BEF's combined-sort option is enabled). It requires both the `vefl` and `better_exposed_filters` modules and shares VEFL's rendering (the `vefl_views_exposed_form` theme hook and layout build). Enable it only if you use Better Exposed Filters and want its widgets laid out in regions.

---

- Lay out Better Exposed Filters widgets (checkboxes, radios, sliders) into layout regions.
- Combine BEF's autosubmit exposed form with a multi-column region arrangement.
- Place a BEF "links" filter in one region and the sort controls in another.
- Assign BEF secondary/collapsible exposed options to their own region.
- Put the combined sort (sort_bef_combine) control in a chosen region.
- Build a faceted-search-style BEF filter bar arranged across columns.
- Use a Display Suite or Panels layout to structure a BEF exposed form.
- Keep a complex BEF filter set readable by grouping widgets into regions.
- Give a product filter view both BEF widgets and a responsive multi-region layout.
- Move rarely used BEF filters into a secondary region shown on demand.
- Arrange BEF slider and range widgets alongside their labels in a region.
- Standardize BEF exposed-form layouts across several views via a shared layout.
- Theme a BEF exposed form per view with VEFL's template suggestions.
- Position the BEF submit and reset buttons in a dedicated actions region.
- Combine BEF's exposed-filter UX improvements with region-based placement without code.
- Lay out an exposed operator (when exposed) next to its BEF filter widget.
- Create a compact BEF toolbar for a data table.
- Migrate an existing BEF view to a region-based layout by switching its exposed form style.
- Separate primary and secondary BEF filters visually within one exposed form.
- Improve mobile UX for BEF filters by stacking them into a single-column layout.
