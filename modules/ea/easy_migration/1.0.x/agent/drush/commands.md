<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands + code generator

Command class `Drupal\easy_migration\Drush\Commands\EasyMigrationCommands` (registered in
`drush.services.yml`, tag `drush.command`, constructor-injected with the
`EntityMigrationPluginManager`). All commands operate on the discovered `EntityMigration` plugins.
These are CLI-only; there is no web UI, route, or permission.

## `easy_migration:status` (alias `ems`)

Prints a table of every migration plugin. For each definition it instantiates the plugin and shows
`order`, `id`, `label`, `description`, `total` (`countItemsToMigrate()`), `migrated`
(`countMigratedItems()`). Rows are sorted by `order`. Returns a `RowsOfFields`
(so `--format=json|csv|…` works).

```
drush ems
```

## `easy_migration:migrate` (alias `emi`)

Runs `doMigrate()` on each matching plugin, in ascending `order`.

- `--id=<plugin_id>` — run just that one plugin.
- `--tag=<a,b>` — run plugins whose `tags` intersect the given list (OR match). (Note: the option is
  declared as `--tag` but the code reads `$options['tags']`; without an id and without a working tag
  filter it runs **all** plugins.)
- No options → run all plugins.

```
drush emi                     # all migrations
drush emi --id=page           # only the "page" plugin
drush emi --tag=node,user     # plugins tagged node OR user
```

`doMigrate()` is idempotent per item (via `isAlreadyMigrated()`), so re-running updates existing
destination entities rather than duplicating them.

## `easy_migration:rollback` (alias `emrollback`)

Prompts for confirmation (`Do you really want to rollback…?`, default No; aborts with
`UserAbortException` on decline), then calls `rollback()` on each matching plugin in **descending**
`order` (reverse of migrate). Same `--id` / `--tag` selection as migrate. Rollback deletes the
migrated destination entities and their `easy_migration` map rows.

```
drush emrollback             # roll back everything (after confirm)
drush emrollback --id=article
drush emrollback --tag=node
```

## Code generator: `plugin:easy_migration:content_entity` (alias `em-content_entity`)

`Drupal\easy_migration\Drush\Generators\ContentEntityGenerator` (attribute-registered
`#[Generator(...)]`, `type: MODULE_COMPONENT`, template dir `templates/generator`). Interactively
asks for machine name, human name, and class name (`askMachineName()` / `askName()` /
`askClass(default: '{machine_name|camelize}')`), then writes
`src/Plugin/EasyMigration/{class}.php` from `content-entity.twig`.

```
drush generate plugin:easy_migration:content_entity
# or: drush generate em-content_entity
```

The generated class extends `EntityMigrationBase`, carries a sample `@EntityMigration` annotation
(id `article`, entity_type `node`, source `drupal7`, order 40), and stubs `getIds()` / `getData()` /
`saveEntity()` with example Drupal 7 SQL to edit. Prompt inputs are validated by the Drupal Code
Generator interviewer (machine-name and class-name rules), and the file is written under the target
module component's `src/Plugin/EasyMigration/`. This generator is a developer scaffolding tool
invoked from a shell — the same trust boundary as any `drush generate`.

Note: the alternative service-based generator registration in `easy_migration.services.yml` is
**commented out**; only the attribute-registered generator above is active.
