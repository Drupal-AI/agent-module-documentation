<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How a field block resolves and renders (`Drupal\fieldblock\Plugin\Block\FieldBlock`)

## Finding the entity — `getEntity()`

1. Take the derivative id as the target entity type (`fieldblock:node` → `node`).
2. Read the **current route's** `parameters` option; if the route or its parameters are empty,
   return `NULL`.
3. Order the parameter names with `sortParameterNames()` — see below — then iterate them and ask
   the route match for each parameter's **upcast value**. Take the first value that
   - is a `ContentEntityInterface`,
   - has a `canonical` link template,
   - has `getEntityTypeId() === <derivative id>`,
   - `hasField($field_name)`.
4. Otherwise return `NULL`. (Result is memoised on `$this->fieldBlockEntity`.)

**Changed in 2.4:** the block no longer filters parameters by the route's declared `type`
(previously it required a `type` starting with `entity:`). It now inspects the actual upcast
value of every parameter, because not every parameter that ends up holding an entity is declared
with an `entity:` type — the node **preview** route, for example, declares its own `node_preview`
type but its param converter still returns a node. So field blocks now also work on such routes.

Consequences worth knowing:

- The block appears on routes that carry the entity as a parameter with a `canonical` link
  template — the canonical page (`/node/12`), revision and preview routes. It does **not** work on
  `/node/12/edit`-style or listing routes that never upcast a matching entity.
- It is not bundle-aware: one placement covers every bundle that has the field.

### Revision routes — `sortParameterNames()`

Revision-view routes carry the entity **twice**: once as the default revision and once as the
revision being viewed (core declares the latter with an `entity_revision:<type>` parameter type).
`sortParameterNames()` returns the `entity_revision:<entity_type>` parameter names **before** all
others, so the revision on display — not the default revision — is the one the block renders.

## Access — `blockAccess()`

```php
$entity = $this->getEntity();
if (!$entity) { return AccessResult::forbidden(); }
$field = $entity->get($this->configuration['field_name']);
return AccessResult::allowedIf(!$field->isEmpty())
  ->andIf($field->access('view', $account, TRUE));
```

So: no entity → hidden; empty field → hidden; no field `view` access → hidden. Field-level view
access **is** enforced, which is why a field block silently disappears instead of rendering an
empty (or unauthorised) wrapper.

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

**Changed in 2.4:** `getTranslatedFieldFromEntity()` now resolves the translation with the
injected `entity.repository` service (`EntityRepositoryInterface::getTranslationFromContext()`),
so the field renders in the negotiated **content** language — the same translation the rest of the
page shows — rather than the interface language. (2.3 re-pointed the field via
`EntityAdapter::createFromEntity()` at the interface language.) `entity.repository` is a new
constructor dependency of the plugin.

## Cache metadata

- `getCacheTags()` → the entity's cache tags (falls back to the block's own when no entity).
- `getCacheContexts()` → `parent` contexts merged with `route` **and**
  `languages:LANGUAGE_TYPE_CONTENT`. **The content-language context is new in 2.4:** a language
  prefix is stripped before routing, so `/node/1` and `/de/node/1` are the same route with the
  same parameters; without this context the render cache would hand one language's field to the
  other.

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
