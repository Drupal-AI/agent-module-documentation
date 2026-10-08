<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Defining a meta entity type

A meta entity *type* is a bundle config entity `meta_entity_type` (class
`Drupal\meta_entity\Entity\MetaEntityType`, config prefix `meta_entity.type.*`). It names a kind of
metadata (e.g. `visits`, `downloads`) and declares which host entity-type/bundles may be annotated
with it. There is **no module-wide settings form**; you "configure" the module by adding types.

Admin: `/admin/structure/meta-entity` (route `meta_entity.type.admin`) lists types; add at
`/admin/structure/meta-entity/add`; edit at `/admin/structure/meta-entity/manage/{meta_entity_type}`.
Add fields to a type via Field UI (base route `entity.meta_entity_type.edit_form`) exactly like any
content-entity bundle. Only the `administer meta entity` permission reaches these routes.

## Config schema (`config/schema/meta_entity.schema.yml`)

| Key | Type | Meaning |
|-----|------|---------|
| `id` | string | Machine name (also the bundle id of `meta_entity`). |
| `label` | label | Human name. |
| `description` | text | Optional description. |
| `mapping` | sequence | `mapping[<target_entity_type_id>][<target_bundle_id>]` → bundle settings. |
| `mapping.*.*.field_name` | string (nullable) | Reverse-reference computed field exposed on the host bundle. |
| `mapping.*.*.auto_create` | boolean | Auto-create a meta entity when a host of this bundle is inserted. |

Notes on `mapping`:
- Keyed by target entity type id, then by target bundle id. For bundleless entity types (e.g.
  `user`) use the entity-type id as the bundle key (`user` → `user`).
- An **empty** bundle settings array still allows attaching this metadata to that bundle, but
  exposes no reverse field and does not auto-create.
- `field_name` must match `^[a-z][a-z0-9_]{0,31}$`, be unique per target entity type + meta type,
  and not collide with an existing (non-meta_entity) field on the host bundle (validated in
  `MetaEntityTypeForm::validateForm()`).
- The type declares config dependencies on the module that provides each mapped entity type and on
  mapped bundle config entities; removing those cleans the mapping (`MetaEntityType::calculateDependencies()` / `onDependencyRemoval()`).

## Create a type in PHP

```php
use Drupal\meta_entity\Entity\MetaEntityType;

MetaEntityType::create([
  'id' => 'visits',
  'label' => 'Visits',
  'mapping' => [
    'node' => [
      // 'article' nodes expose a computed `visits` field and auto-get a meta entity on insert.
      'article' => ['field_name' => 'visits', 'auto_create' => TRUE],
      // 'page' nodes may be annotated but get no reverse field and no auto-create.
      'page' => [],
    ],
    // Bundleless entity type: use the entity-type id as the bundle key.
    'user' => ['user' => []],
  ],
])->save();
```

Then add fields to the type (config or Field UI), e.g. an integer `field_count`.

## Create a type as installed config

`config/install/meta_entity.type.visits.yml`:

```yaml
langcode: en
status: true
dependencies: {  }
id: visits
label: 'Visits'
description: ''
mapping:
  node:
    article:
      field_name: visits
      auto_create: true
```

After changing `field_name` values on a type, rebuild caches so the host bundle's computed field
list (`hook_entity_bundle_field_info`) picks them up.
