<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `Model` plugin type and class-swapping

## Concept

A **model** is a plugin that binds a PHP class to an entity type (and optionally a bundle). You write
the class in your module's `Entity` namespace, extend the relevant core entity/bundle class, and tag
it with the `Model` attribute or annotation. Entity Model then makes Drupal instantiate your class
for that entity type or bundle.

```php
namespace Drupal\mymodule\Entity\Node;

use Drupal\entity_model\Attribute\Model;
use Drupal\node\Entity\Node;

#[Model(entity_type: 'node', bundle: 'page')]
class Page extends Node {
  public function getBody(): ?string {
    return $this->get('body')->processed;
  }
}
```

The legacy annotation form still works: `@Model(entity_type = "node", bundle = "page")`.

## Attribute / annotation

- `src/Attribute/Model.php` — `#[\Attribute(\Attribute::TARGET_CLASS)] class Model extends Plugin`.
  Constructor params `string $entity_type`, `?string $bundle = NULL`. `getId()` returns
  `"$entity_type.$bundle"` when a bundle is set, else `"$entity_type"`.
- `src/Annotation/Model.php` — the equivalent `@Annotation` (`class Model extends Plugin`) with public
  `$entity_type` / `$bundle` and the same `getId()` logic. Both are accepted by the manager.

## Plugin manager

`src/ModelPluginManager.php` — `ModelPluginManager extends DefaultPluginManager`, service
`plugin.manager.entity_model.model` (`entity_model.services.yml`, `parent: default_plugin_manager`).
Constructor args to `parent::__construct()`:

- subdirectory **`Entity`** — classes are discovered under `Drupal\<module>\Entity\**`.
- interface **`ContentEntityInterface`** — the required plugin interface.
- attribute class `Attribute\Model`, annotation class `Annotation\Model`.
- `alterInfo('entity_model_model_info')` — enables the alter hook (see below).
- cache backend keyed `entity_model_model_info_plugins`.

Definitions carry `entity_type`, optional `bundle`, `class`, `provider`. IDs are `entity_type` or
`entity_type.bundle`.

## Class-swap hooks (`entity_model.module`)

- `entity_model_entity_type_alter(&$entity_types)` — for each definition **without** a `bundle`, calls
  `$entity_types[$entity_type]->setClass($definition['class'])`. Definitions **with** a bundle, or for
  an unknown entity type, are skipped.
- `entity_model_entity_bundle_info_alter(&$bundles)` — for each definition **with** a `bundle`, sets
  `$bundles[$entity_type][$bundle]['class'] = $definition['class']` (skips unknown bundles). This
  relies on core's entity bundle class support (Drupal ≥ 9.3).
- `entity_model_field_info_alter(&$info)` — swaps `list_class` for the `entity_reference`,
  `entity_reference_revisions` and `taxonomy_enum` field types (see
  [api/field-helpers.md](../api/field-helpers.md)).

## Alter hook

`hook_entity_model_model_info_alter(array &$definitions)` (`entity_model.api.php`) — lets other modules
rewrite discovered definitions, e.g. `$definitions['node.page']['class'] = Page::class;`.

## Drush command — `entity_model:list`

`src/Commands/EntityModelCommands.php` (`drush.services.yml`, tag `drush.command`). Aliases
`model-list`, `eml`. Constructor injects `@entity_type.manager` and `@plugin.manager.entity_model.model`.

`listModels()` iterates all entity type definitions, keeps only content entity types that have a bundle
entity type, loads their bundle IDs, and for each `entity_type.bundle` reports whether the plugin
manager `hasDefinition()`:

- mapped → `Model "@model" is mapped against "@mapping".` (`@mapping` = the definition's `class`).
- unmapped → `Model "@model" is not mapped.`

Option `--filter-mapped-status` (default `both`; validated against `mapped|unmapped|both` by the private
`validateOption()`, which throws `\InvalidArgumentException` on a bad value) limits output. The bundle
query uses `accessCheck(FALSE)` — this is CLI-only tooling printing bundle machine names, not web output.

## Operate

1. Enable: `drush en entity_model -y`.
2. Add a `Model`-tagged class under `Drupal\<module>\Entity\**`, extending the entity/bundle class.
3. Rebuild caches (`drush cr`).
4. Confirm: `drush entity_model:list` (or `drush eml --filter-mapped-status=mapped`).
