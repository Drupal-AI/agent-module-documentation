<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How a field block resolves and renders (`Drupal\fieldblock\Plugin\Block\FieldBlock`)

## Finding the entity — `getEntity()`

1. Take the derivative id as the target entity type (`fieldblock:node` → `node`).
2. Read the **current route's** `parameters` option and iterate them.
3. Use the first parameter whose `type` starts with `entity:` **and** whose upcast value is a
   `ContentEntityInterface` that
   - has a `canonical` link template,
   - has `getEntityTypeId() === <derivative id>`,
   - `hasField($field_name)`.
4. Otherwise return `NULL`.

Consequences worth knowing:

- The block only appears on routes that carry the entity as a parameter — in practice the
  canonical page (`/node/12`) and other routes that upcast the same entity. It does **not**
  work on `/node/12/edit`-style routes that have no canonical link template match, nor on
  listing pages.
- It is not bundle-aware: one placement covers every bundle that has the field.

## Access — `blockAccess()`

```php
$entity = $this->getEntity();
if (!$entity) { return AccessResult::forbidden(); }
$field = $entity->get($this->configuration['field_name']);
return AccessResult::allowedIf(!$field->isEmpty())
  ->andIf($field->access('view', $account, TRUE));
```

So: no entity → hidden; empty field → hidden; no field `view` access → hidden. This is why a
field block silently disappears instead of rendering an empty wrapper.

## Build — `build()`

```php
$build['field'] = $this->getTranslatedFieldFromEntity($entity)->view([
  'label' => 'hidden',
  'type' => $this->configuration['formatter_id'],
  'settings' => $this->configuration['formatter_settings'],
]);
if ($this->configuration['label_from_field'] && !empty($build['field']['#title'])) {
  $build['#title'] = $build['field']['#title'];   // block title = field label
}
```

`getTranslatedFieldFromEntity()` re-points the field item list at the entity translation for the
current interface language (via `EntityAdapter::createFromEntity()`), so translated values render.

## Cache metadata

- `getCacheTags()` → the entity's cache tags (falls back to the block's own when no entity).
- `getCacheContexts()` → `['route']` — every canonical URL has its own entity and fields.

## Field definitions & formatters

A field block works across bundles, so it only has **field storage definitions**. The plugin
builds a usable definition with
`BaseFieldDefinition::createFromFieldStorageDefinition($storage_definition)` and feeds that to
`plugin.manager.field.formatter` with `view_mode => '_custom'`. Formatter settings forms are
embedded and their `#states` selectors rewritten from Field UI's
`fields[<field>][settings_edit_form]` to `settings[formatter][settings]`
(`FormHelper::rewriteStatesSelector()`).

## Dependencies — `calculateDependencies()`

Adds `config: field.storage.<entity_type>.<field_name>` and `module: <formatter provider>` to the
block entity, so exporting/importing a field block carries the right dependencies.

## Deriver

`FieldBlockDeriver::getDerivativeDefinitions()` creates one derivative per entity type accepted by
`FieldBlockController::isBlockableEntityType()` (i.e. listed in
`fieldblock.settings:enabled_entity_types`, or the `node`/`user`/`taxonomy_term` fallback), with
`admin_label` = `@type field`. Clear the block plugin cache after changing that config.
