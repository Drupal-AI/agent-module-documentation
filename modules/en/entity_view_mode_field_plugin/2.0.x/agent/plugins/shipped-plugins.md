<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shipped plugins

All in `src/Plugin/EntityViewModeFieldPlugin/`, each extending `EntityViewModeFieldPluginBase` and
overriding `getValue()`. The plugin `id` is the extra-field key and the dynamic property name set on
loaded entities.

| id | class | target `entity_type` | `getValue()` returns |
| --- | --- | --- | --- |
| `entity_bundle` | `ViewEntityBundleField` | node, paragraph, taxonomy_term, user | `$entity->bundle()` |
| `entity_id` | `ViewIdField` | node, paragraph, taxonomy_term, commerce_product, user | `$entity->id()` |
| `entity_uuid` | `ViewUuidField` | node, paragraph, taxonomy_term, user | `$entity->uuid()` |
| `path_alias` | `ViewPathAliasField` | node | `path_alias.manager->getAliasByPath('/node/' . id)` |
| `path_alias_taxonomy` | `ViewPathAliasTaxonomyField` | taxonomy_term | `path_alias.manager->getAliasByPath('/taxonomy/term/' . id)` |

Notes:
- `path_alias` (label "URL Alias") and `path_alias_taxonomy` (also label "URL Alias") both call
  `\Drupal::service('path_alias.manager')->getAliasByPath(...)` for the entity's own canonical path;
  they return the raw path if no alias exists.
- `entity_type` values listed above come from each plugin's annotation; a plugin only registers /
  attaches on those types. (`commerce_product` requires Drupal Commerce to be present for that type
  to exist.)
- `label` in each annotation is the plugin's suffix; the displayed extra-field label prepends the
  entity type label, e.g. "Article ID".
