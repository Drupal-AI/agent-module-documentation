# Facet widget internals & autocomplete route

## The widget plugin

`Drupal\select2_facets\Plugin\facets\widget\Select2Widget` (`@FacetsWidget id = "select2"`),
extends `WidgetPluginBase`. Its `build()` produces a single `#type => 'select2'` element:

- `#options` — `resultUrl => displayValue` (with `(count)` appended when *show numbers* is on).
- `#value` — the active result URLs (pre-selected).
- `#multiple` — `!facet->getShowOnlyOneResult()`.
- `#autocomplete` — the `autocomplete` config value; when set it wires
  `#autocomplete_route_callback => [$this, 'processFacetAutocomplete']`.
- Attaches `select2_facets/drupal.select2_facets.select2-widget` (depends on `facets/widget`).
- Cache contexts `url.path`, `url.query_args`.

This is a good reference for how to point the parent module's `select2` element at a **custom
autocomplete route** via `#autocomplete_route_callback` (see the parent module's
extend/select2.md).

## Autocomplete route

`select2_facets.facet_autocomplete` →
`/select2_facets_autocomplete/{facetsource_id}/{facet_id}/{selection_settings_key}`
(controller `FacetApiAutocompleteController::handleAutocomplete`, `_access: 'TRUE'`).

`processFacetAutocomplete()` stores the selection settings (`path`, `match_operator`,
`show_numbers`) in the `entity_autocomplete` key/value store under an HMAC key (salted with the
site hash, over the settings + facet source id + facet id), and passes that key as a route
parameter. The controller re-derives the request from the stored path, rebuilds the facet against
it via the facet manager, filters results by the typed string, and returns JSON in Select2's
`{results: [{id, text}, …]}` shape — access being enforced by the hash match, mirroring the
parent module's entity autocomplete pattern.
