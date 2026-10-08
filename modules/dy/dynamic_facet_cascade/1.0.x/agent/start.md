<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic Facet Cascade (dynamic_facet_cascade) — agent index

A block of **AJAX dependent (cascading) dropdowns** that pre-filter a Search API view through the **Facets** module. Package `Search`. Core `^10 || ^11`. License GPL-2.0-or-later. Version dir **1.0.x** — the installed release is **1.0.0-alpha3**, a pre-release alpha (not covered by the security advisory policy).

Dependencies (info.yml): core **`views`**, plus contrib **`search_api`** (`^1.30`) and **`facets`** (`^2.0 || ^3.0`).

## What it provides (from source)

- **One config entity type** `dynamic_facet_cascade_preset` (`src/Entity/DynamicFacetCascadePreset.php`). One preset = one search block variant. Config prefix `preset`, `admin_permission = "administer site configuration"`. → [config/preset-entity.md](config/preset-entity.md)
- **Admin UI**: add/edit form (`Form/DynamicFacetCascadePresetForm.php`), delete form, and a list builder — routed under `/admin/config/search/dynamic-facet-cascade` (all `_permission: 'administer site configuration'`). → [config/preset-entity.md](config/preset-entity.md)
- **One Block plugin** `dynamic_facet_cascade_block` with a **deriver** (`Plugin/Deriver/DynamicFacetCascadeBlockDeriver.php`) → one block derivative per preset, category *Search*. → [plugins/block.md](plugins/block.md)
- **The frontend cascade form** `DynamicFacetCascadeForm` (`Form/DynamicFacetCascadeForm.php`) rendered by the block: cascading AJAX selects, URL pre-population, and a submit handler that builds a Facets `f[]` URL and redirects. → [forms/cascade-form.md](forms/cascade-form.md)
- **Config schema** `config/schema/dynamic_facet_cascade.schema.yml`. **No** custom permissions file, `.module`, `.install`, or `.services.yml`; **no** Drush commands.
- A `dynamic_facet_cascade/tabs` asset library (`css/tabs.css`, `js/tabs.js`; deps core/jquery, core/drupal, core/once) attached only for multi-tab presets.

## Key model

A preset stores: `search_view_path` (a Search API-backed Views page path), `facet_value_type` (`tid`|`name`|`slug`), `cascade_existing_only` (bool), `cascade_levels` (ordered `[facet_id, label]`), and `tabs` (each with a dominant Facets entity + per-dropdown enabled/weight). Vocabulary, inter-level reference field, URL alias, and index field are **derived at runtime from the referenced Facets entities**, never stored. A legacy pre-refactor level format (`vocabulary`, `reference_field`, `index_field`, `facet_key`) is still read transparently.
