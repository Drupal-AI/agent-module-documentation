<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `entity_routing_map` plugin type

Form Mode Manager **defines** this plugin type to map an entity type's core add/edit/add-page
routes so it can derive per-form-mode routes.

- Manager service: `plugin.manager.entity_routing_map` (class `EntityRoutingMapManager`,
  subdir `Plugin/EntityRoutingMap`, interface `EntityRoutingMapInterface`, base
  `EntityRoutingMapBase`).
- Annotation: `@EntityRoutingMap` (`src/Annotation/EntityRoutingMap.php`).
- **Fallback**: implements `FallbackPluginManagerInterface`; unknown entity types fall back to the
  `generic` plugin.
- Alter hook: `hook_entity_routing_map_info_alter()`. Cache: `form_mode_manager_routes_info_plugins`.

## Annotation properties

| Property | Meaning |
|---|---|
| `id` | Plugin id (usually the entity type id, e.g. `node`). |
| `label` | Human label. |
| `targetEntityType` | The entity type id this maps. |
| `defaultFormClass` | Add form operation name (default `default`). |
| `editFormClass` | Edit form operation name (default `edit`). |
| `operations` | Map of `add_form` / `edit_form` / `add_page` → core route names. |
| `contextualLinks` | Map of contextual link routes. |

## Built-in plugins

`node`, `user`, `taxonomy_term` (Term), `block_content` (BlockContent), and `generic` (fallback).
Example (`Plugin/EntityRoutingMap/Node.php`):

```php
/**
 * @EntityRoutingMap(
 *   id = "node",
 *   label = @Translation("Node Routes properties"),
 *   targetEntityType = "node",
 *   defaultFormClass = "default",
 *   editFormClass = "edit",
 *   operations = {
 *     "add_form" = "node.add",
 *     "edit_form" = "entity.node.edit_form",
 *     "add_page" = "node.add_page"
 *   }
 * )
 */
class Node extends EntityRoutingMapBase {}
```

## The generic fallback

`Generic` builds operations dynamically from the target entity type
(`entity.{type}.add_form` / `entity.{type}.edit_form` / `{type}.add_page`) and takes an
`entityTypeId` in its configuration. Most standard content entities work without a bespoke plugin.

## Add support for a custom entity

Create `src/Plugin/EntityRoutingMap/MyEntity.php` in your module with an `@EntityRoutingMap`
annotation whose `id`/`targetEntityType` is your entity type and whose `operations` point at your
entity's real add/edit/add_page route names. Clear caches; FMM will use it to build the form-mode
routes for your entity.
