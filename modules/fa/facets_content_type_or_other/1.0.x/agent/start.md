<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Content type or Other (facets_content_type_or_other) — agent index

Indexes node **content types into a Facets facet** where selected types keep their own value and all
other bundles collapse into a single **"Other"** bucket. Package `Search`. License GPL-2.0-or-later.
Installed version **1.0.2-alpha1** (version dir `1.0.x`). Core `^10 || ^11`.

## Dependencies

- `search_api:search_api` — the processor that produces the indexed value plugs into a Search API index.
- `facets:facets` — the sort processor and the facet itself come from Facets; settings form permission is
  `administer facets`.

No `composer.json` ships, so there are no non-Drupal Composer requirements.

## What it provides (from source)

- **Search API processor** `content_type_or_other` — `src/Plugin/search_api/processor/ContentTypeOrOther.php`
  (`add_properties` stage, `locked = true`, `hidden = true`). Adds a computed string property
  `content_type_or_other`; at index time maps each `entity:node` item's bundle to its configured label /
  `Other` / bundle label. → [plugins/search-api-processor.md](plugins/search-api-processor.md)
- **Facets sort processor** `content_type_or_other_sort` — `src/Plugin/facets/processor/ContentTypeOrOtherSortOrder.php`
  (`sort` stage weight 10). Orders results by configured first-order sequence, `Other` always last.
  → [plugins/facets-sort-processor.md](plugins/facets-sort-processor.md)
- **Settings form** `SettingsForm` (route `facets_content_type_or_other.settings`,
  `/admin/config/search/facets-content-type-or-other`, `_permission: 'administer facets'`). Draggable table:
  first-order flag, label override, weight → config `facets_content_type_or_other.settings`.
  → [config/settings.md](config/settings.md)
- **Event** `SetIndexedValue` — `src/Event/SetIndexedValue.php` (name
  `facets_content_type_or_other_set_indexed_value`). Dispatched by the processor before each value is
  indexed; subscribers can rewrite the label from the node entity. → [api/set-indexed-value-event.md](api/set-indexed-value-event.md)

## What it does NOT provide

No permissions of its own (reuses Facets' `administer facets`), no entities, **no config schema**, no
`config/install`, no services, no Drush, no controllers. Only route is the admin settings form (POST +
core CSRF). It shapes facet display only; listed content still respects its own access.

## Install / operate

1. `composer require drupal/facets_content_type_or_other` (needs Search API + Facets).
2. `drush en facets_content_type_or_other -y`.
3. Configure first-order types/labels at `/admin/config/search/facets-content-type-or-other`.
4. Add the **Content type or other** field to a Search API index; build a facet on it; under **Facet
   sorting** select **Content type or Other - Sort order** and deselect the others.
5. **Re-index** all content after any settings change.
