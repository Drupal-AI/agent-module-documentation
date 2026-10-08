<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Form Live Total (DEPRECATED) — agent index

**Deprecated** (`lifecycle: deprecated`, since 1.0.0-alpha4) — do not use on new sites. Live-updates
the Facets Summary results count over AJAX as the user changes a facets form, before submit. Requires
`facets_form` + `facets:facets_summary` (+ Search API). No config page, no permissions, no Drush, no
config schema dir (adds one schema key via a hook).

- **How it works: block override, the `/facets-form-live-total` AJAX route, subscribers, JS** →
  [api/live-total.md](api/live-total.md)

Key facts:
- `hook_block_alter` swaps the `facets_form` block class to `FacetsFormLiveTotalBlock`, adding a
  "Live total" checkbox; `hook_config_schema_info_alter` adds `live_total` to
  `block.settings.facets_form:*:*`.
- `EnableLiveTotalSubscriber` enables the Facets Form JS event when `live_total` is set;
  `hook_form_facets_form_alter` attaches library `facets_form_live_total/update_total`.
- Route `/facets-form-live-total` → `FacetFormAjaxController::getLiveTotal` returns a `ReplaceCommand`
  for `.source-summary-count`; `_custom_access` requires a Search API source with a Views display
  rendered in the current request.
