<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the `entity_reference_uuid` field type

The field behaves like core Entity Reference, but persists the target's **UUID** in a
`varchar_ascii(128)` column named `<field>_target_uuid`. No integer `target_id` is stored. Use it
when references must survive across databases/environments (migration, content deployment,
default content, multisite).

## Add via Field UI

1. On a bundle's *Manage fields*, choose **"Entity reference UUID"** (category *Reference*), or one
   of the preconfigured **"<Entity type> by UUID"** options (generated from common reference
   targets via `getPreconfiguredOptions()`).
2. Storage setting: **`target_type`** (required — the entity type to reference).
3. Field settings: **reference method** (`handler`) and **handler settings**
   (`handler_settings`) — the same selection-handler UI as core entity reference (target bundles,
   sort, auto-create, etc.).
4. Pick a widget and formatter (see below).

## Add as a base field (custom entity)

```php
$fields['publisher'] = \Drupal\Core\Field\BaseFieldDefinition::create('entity_reference_uuid')
  ->setLabel(t('Publisher'))
  ->setSetting('target_type', 'node')
  ->setSetting('handler', 'default')
  ->setSetting('handler_settings', ['target_bundles' => ['publisher']])
  ->setDisplayConfigurable('form', TRUE)
  ->setDisplayConfigurable('view', TRUE);
```

For Views relationships on such base fields, use `EntityReferenceUuidEntityViewsTrait` inside your
entity's `EntityViewsData` subclass and call `processViewsDataForEntityReferenceUuid()` /
`addReverseEntityReferenceUuid()`.

## Setting / reading values in code

```php
// Set by UUID (main property is target_uuid, not target_id):
$node->set('field_ref', ['target_uuid' => $target->uuid()]);
// A scalar string is treated as a UUID; an object is set as the entity:
$node->field_ref = $target->uuid();
$node->field_ref->entity = $target;

// Read: resolves UUID -> entity via loadByProperties(['uuid' => ...]).
$referenced = $node->field_ref->entity;
$all = $node->field_ref->referencedEntities();
```

Passing both `target_uuid` and `entity` that disagree (for a saved entity) throws
`InvalidArgumentException`. Autocreate is supported: assign a new (unsaved) entity and it is saved
when the host entity is saved, its UUID captured in `preSave()`.

## Widgets

Default: `entity_reference_autocomplete`. Also enabled by the module:
`entity_reference_autocomplete_tags`, `options_select`, `options_buttons`,
`inline_entity_form_simple`, `inline_entity_form_complex`, `select2_entity_reference`,
`chosen_select` (contrib widgets apply only if their module is installed). All resolve targets
through the field's selection handler, which enforces target type/bundle and reference access.

## Formatters

- **`entity_reference_label`** (core, default) — label, optionally linked. Access-checked.
- **`entity_reference_uuid_entity_view`** ("Rendered entity") — renders the referenced entity in a
  chosen **view mode** via the entity view builder. Has a recursion guard (aborts past depth 20).
  Only available for target types that have a view builder (`isApplicable()`).

Both render through core's access-checked `getEntitiesToView()`, so a viewer never sees a
referenced entity they lack `view` access to.

## Validation on save

The item list adds core's **`ValidReference`** constraint plus a dynamic `EntityType` constraint on
the computed `entity` property. An arbitrary/nonexistent UUID, a wrong-type target, or a target the
user may not reference fails validation — same guarantees as core entity reference.

## Views

- Forward relationship handler: `entity_standard_uuid` (joins target base table on `uuid`).
- Reverse relationship handler: `entity_reverse_uuid`.
- Taxonomy-term UUID filter: `entity_reference_uuid_taxonomy_index_uuid`.
- Entity queries auto-join on `uuid` because `EntityReferenceUuidServiceProvider` swaps the SQL
  query `Tables` class.

## Performance note

UUID resolution is a 36-character string lookup, not an indexed-integer one. Expect measurably
slower per-row resolution in large listings; use the ID-based core field where portability is not
needed.
