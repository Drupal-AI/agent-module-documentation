# Select2 Better Exposed Filters — agent index

Submodule of `select2boxes`. Adds a Better Exposed Filters widget so Views exposed filters render as
Select2 dropdowns. Depends on `select2boxes` + `better_exposed_filters`. No config schema, no
permissions, no Drush.

How it works:
- Plugin `Drupal\select2_bef\Plugin\better_exposed_filters\filter\Select2Boxes`
  (`@BetterExposedFiltersFilterWidget` id `select2boxes`, label "Select2 boxes"). `isApplicable()` returns
  true for filters that are an `InOperator` (list-type filters).
- Select it in a Views display's Better Exposed Filters settings for the target exposed filter.
- `buildConfigurationForm()` adds (single-value only) `limited_search` + `minimum_search_length`, and
  (language/country/address filters, with `flags`) an `include_flags` checkbox.
- `exposedFormAlter()` forces the element to `#type => select`, adds `select2-widget` +
  `data-select2-autocomplete-list-widget` attributes, sets `#multiple` from the filter's expose config,
  applies min-search-length, optionally attaches flag icons, re-adds core Select
  process/pre-render/processAjaxForm callbacks (AJAX Views workaround), and attaches
  `select2boxes/widget`.
- `select2_bef.install` `select2_bef_update_8001()` migrates old per-value BEF plugin ids
  (`select2boxes_autocomplete_*`) to the unified `select2boxes` id.

No solution sub-docs needed — this is a thin BEF-widget shim over the parent module; the parent's
[configure/widgets.md](../../../../2.0.x/agent/configure/widgets.md) covers the shared library/config.
