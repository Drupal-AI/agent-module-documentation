<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets link field (facets_link_field_processors) — agent index

Provides **one Facets processor** for Drupal's core **Link** field: it replaces a link-field facet's raw URI
with the **referenced entity's translated label**. Package `Search`. License GPL-2.0-or-later. Version `1.0.0`
(version-dir `1.0.x`). Core `^10 || ^11`.

## Dependencies

- `facets:facets` — provides the Facets framework, the `ProcessorPluginBase` / `BuildProcessorInterface` this
  plugin extends, and the facet entity the processor runs against. (composer.json lists `drupal/facets` only
  under `require-dev`; the runtime dependency is declared in `.info.yml`.)
- Core `link` module (for the `field_item:link` data type and `LinkItemInterface`) and core entity/language
  managers.

## What it provides (from source)

- **One Facets processor plugin**: `Drupal\facets_link_field_processors\Plugin\facets\processor\TranslateEntityInLinkProcessor`
  — annotation id `facets_link_field_processors`, label *Transform entity link to label*, stage
  `build = 5`. Implements `BuildProcessorInterface` + `ContainerFactoryPluginInterface`. Injects
  `language_manager` and `entity_type.manager`. → [plugins/translate-entity-in-link.md](plugins/translate-entity-in-link.md)

## What it does NOT provide

No routes, controllers, permissions, forms, services, hooks, entities, Drush, **no `config/install` and no
`config/schema`** of its own. The processor's one setting (`remove_non_entities`) is stored by Facets inside the
facet entity's processor configuration. `configure` is null.

## Install / operate

1. `composer require drupal/facets_link_field_processors` (pulls `drupal/facets`).
2. `drush en facets_link_field_processors -y`.
3. Create/edit a facet on a **Link** field (Facets UI, `/admin/config/search/facets`); the field must allow
   internal/generic URLs. Enable the **Transform entity link to label** processor; optionally tick
   **Remove non entities**. See [plugins/translate-entity-in-link.md](plugins/translate-entity-in-link.md).
