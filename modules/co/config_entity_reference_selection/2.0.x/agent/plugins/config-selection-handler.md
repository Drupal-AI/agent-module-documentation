<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `config:<type>` selection handler

## What it is

`src/Plugin/EntityReferenceSelection/ConfigEntityReferenceSelection.php` defines a single
`#[EntityReferenceSelection]` plugin:

```php
#[EntityReferenceSelection(
  id: 'config',
  label: 'Config: entity reference selection',
  group: 'config',
  weight: 1,
  deriver: 'Drupal\\config_entity_reference_selection\\Plugin\\Derivative\\ConfigEntityReferenceSelection'
)]
class ConfigEntityReferenceSelection extends DefaultSelection { ... }
```

It **extends core `DefaultSelection`**, so it inherits the normal query, validation, and
autocomplete behaviour and only overrides what it needs.

## Derivation — one handler per config entity type

`src/Plugin/Derivative/ConfigEntityReferenceSelection.php` implements
`ContainerDeriverInterface`. `getDerivativeDefinitions()` loops
`entityTypeManager->getDefinitions()` and, for every entity type where
`entity_type->entityClassImplements(ConfigEntityInterface::class)` is true, registers a derivative
keyed by the entity type id:

```php
$this->derivatives[$entity_type_id] = $base_plugin_definition;
$this->derivatives[$entity_type_id]['entity_types'] = [$entity_type_id];
$this->derivatives[$entity_type_id]['label'] =
  $this->t('Config: Filtered by specific @entity_type', ['@entity_type' => $entity_type->getPluralLabel()]);
```

So the plugin manager exposes `config:image_style`, `config:node_type`, `config:user_role`,
`config:view`, `config:filter_format`, `config:menu`, `config:field_config`, etc. — verified on a
running site. The derivative's `entity_types` key means Drupal only offers that handler for fields
whose `target_type` matches, exactly like core's per-type default handlers.

## Configuration and the query filter

`defaultConfiguration()` adds `filter => ['allowed_ids' => NULL]` on top of the parent's.

`buildEntityQuery($match, $match_operator)`:

```php
$query = parent::buildEntityQuery($match, $match_operator);
if ($target_type = $this->getTargetType()) {
  $allowed = $this->getConfiguration()['filter']['allowed_ids'];
  if (!empty($allowed)) {
    $query->condition($target_type->getKey('id'), $allowed, 'IN');
  }
}
return $query;
```

- The parent handles the label `$match` (CONTAINS/STARTS_WITH/etc.) as usual.
- The only added constraint is `<id key> IN (allowed_ids)`, and only when the list is non-empty.
- **Empty `allowed_ids` = no restriction** (all entities of the type are allowed).
- `getTargetType()` resolves `configuration['target_type']` via the entity type manager and logs a
  `critical` message (channel `config_entity_reference_selection`) if the definition is missing.

## Settings form

`buildConfigurationForm()` calls the parent, then adds `filter.allowed_ids` as a `#multiple`
`select` whose `#options` come from `getOptions()` (flattened via `OptGroup::flattenOptions`).
If the type has no referenceable entities, a warning paragraph is shown instead. Auto-create is
removed: `$form['auto_create']['#access'] = FALSE`.

`getOptions()`:

```php
$entities = $storage->loadMultiple();
foreach ($entities as $entity) {
  if ($entity->access('view label')) {          // access-filtered
    $event = new LabelDisplayEvent($entity);
    $this->eventDispatcher->dispatch($event, Events::LABEL_DISPLAY);
    $options[$entity->id()] = $event->getLabel();
  }
}
asort($options);
```

`validateConfigurationForm()` re-saves `settings.handler_settings.filter.allowed_ids` through
`array_values()` so the stored sequence has no keys (matches the config schema's `sequence`).

## Label event (extension point)

`Events::LABEL_DISPLAY` = `'config_entity_reference_selection_label_display'`, event
`src/Event/LabelDisplayEvent.php` (`getEntity()`, `getLabel()`, `setLabel()`; label defaults to
`$entity->label()`). Dispatched once per candidate entity while building the allowed-ids options.
Subscribe to it to override how a config entity is labelled in that picker.

Built-in subscriber `src/EventSubscriber/FieldConfigLabelDisplaySubscriber.php` targets
`field_config` entities and rewrites the label to
`@entity_type - @bundle - @field` (or `@entity_type - @field` for types without bundles), so the
many like-named field labels across bundles become distinguishable.

## Notes for agents

- This plugin does **not** define a new plugin type; it registers a plugin for core's existing
  `entity_reference_selection` manager. `provides_plugin_types` is therefore empty.
- The `group` is `config`; the human-facing "Reference method" select on a field shows the derived
  label "Config: Filtered by specific &lt;plural label&gt;".
