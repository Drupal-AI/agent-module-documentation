<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Dependent Filter adds a "Global: Dependent filter" Views filter handler that shows or hides other exposed filters based on the value selected in a controlling exposed filter, so irrelevant filters only appear when they apply.

---

The module registers one pseudo-filter (`views_dependent_filter`, exposed by `hook_views_data_alter()` as the `views` table field "Dependent filter"). It performs no query of its own — its `query()` is a no-op and it accepts no exposed input. Instead, placed **between** a controller filter and the dependent filter(s) in the filter order, it records a dependency descriptor into the exposed form's state and attaches an `#after_build` callback. That callback (`views_dependent_filters_exposed_form_after_build()`) computes core Form API `#states` (visible/invisible) on each dependent exposed filter element, keyed off the controller's widget (textfield/checkboxes/radios/select). You configure it in the Views UI in two parts: an *extra options* form to pick the **controller filter** (only filters earlier in the order), then the main options form to choose the **condition mode** ("selected / not empty" vs "specific values"), the **controller values** that trigger visibility, the **dependent filters** (only filters later in the order), and an optional **Negate** to invert the show/hide. Multiple instances are allowed (one per controller). It works with both the standard Views exposed form and Better Exposed Filters, and has special handling for Facets filters (raw comma-separated values).

---

- Show a "cake flavour" exposed filter only when the product-type filter is set to "cake".
- Hide brand/model filters until a category filter selects the relevant category.
- Reveal a date-range filter only when a "search by date" checkbox is ticked (condition mode "not empty").
- Cascade filters: country → region → city, each appearing once its parent is chosen.
- Show a taxonomy filter only for content types that actually have that field.
- Hide advanced filters behind a simple "advanced search" toggle in an exposed form.
- Invert the logic with Negate so a filter is hidden (not shown) when the controller has certain values.
- Keep a cluttered exposed filter form clean by only surfacing filters relevant to the current selection.
- Drive dependent-filter visibility from a select, radios, checkboxes, or textfield controller widget.
- Combine multiple Dependent filter handlers, one per product type, so each type reveals its own sub-filter.
- Use with Better Exposed Filters to add dependency logic on top of BEF widgets.
- Trigger a dependent filter from specific raw Facet values when the controller is a Facets filter.
- Show a "genre" filter only when media type = book, and a "duration" filter only when media type = video.
- Make a status filter appear only for editors who first pick a workflow-state filter value.
- Reduce accidental empty result sets by hiding filters that would conflict unless their trigger is selected.
- Provide progressive disclosure in a catalog view without custom JavaScript.
- Only show a price-range filter after a category that has pricing is selected.
- Hide language-specific filters until a language filter is chosen.
- Let a single exposed form serve several content types by revealing per-type filters conditionally.
- Show a "featured only" filter when a promotions filter is active.
- Configure entirely through the Views UI with no code and no query overhead.
- Keep dependent filters from affecting results when hidden (their values are ignored while invisible).
