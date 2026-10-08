<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The migrations: set up source DB & run

No settings form (`configure` is `null`). Configuration is standard migrate_plus: a source
database plus running the shipped migrations.

## Shipped migrations

Config entities installed by the module (`config/install/`):

| Config | id | Group | Source plugin | Destination |
|---|---|---|---|---|
| `migrate_plus.migration.d7_views_migration` | `d7_views_migration` | `views_migration` | `d7_views_migration` | `entity:view` |
| `migrate_plus.migration.d6_views_migration` | `d6_views_migration` | `views_migration` | `d6_views_migration` | `entity:view` |
| `migrate_plus.migration_group.views_migration` | group `views_migration` | — | — | — |

Each migration's `process` maps: `id: name`, `label: human_name`, `description`, `tag`,
`base_table`, `base_field`, `display`. The real per-handler transformation happens inside the
source/destination + handler plugins (see [plugins/handlers.md](../plugins/handlers.md)).

## 1. Configure the legacy source database

The migrations read a Drupal 6/7 database. Set it up the normal migrate_drupal way — either
run the core **Upgrade** UI (`/upgrade`, provided by `migrate_upgrade`/`migrate_drupal`) which
registers the source DB and creates migrations, or add a `migrate` database connection in
`settings.php` and reference it from the migration's `source` (a `key`/`database_state_key`).
`views_migration` itself does not configure the connection.

## 2. Run the migrations (migrate_tools Drush)

The module adds no Drush command; use migrate_tools:

```bash
drush migrate:status d7_views_migration          # how many views to migrate
drush migrate:import d7_views_migration           # migrate all D7 views
drush migrate:import d7_views_migration --idlist=frontpage,archive   # only these view ids
drush migrate:import d7_views_migration --update  # re-import already-migrated views
drush migrate:rollback d7_views_migration         # remove migrated views
```

The migrated result is Drupal `view` config entities (`views.view.<id>`).

## 3. "Views ID List" in the UI

`views_migration_form_migration_execute_form_alter()` adds a **Views ID List** textfield to
the migrate_tools execute form (`migrate_tools.execute`) **only for the `views_migration`
group**. Entering comma-separated view ids limits the run to those views (it sets migrate's
`idlist` with `idlist-delimiter = ','`). The custom submit handler runs import / rollback /
stop / reset accordingly via a `MigrateBatchExecutable`.

## Migration state hints

`migrations/state/views_migration.migrate_drupal.yml` marks which D7 view-related modules are
considered "finished" (views, views_slideshow, draggableviews, views_bulk_operations,
views_data_export, better_exposed_filters, metatag_views, views_infinite_scroll) vs
"not_finished" (D6 views), for the core upgrade audit.
