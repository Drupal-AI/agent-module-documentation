<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntityFallbackValue plugin type

The module defines one annotation-based plugin type so a site can declare a **default** fallback
chain per entity type/bundle. The module ships **no** plugins itself — you write them (or scaffold
with Drush). Once a plugin exists, its keys become available to the plugin-defaults path of the
service, the Twig function, and tokens.

## Pieces (from source)

- **Manager** `PluginManager\EntityFallbackValuePluginManager` (service
  `entity_fallback_value.plugin_manager`, parent `default_plugin_manager`). Discovery subdir
  `Plugin/entity_fallback_value`; interface `…\Plugin\EntityFallbackValuePluginInterface`;
  annotation `…\Annotation\EntityFallbackValuePluginAnnotation`; alter hook
  `entity_fallback_value_info`. Consts `SERVICE_NAME`, `PACKAGE_NAME`; static `me()` singleton.
  - `getInstances()` — instantiates every definition once, passing
    `getAppliesOnArray($definition['applies_on'])` as the plugin configuration; memoized in
    `$instances`.
  - `getInstancesByContentEntity($entity)` — returns instances whose `applies($entity)` is TRUE.
  - `getAppliesOnArray()` — turns `["node.page", "user"]` into
    `['node' => ['page'], 'user' => []]` (empty bundle list = all bundles).
- **Annotation** `EntityFallbackValuePluginAnnotation` (`@Annotation`, extends core `Plugin`):
  fields `id` (string) and `applies_on` (array of `entity_type_id` or `entity_type_id.bundle`).
- **Interface** `EntityFallbackValuePluginInterface`: `getEntityFallbackValues(?ContentEntityInterface)`,
  `getEntityFallbackDefinitions(): array`, `applies(?ContentEntityInterface): bool`.
- **Abstract base** `Plugin\AbstractEntityFallbackValuePlugin` (implements the interface +
  `ContainerFactoryPluginInterface`, uses `AccessNestedFieldsTrait`):
  - `create()` injects `entity.repository`; constructor stores `$applies_on`.
  - `applies($entity)` — TRUE when `appliesOn[entityTypeId]` is set and either the bundle list is
    empty (all bundles) or the entity's bundle is in it.
  - `getEntityFallbackValues($entity)` — runs `getEntityFallbackValuesFromDefinitions($entity,
    $this->getEntityFallbackDefinitions())`. Subclasses implement only
    `getEntityFallbackDefinitions()`.

## Writing a plugin

Place a class in `<your_module>/src/Plugin/entity_fallback_value/` extending
`AbstractEntityFallbackValuePlugin`:

```php
/**
 * @EntityFallbackValuePluginAnnotation(
 *   id = "node",
 *   applies_on = { "node.page" }
 * )
 */
class Node extends AbstractEntityFallbackValuePlugin implements EntityFallbackValuePluginInterface {
  public function getEntityFallbackDefinitions(): array {
    return [
      'title'       => ['field_override_title', 'title'],
      'description' => ['paragraph_thumbnail.field_description', 'field_description'],
    ];
  }
}
```

`applies_on = {}` / listing just `"node"` = all node bundles. Each definition value is an ordered
list of field paths (dot syntax across references/nested data) or PHP callables; resolution rules
are in [../api/service.md](../api/service.md).

## Drush generator

`src/Drush/Generators/EntityFallbackValueGenerators.php` registers the DCG generator
`plugin:entity_fallback_value` (attribute `#[Generator(name: 'plugin:entity_fallback_value', …)]`,
type `MODULE_COMPONENT`, template `plugin.twig`). Run:

```
drush generate plugin:entity_fallback_value
```

It prompts for machine name, plugin label, plugin id, class, then loops entity types and bundles
(`askForAppliesOn()` using `entity_type.manager` + `entity_type.bundle.info`) and writes
`src/Plugin/entity_fallback_value/<Class>.php`. This is developer tooling (`drush generate`), not a
runtime Drush command.
