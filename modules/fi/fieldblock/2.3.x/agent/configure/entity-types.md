<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Choosing which entity types expose field blocks

## The config object

```yaml
# fieldblock.settings
enabled_entity_types:
  node: node
  user: user
  taxonomy_term: taxonomy_term
```

- Only one key: `enabled_entity_types` (a sequence of entity type ids), schema
  `config/schema/fieldblock.schema.yml`.
- The module ships **no `config/install`**, so `fieldblock.settings` does not exist on a fresh
  install (`drush cget fieldblock.settings` errors). Until the form is saved,
  `FieldBlockController::getEnabledEntityTypes()` falls back to
  `getDefaultEntityTypes()` = `['node', 'user', 'taxonomy_term']` intersected with the entity
  types that actually exist.
- Only **content** entity types are offered (`isFieldBlockCompatible()` requires
  `ContentEntityTypeInterface`).

## Admin UI

Route `fieldblock.field_block_config_form` → `/admin/config/fieldblock/fieldblockconfig`
("Field as Block settings", under *Configuration › System*), permission
**`administer fieldblock`** (the module's only permission).

The form has:

1. **Enable Entity Types** — checkboxes over every content entity type.
2. **Clean up remaining field blocks of removed entity types** — appears only when blocks exist
   for an entity type that is no longer enabled or no longer exists. Ticking one calls
   `BlockEntityStorage::deleteBlocksForEntityType()` and deletes those block placements.

Saving with changed entity types calls `BlockManager::clearCachedDefinitions()`, which is what
makes the new `fieldblock:<type>` derivatives show up in *Block layout › Place block*.

## Doing it from the command line

```bash
# add media to the default three
drush cset fieldblock.settings enabled_entity_types.media media -y
drush cset fieldblock.settings enabled_entity_types.node node -y
drush cset fieldblock.settings enabled_entity_types.user user -y
drush cset fieldblock.settings enabled_entity_types.taxonomy_term taxonomy_term -y
drush cr        # rebuild block plugin definitions
```

or in PHP:

```php
\Drupal::configFactory()->getEditable('fieldblock.settings')
  ->set('enabled_entity_types', ['node' => 'node', 'media' => 'media'])
  ->save();
\Drupal::service('plugin.manager.block')->clearCachedDefinitions();
```

Check the result:

```bash
drush ev 'print implode(", ", array_keys(array_filter(
  \Drupal::service("plugin.manager.block")->getDefinitions(),
  fn($k) => str_starts_with($k, "fieldblock:"), ARRAY_FILTER_USE_KEY))) . PHP_EOL;'
# fieldblock:node, fieldblock:taxonomy_term, fieldblock:user
```

Deleting a key from `enabled_entity_types` removes the derivative but **not** existing block
placements — those become orphans and are listed in the form's cleanup section.

## Helper service

`fieldblock.block_storage` (`Drupal\fieldblock\BlockEntityStorage`, a `ConfigEntityStorage` over
the `block` entity type):

| Method | Does |
|---|---|
| `loadFieldBlocks()` | all `block` entities whose `plugin` starts with `fieldblock:` |
| `getEntityTypesUsed()` | entity type ids taken from those blocks' plugin ids |
| `deleteBlocksForEntityType($entity_type)` | delete every `fieldblock:$entity_type` placement |
