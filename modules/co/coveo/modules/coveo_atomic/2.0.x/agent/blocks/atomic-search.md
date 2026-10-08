<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# coveo_atomic block, template & token attach

Enable: `drush en coveo_atomic` (pulls in `coveo`). Create a `coveo_search_component` first
(`/admin/config/search/coveo/search_components`) — the block deriver produces one block per component.

## Block plugin

- `CoveoAtomicSearch` (`src/Plugin/Block/CoveoAtomicSearch.php`), id `coveo_atomic`, category *Search*,
  deriver `CoveoAtomicBlocks`.
- `build()` returns `#theme => 'coveo_atomic_search'` with `#id => configuration['widget_id']`,
  `#search => derivativeId` (the search component id), plus a contextual link to the component edit form.
- `blockForm()` collects a `widget_id` (machine-name field, uniqueness disabled — used only for
  validation/placement id). `defaultConfiguration()` → `widget_id => ''`.
- Deriver `getDerivativeDefinitions()` loads all `coveo_search_component` entities and creates a
  derivative per id, setting `admin_label` "Coveo Atomic: <label>" and a content config dependency.

Place the resulting block(s) via the block layout on the pages where search should appear.

## Theme & template

- `hook_theme` registers `coveo_atomic_search` → `templates/coveo-atomic-search.html.twig` with
  variables `id`, `search`, `fields` (default `['coveo_uri','coveo_date','coveo_excerpt']`), `facets`,
  `tabs`.
- The template renders Coveo Atomic components: `<atomic-search-interface id fields-to-include>` (fields
  run through the `atomic_fields(search)` filter), `<atomic-search-layout>`, search/facet/status/results/
  pagination sections, `<atomic-result-template>`, etc. Override per id/component via the theme
  suggestions `coveo_atomic_search__<id>`, `__<search>`, `__<id>__<search>`.

## Token attach (`template_preprocess_coveo_atomic_search`)

For a non-empty `search`, loads the `CoveoSearchComponent` and attaches:

- library `coveo_atomic/atomic`;
- `drupalSettings.coveo_atomic[<id>]` = `{ search, accessToken, organizationId, analyticsMode:'legacy' }`.

`accessToken` = `$search->getToken(\Drupal::request(), \Drupal::currentUser())` — generated per request
by the component's security provider (Email provider → a Coveo email-scoped search token; Token provider
→ the component's search key verbatim; Drupal provider → an identity-scoped token). Choose the provider
per component to control what the browser receives.

## Client JS (`js/coveo_atomic.js`)

`Drupal.behaviors.coveoAtomic` iterates `settings.coveo_atomic`, and for each element calls
`searchInterface.initialize({ accessToken, organizationId, renewAccessToken })` then
`executeFirstSearch()`. `renewAccessToken` = `Drupal.CoveoAtomic.refreshSearchToken(search)` which does
`$.getJSON('/coveo/refresh', { search })` and returns `data.token`. The Atomic ESM bundle and theme CSS
load externally from `static.cloud.coveo.com/atomic/v3/`.

## Twig field-name filters (`src/Twig/AtomicExtension.php`)

- `field_list|atomic_fields(search)` → JSON array of Coveo field names (via
  `component->getOrganization()->getFieldConverter()->convertFieldNames()`; `[]` on error).
- `field_name|atomic_field(search)` → single Coveo field name (`''` on error). Both apply the
  organization `prefix`.
