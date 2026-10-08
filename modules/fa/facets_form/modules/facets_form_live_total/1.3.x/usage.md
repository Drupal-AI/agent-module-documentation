<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facets Form Live Total (deprecated) updates the Facets Summary results count live via AJAX as the user interacts with a facets form, before they submit — so the "X results" total reflects the pending selection.

---

**Deprecated** (`lifecycle: deprecated`, since 1.0.0-alpha4) — kept for backward compatibility; do
not build new sites on it. It adds a "Live total" checkbox to the facets form block by swapping the
block class for `FacetsFormLiveTotalBlock` (via `hook_block_alter`) and adds the `live_total` boolean
to the block config schema (`hook_config_schema_info_alter`). When enabled on a block, an
`EnableLiveTotalSubscriber` turns on the Facets Form JS widget-change event, and
`hook_form_facets_form_alter` attaches the `update_total` library and a
`data-drupal-facets-form-live-total` marker. The JS (`js/update_total.js`) listens for the
`facets_form` widget-change event and issues a Drupal AJAX request to the module's route
`/facets-form-live-total` (controller `FacetFormAjaxController::getLiveTotal`), which recomputes the
Search API result count for the given facets source and returns a `ReplaceCommand` that swaps
`.source-summary-count` with a refreshed `facets_summary_count`. A `SearchApiSubscriber` re-enables
result counting (`skip result count` = FALSE) on queries for sources whose facets show numbers. The
AJAX route's `_custom_access` requires a valid Search API facets source with a Views display that is
rendered in the current request. Requires `facets_form` and `facets:facets_summary` (and Search API in
practice).

---

- Show a live-updating "N results" total as users tick facet checkboxes, before submitting.
- Give a submit-driven facets form immediate feedback on how many results the current selection yields.
- Turn on live totals per block via the block's "Live total" checkbox.
- Reuse the Facets Summary count display, refreshed over AJAX.
- Avoid useless AJAX requests when a selected checkbox already has an active ancestor (JS `updateIsNeeded`).
- Recompute Search API result counts on demand for a facets source.
- Integrate with Facets Summary's `.source-summary-count` markup without custom theming.
- Demonstrate a real consumer of the `TriggerWidgetChangeJavaScriptEvent` / `facets_form` JS event.
- Keep result counting enabled for queries whose facets show numbers.
- Provide bookmarkable pending-filter counts (filters are passed as `f[]` query params to the route).
- Restrict the count endpoint to Search API sources rendered via a Views display in the current request.
- Serve as a migration reference before moving to a supported live-count approach.
- Pair with checkbox/dropdown facets form widgets to preview counts per selection.
- Understand how Facets Form dispatches client-side widget-change events end to end.
