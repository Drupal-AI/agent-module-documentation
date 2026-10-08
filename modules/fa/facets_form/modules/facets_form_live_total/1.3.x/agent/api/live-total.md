<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How live total works (deprecated module)

## Enabling it
- `facets_form_live_total_block_alter()` replaces the `facets_form` block's class with
  `FacetsFormLiveTotalBlock` (subclass of `FacetsFormBlock`), which adds a **Live total** checkbox
  (`live_total`, default FALSE, cast to bool on submit).
- `facets_form_live_total_config_schema_info_alter()` adds `live_total: boolean` to
  `block.settings.facets_form:*:*`.
- `EnableLiveTotalSubscriber` (subscribes to `TriggerWidgetChangeJavaScriptEvent`) calls
  `$event->triggerWidgetChangeEvent()` when the block's `live_total` is set — this is what makes
  `FacetsForm` attach the per-widget JS libraries.
- `facets_form_live_total_form_facets_form_alter()` — when `block_settings['live_total']` is set,
  attaches library `facets_form_live_total/update_total` and adds
  `data-drupal-facets-form-live-total="true"` to the form.

## Client side (`js/update_total.js`, deps `core/drupal`, `core/drupal.ajax`, `core/once`,
`facets_form/plugin_base`)
Behavior `facetsFormLiveTotal` binds to `form[data-drupal-facets-form-live-total]` and listens for
the `facets_form` custom event. On a relevant change (`updateIsNeeded()` skips requests when a
changed value already has an active ancestor) it fires `Drupal.ajax({url})` to
`facets-form-live-total?facets_source=<id>&f[0]=<facet>:<value>&…` (built by `buildUrl()`).

## Server side
### Route `/facets-form-live-total` (`facets_form_live_total.routing.yml`)
`_controller: FacetFormAjaxController::getLiveTotal`, `_custom_access: FacetFormAjaxController::access`.

### `FacetFormAjaxController::getLiveTotal(Request): AjaxResponse`
Reads `facets_source` from the query, loads its facets, instantiates the facet source, calls
`fillFacetsWithResults()`, and returns a `ReplaceCommand('.source-summary-count', …
'#theme' => 'facets_summary_count', '#count' => $facet_source->getCount())`. Empty facets → empty
response.

### `access(): AccessResultInterface`
Forbidden unless `facets_source` is a valid facets source definition; throws if the base plugin id is
not `search_api` or the source has no Views display. Sets `view_id`/`display_id` on the route match
and returns `allowedIf($facet_source->isRenderedInCurrentRequest())` — i.e. the count endpoint only
answers for a Search API + Views source actually rendered in the current request. (Read-only: it
recomputes and returns a count; it changes no state.)

### `SearchApiSubscriber` (service, subscribes to `SearchApiEvents::QUERY_PRE_EXECUTE`)
On query pre-execute, if any facet of the query's source has `show_numbers`, sets
`skip result count => FALSE` so counts are actually computed. Guards against a missing Search API
class at install time.
