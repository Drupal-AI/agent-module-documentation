<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Options (entity_options) — agent index

Developer **API for managing entity options**: define per-bundle options as `@EntityOption`
plugins, expose them on node-type and node edit forms, and read merged values from
`$node->entity_options`. Version **1.0.0-alpha3** (alpha). Core `^10 || ^11`. License
GPL-2.0-or-later. `hidden: true` (dev/API module). Ships **no options of its own** and supports
**only the Node entity type** in this release.

- Depends on **`pluginformalter`** (`drupal/pluginformalter:^1.7`) — used to alter `node_type_form`.
- No routes, no controllers, **no permissions**, no config objects, no config schema, no Drush.

## What it actually provides (from source)

- **Plugin type `EntityOption`** — annotation `Drupal\entity_options\Annotation\EntityOption`
  (keys: `id`, `label`, `description`, `allow_overrides`); manager service
  `plugin.manager.entity_options` = `Service\EntityOptionsPluginManager` (namespace
  `Plugin/EntityOption`, alter hook `hook_entity_options_info`, interface `EntityOptionInterface`).
  Base class `Plugin\EntityOptionBase` (a ready-made flag/checkbox option).
- **Computed base field `entity_options`** (`entity_options_map` field type) added to **node** in
  `entity_options_entity_base_field_info()`; list class `EntityOptionsItemList`, item
  `Plugin\Field\FieldType\EntityOptionsItem`, default widget `Plugin\Field\FieldWidget\EntityOptionsWidget`.
- **Form alter** `Plugin\FormAlter\EntityOptionsFormAlter` (a `pluginformalter` plugin) on
  `node_type_form` — the bundle-level "Entity Options" tab; saves defaults to the node type's
  third-party settings.
- **Entity hooks** in `entity_options.module` (`insert`/`update`/`delete`) persist and purge
  per-node values in the key-value store.

## Solution docs

- **Plugin type, base class, annotation, how to define an option** →
  [plugins/entity-option.md](plugins/entity-option.md)
- **The computed field, widget, form-alter, manager service, storage & value computation** →
  [api/mechanism.md](api/mechanism.md)
