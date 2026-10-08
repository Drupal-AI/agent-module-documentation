<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fields

## `meta_entity` base fields (`MetaEntity::baseFieldDefinitions()`)

| Field | Type | Notes |
|-------|------|-------|
| `label` | string (base field key `label`) | Title, max 512, translatable. Auto-computed in `hook_entity_presave` when empty. |
| `target` | dynamic_entity_reference | Required, cardinality 1. The host entity. Constraints `UniquePerMetaTypeAndTarget` + `MappedTargetEntity`. |
| `created` | created | Creation timestamp. |
| `changed` | changed | Last-edited timestamp. |

Entity keys: `id`, `bundle` = `type`, `label`, `uuid`, `langcode`. Add your own configurable fields
to each meta entity type via Field UI or config, exactly like any content bundle — that is where the
actual metadata (counters, ratings, notes) lives.

You add metadata fields per *type* (bundle). Example test config ships `field_count` (integer) on a
`visit_count` type; add equivalents for your own types.

## Computed reverse-reference field (on the host)

Registered by `hook_entity_bundle_field_info` for each mapping entry whose bundle settings set a
`field_name`. It is a computed, single-value `entity_reference` base field on the host bundle:

- `target_type` setting = the meta entity type id (`meta_entity`).
- `meta_entity_type_id` setting = the meta bundle id (e.g. `visits`).
- Class `MetaEntityReverseReferenceItemList`; value is resolved lazily via the type's repository
  `getMetaEntityForEntity($host, $bundle)`.
- Label `"<meta type label> reference"`, display-configurable on view.

Read it like any entity reference:

```php
$node->visits->entity;                 // the MetaEntity, or empty if none
$node->visits->entity->field_count->value;
```

Because it is computed, it is always in sync with stored meta entities and needs no separate save;
it is not written directly (writing happens on the meta entity, or on host create via the reverse
field wiring in `preSave`/`postSave`).
