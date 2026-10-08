<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The frontend cascade form (AJAX dependent dropdowns + redirect)

`src/Form/DynamicFacetCascadeForm.php`, extends `FormBase`, form id `dynamic_facet_cascade_form`. Rendered by `DynamicFacetCascadeBlock::build()`, which passes the preset machine name as the `$preset_id` argument. DI: `entity_type.manager`, `entity_field.manager`, `request_stack`. There is **no dedicated route/endpoint** for the AJAX — it uses standard Form API AJAX, so the callback posts back through the block's host page and re-renders form elements; the block itself carries the access.

## buildForm()

- Stores `$preset_id` in form state on first build so AJAX rebuilds (which get no argument) can reload the preset. Loads the preset; if missing or it has no `tabs`, renders a configure-me message.
- Reads `facet_value_type`, the ordered `getLevels()`, and each `tabs` entry. Multi-tab presets render a tab nav (`html_tag` buttons, purely presentational; `js/tabs.js` toggles the hidden `active_tab` input) + panes wrapper and attach the `dynamic_facet_cascade/tabs` library; single-tab presets render the dropdowns directly.
- Per tab it resolves the dominant Facets entity (`dominant_facet_id`, legacy `dominant_field`) to a field id, URL alias, and vocabulary, then builds:
  1. **Dominant dropdown** — a `select` (or a `hidden` input when a locked term is set AND `dominant_hidden`, silently injecting the term). A locked-but-visible term is a default the user can override. Options come from `loadVocabularyOptions()`.
  2. **Cascade level dropdowns** — level 1 always enabled; level N enabled only when level N-1 has a value. Each level's options are loaded filtered by the parent selection via the auto-discovered reference field, and disabled levels render `#disabled`.
- Each dropdown except the last level has `#ajax` → `updateDropdownsCallback` on `change`, targeting the tab's `dfc-tab-{idx}-dropdowns-wrapper`. **Downstream reset**: if a parent level is empty, all deeper levels are emptied so no orphaned selections submit.

## Value resolution (initial load, URL pre-population, AJAX)

- `resolveFormValue()` priority: current POST `user_input` -> cached form-state value -> (only on fresh load) URL. `getValueFromUrl()` reads the Facets `f[]` array (`alias:value`) with a legacy `?alias=value` fallback; `urlValueToTid()` returns the raw value for `tid` mode (numeric-validated) or matches term name / CSS-clean slug within the vocabulary (skipping unpublished terms) for `name`/`slug`.

## How dropdown options are queried — `loadVocabularyOptions()`

- **Entity-query mode** (when a reference field + parent TID, or extra conditions, are present): `taxonomy_term` `getQuery()` with **`accessCheck(TRUE)`**, `condition('vid', $vocabulary)`, the parent reference-field condition, and any type-filter conditions; loads and alpha-sorts matching terms.
- **loadTree mode** (top level, no parent/conditions): `loadTree($vocabulary, 0, 1)` for root terms; loadTree does not check access so the code **skips terms whose `status` is unpublished**.
- Reference field between levels is auto-discovered by `discoverReferenceField($child_vocab, $parent_vocab)` (an entity_reference field on the child vocabulary targeting the parent). `vocabFromFieldName()` maps a field back to its target vocabulary. `resolveLevelConfig()` caches per-request the derived `{vocabulary, reference_field, url_alias, field_id}` from the level's Facets entity, and also handles the legacy stored format.
- A dominant vocabulary that is referenced by a level vocabulary auto-enables a "type" filter (e.g. a *By Type* tab restricts models to the selected type) with no extra config.

## Content-based mode — `filterOptionsByIndex()`

When `cascade_existing_only` is TRUE: resolves the Search API index from the preset's view path (`getIndexForPreset()` -> view `base_table` `search_api_index_*`), runs a **zero-row** query (`range(0,0)`) that adds `status = 1` when the index tracks status, applies the active parent/dominant selections as conditions, and requests `search_api_facets` for the target field (`limit -1`, `min_count 1`). Only option TIDs present in the facet result are kept (Solr quote-stripping applied). On any query exception it **fails open** (logs, returns unfiltered options) so a backend error never empties a dropdown.

## submitForm() — build the Facets URL and redirect

- Loads the active tab (from the `active_tab` hidden value). For each **enabled** dropdown in that tab, reads its value, converts TID -> name/slug when `facet_value_type` isn't `tid` (loads the term), resolves the dropdown's Facets entity (`dominant` -> tab dominant; `level_N` -> that level's `facet_id`) to a URL alias, and appends `"{alias}:{value}"` to a `f[]` query array.
- Redirects to `search_view_path` with that query via `Url::fromUri()` (when the path starts `http`) or `Url::fromUserInput()` (internal path) — e.g. `/search?f[]=brand:toyota&f[]=model:corolla`. The results view enforces its own access.

## AJAX callback

`updateDropdownsCallback()` extracts the tab index from the triggering element name (`tab_{N}_...`) and returns only that tab's `dropdowns_wrapper` (multi-tab path first, single-tab fallback), so only the affected dropdowns re-render.
