<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Missing Merge (facets_missing_merge) — agent index

Ships **one Facets processor** that merges a facet's "missing" (no-value) item into a configured
target item — folding count and filters and relabelling the target as *"Target (or None)"*. Package
`Search`. License GPL-2.0-or-later. Core `^9 || ^10 || ^11`. Version 1.0.2.

## Dependencies

- `facets:facets` — the Facets module. This provides `ProcessorPluginBase`, `BuildProcessorInterface`,
  `FacetInterface`, `ResultInterface`, and the facet's "missing" item feature that this processor acts on.
  (Declared in `facets_missing_merge.info.yml`; `composer.json` lists facets under `require-dev` only.)

## What it provides (from source)

- **One facet processor plugin**: `Drupal\facets_missing_merge\Plugin\facets\processor\MissingItemMergeProcessor`
  — annotation `@FacetsProcessor(id = "missing_item_merge", label = "Merge missing item")`, stage
  `build` at weight `5`, extends `ProcessorPluginBase` and implements `BuildProcessorInterface`.
  → [plugins/missing-item-merge.md](plugins/missing-item-merge.md)
- **Config schema** `config/schema/facets_missing_merge.processor.schema.yml` for the plugin's one
  setting `target_item` (type string). No `config/install`.

## What it does NOT provide

No routes, no controllers, no permissions, no forms/settings page of its own, no services, no hooks,
no `.module`/`.install`, no entities, no Drush. `configure` is null — the one setting lives in the
facet entity's processor configuration and is edited on the Facets facet-edit screen.

## Install / operate

1. `composer require drupal/facets_missing_merge` (Facets must also be present/enabled).
2. `drush en facets_missing_merge -y`.
3. On a facet at `/admin/config/search/facets` enable the facet's **"missing"** option, then enable
   the **Merge missing item** processor and set its **Target item** (raw value or display label).
4. Order the processor **before the URL processor** in the build phase (it rewrites missing filters).
   See [plugins/missing-item-merge.md](plugins/missing-item-merge.md).
