<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The DynamicFacetCascadePreset config entity, admin forms & routes

## Install / enable

`composer require drupal/dynamic_facet_cascade` (pulls `drupal/search_api ^1.30` and `drupal/facets ^2.0 || ^3.0`), then `drush en dynamic_facet_cascade -y && drush cr`. Requires core Views. A Search API index + a Views **page** display whose base table is that index, and Facets entities attached to that display, must exist before a preset can be configured.

## Config entity — `DynamicFacetCascadePreset`

`src/Entity/DynamicFacetCascadePreset.php`, extends `ConfigEntityBase`.

- `@ConfigEntityType` id `dynamic_facet_cascade_preset`, `config_prefix = "preset"` (config keys `dynamic_facet_cascade.preset.*`), `admin_permission = "administer site configuration"`.
- Handlers: `list_builder` = `DynamicFacetCascadePresetListBuilder`; forms `add`/`edit` = `DynamicFacetCascadePresetForm`, `delete` = `DynamicFacetCascadePresetDeleteForm`.
- `config_export`: `id`, `label`, `search_view_path`, `facet_value_type`, `cascade_existing_only`, `cascade_levels`, `tabs`.
- Properties: `search_view_path` (Views page path, e.g. `/search`); `facet_value_type` (`tid` numeric TID | `name` raw label | `slug` CSS-clean lowercase label — controls how selections are encoded in the redirect URL); `cascade_existing_only` (bool; TRUE = filter options against the Search API index, FALSE default = show all taxonomy terms); `cascade_levels` (ordered array); `tabs` (array).
- Helper methods: `getLevels()` returns `cascade_levels` (or `[]`); `getTabDominantFacetId(int $tab_idx)` returns the tab's dominant Facets id, honoring the legacy `dominant_field` key.
- **Backward compat**: current level format is `['facet_id' => ..., 'label' => ...]`. A legacy format (`vocabulary`, `reference_field`, `index_field`, `facet_key`) is still read at runtime (see forms/cascade-form.md → `resolveLevelConfig()`); re-saving a preset upgrades it to the new format.

## Config schema

`config/schema/dynamic_facet_cascade.schema.yml` — `dynamic_facet_cascade.preset.*` (type `config_entity`). `cascade_levels` is a sequence of `{facet_id, label}`. `tabs` is a sequence of `{label, dominant_facet_id, dominant_locked_term, dominant_hidden, dropdowns}`, where `dropdowns` is a sequence of `{enabled (bool), weight (int)}`.

## Routes & permissions — `dynamic_facet_cascade.routing.yml`

All four require **`_permission: 'administer site configuration'`** (a core permission; the module ships no custom permission):

- `entity.dynamic_facet_cascade_preset.collection` — `/admin/config/search/dynamic-facet-cascade` (`_entity_list`).
- `.add_form` — `/admin/config/search/dynamic-facet-cascade/add`.
- `.edit_form` — `/admin/config/search/dynamic-facet-cascade/{...}/edit`.
- `.delete_form` — `/admin/config/search/dynamic-facet-cascade/{...}/delete`.

Menu link `dynamic_facet_cascade.settings` (parent `system.admin_config_search`) and action link `Add Preset` point at the collection/add routes. (info.yml declares no `configure:` key.)

## Admin add/edit form — `DynamicFacetCascadePresetForm` (extends `EntityForm`)

- Fields: `label`, `id` (machine_name), and a **General Settings** details group with `search_view_path` (select of Search API-backed view pages, AJAX `viewPathAjaxCallback`), `facet_value_type` (tid/name/slug), and `cascade_existing_only` (checkbox).
- **Cascade Levels** (`#tree`): a repeatable row per level with a `facet_id` select and a `label`; `Add Level` / `Remove Level N` are AJAX submit handlers (`addLevelSubmit`/`removeLevelSubmit`, callback `levelsAjaxCallback`) that mutate `num_levels`/`levels` in form state and `setRebuild(TRUE)`.
- **Tabs** (`#tree`): per tab a `label`, a `dominant_facet_id` radios (AJAX `tabsAjaxCallback`), a transient `dominant_lock_enabled` checkbox that `#states`-controls `dominant_locked_term` (term select) + `dominant_hidden` (checkbox), and an `Exposed Dropdowns & Weights` fieldset with an enabled+weight row per cascade level and the dominant. `Add Tab`/`Remove Tab N` mirror the level handlers.
- Option sources: `getSearchApiViewOptions()` lists only views whose `base_table` starts `search_api_index_` and that have a page path. `getFacetsForView($path)` resolves the view/display from the path and returns Facets entities whose `facet_source_id` equals `search_api:views_page__{view}__{display}` — the single source of truth for level + dominant selects. `getTermsForFacet($facet_id)` derives the vocabulary from the facet's field and lists its terms for the lock picker.
- `save()` persists **only** `facet_id`+`label` per level and, per tab, `label`, `dominant_facet_id`, `dominant_locked_term` (only when `dominant_lock_enabled`), `dominant_hidden`, and normalized `dropdowns` (`enabled` 0/1, `weight` int). `dominant_lock_enabled` is transient and never stored. Redirects to the collection.

## Delete form & list builder

- `DynamicFacetCascadePresetDeleteForm` extends `EntityDeleteForm` — standard confirm form, cancels to the collection.
- `DynamicFacetCascadePresetListBuilder` extends `ConfigEntityListBuilder` — columns Preset (label), Machine name, Search View Path.
