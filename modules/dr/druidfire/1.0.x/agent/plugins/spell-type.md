<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `Spell` plugin type and the transformation pipeline

A **Spell** is a field-transformation plugin. Druidfire defines the plugin type and the pipeline
that applies a spell to one existing field.

## Type definition (from source)

- **Manager:** `Drupal\druidfire\SpellManager` (`src/SpellManager.php`), registered as service
  `plugin.manager.druidfire_spell` with `parent: default_plugin_manager`. Extends
  `DefaultPluginManager`; discovery dir `Plugin/Spell`, interface `SpellInterface`, annotation
  `Drupal\druidfire\Annotation\Spell`, alter hook **`druidfire_spell_info`**, cache key
  `druidfire_spell_plugins`. Default `class` is `SpellBase`. Helpers: `getAvailableSpells()`
  (= `getDefinitions()`) and `createSpell($plugin_id, $configuration = [])` (= `createInstance()`).
  - Note: `src/Plugin/SpellManager.php` is a near-identical **unused duplicate** class — the
    services file wires the top-level `Drupal\druidfire\SpellManager`, so that is the live manager.
- **Annotation:** `@Spell` (`src/Annotation/Spell.php`) — properties `id`, `label` (Translation),
  `description` (Translation).
- **Interface:** `SpellInterface` (`src/SpellInterface.php`) — five methods, all receiving/returning
  arrays:
  - `schema(array $schema, string $tableName, string $columnName, array $args = []): array` — mutate
    the SQL table schema array (and usually issue live `Schema` ALTERs).
  - `storage(array $yaml, array $args = []): array` — mutate the `field.storage.*` config record.
  - `field(array $yaml, array $args = []): array` — mutate the `field.field.*` config record.
  - `formDisplay(array $yaml, string $fieldName, array $args = []): array` — mutate
    `core.entity_form_display.*`.
  - `viewDisplay(array $yaml, string $fieldName, array $args = []): array` — mutate
    `core.entity_view_display.*`.
- **Base class:** `SpellBase` (`src/SpellBase.php`) extends `PluginBase`, implements
  `SpellInterface` + `ContainerFactoryPluginInterface`. Its `create()` injects the `database`
  service and exposes `$this->database` (`Connection`) and `$this->schema`
  (`$this->database->schema()`, a `Schema`). Every interface method has a **no-op default**
  (returns its input unchanged), so a spell overrides only the steps it needs.

## How a spell is applied — `Druidfire::__call()`

`Drupal\druidfire\Druidfire` (`src/Druidfire.php`, service `druidfire`) has **no per-spell methods**;
calling `->resize(...)`, `->err2er(...)`, etc. hits the magic `__call($spellName, $arguments)`. For
`->spellName($entityTypeId, $fieldName, $optionalArguments = [])` it does, in order:

1. `columnName = FieldInspector::getColumnName($entityTypeId, $fieldName, $optionalArguments['property'] ?? NULL)`.
2. Reads `key = "$entityTypeId.field_schema_data.$fieldName"` from the keyvalue collection
   **`entity.storage_schema.sql`** (constructor: `$keyValueFactory->get('entity.storage_schema.sql')`).
3. `spell = spellManager->createSpell($spellName)` — **the method name is the plugin id.**
4. For each table in that stored schema: prints a "Changing the schema of …" message, then
   `schema = spell->schema($schema, $tableName, $columnName, $optionalArguments)`; exceptions are
   caught and surfaced as a warning (the loop continues).
5. Writes the (possibly modified) schema back to the keyvalue store.
6. `configManager->changeConfig($entityTypeId, $fieldName, $spell, 'storage', $optionalArguments)`
   then the same for `'field'` (the `field` pass also drives `formDisplay`/`viewDisplay`).
7. `fieldInspector->clearCachedDefinitions()`.

`getAvailableSpells()` proxies the manager for `druidfire:list-spells`.

Key consequence: the spell id **must equal** the service method / Drush subcommand name. The Drush
layer hardcodes the five shipped ids; via PHP you call `->{id}()` directly. `createSpell()` throws
`PluginNotFoundException` for an unknown id.

## Writing a custom spell

1. Add `src/Plugin/Spell/MySpell.php` in your module, `extends SpellBase`, with an `@Spell`
   annotation (`id`, `label`, `description`). The `id` is what callers invoke.
2. Override only the interface methods you need (schema/storage/field/formDisplay/viewDisplay).
   Use `$this->schema` for live DDL (`changeField`, `addField`, `dropField`, `addIndex`) and mutate
   the passed `$schema`/`$yaml` arrays so the persisted state matches.
3. Read the shipped spells in [shipped-spells.md](../plugins/shipped-spells.md) as templates.
4. Invoke via `\Drupal::service('druidfire')->mySpell($entityType, $field, $args)`. (Drush only
   exposes the five built-in commands; custom spells run through the service or your own command.)
5. Other modules may reshape definitions via `hook_druidfire_spell_info(&$definitions)`.
