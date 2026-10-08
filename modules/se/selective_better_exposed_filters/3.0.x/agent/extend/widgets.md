# How it works (overridden BEF widgets)

The module does not define a plugin type; it *replaces* three of Better Exposed Filters'
`@BetterExposedFiltersFilterWidget` plugins by reusing their ids:

- `default` → `Plugin/better_exposed_filters/filter/DefaultWidget` (extends BEF's DefaultWidget)
- `bef_links` → `.../Links` (extends BEF's Links)
- `bef` → `.../RadioButtons` (extends BEF's RadioButtons/checkboxes)

Each subclass mixes in the static helpers of `SelectiveFilterBase`:
- `defaultConfiguration()` — adds the four `options_*` keys.
- `buildConfigurationForm()` — adds the checkboxes (gated to supported filter types).
- `exposedFormAlter()` — the core logic.

`exposedFormAlter()` clones the view (`Views::getView`), marks it `selective_filter`, sets
`itemsPerPage(0)`, strips filter values from the request query (all values, or all-but-this
filter when *filtered result set* is on), executes it, collects the referenced target ids
(walking taxonomy parents when the filter is hierarchical), then unsets any
`$element['#options']` whose key is not among those ids. With **show items count** it instead
appends the per-option `(count)`; with **hide when empty** it sets `#access = FALSE` when
nothing usable remains.

No public API — behavior is entirely driven by the per-filter config
([configure/options.md](../configure/options.md)).
