<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `--configure-only` workflow and its artifacts

Migrate Upgrade has no config UI. Its only "configuration" is the set of `migrate_plus`
config entities that `drush migrate:upgrade --configure-only` **generates** from a legacy
source, which you then edit for a custom migration.

## What `--configure-only` produces

For a detected source version `<v>` (e.g. `7`), `export()` writes:

- **One migration group** — `migrate_plus.migration_group.migrate_drupal_<v>`
  (config entity type `migration_group`, id `migrate_drupal_<v>`), with:
  - `label`: `Import from Drupal <v>`
  - `description`: `Migrations originally generated from drush migrate-upgrade --configure-only`
  - `source_type`: `Drupal <v>`
  - `shared_configuration.source.key`: `drupal_<v>` (the DB connection key; the actual
    `database` credentials are only embedded when `--legacy-db-url` was used).
- **One migration per source migration** — `migrate_plus.migration.<prefix><id>`
  (config entity type `migration`). Each generated migration:
  - has its id prefixed with `--migration-prefix` (default `upgrade_`), with `:` replaced by
    `_` — e.g. core's `d7_user` becomes `upgrade_d7_user`;
  - sets `migration_group` to `migrate_drupal_<v>` so it belongs to the group above;
  - carries the full `source` / `destination` / `process` / `migration_dependencies` copied
    from the core migration plugin, with internal id references rewritten to the prefixed ids.

The `--migration-prefix` exists so the generated entities do **not** collide with the core
migration plugin ids they originate from.

## Suggested customization path

1. Fresh, empty target site; enable only the destination modules you want to migrate into.
2. `drush migrate:upgrade --legacy-db-url=… --configure-only` → generates the entities above.
3. Create a custom module with a `config/install/` dir (depending on `migrate_plus` +
   `migrate_drupal`).
4. `drush config:export --destination=/tmp/export`, copy the generated
   `migrate_plus.migration.*` and `migrate_plus.migration_group.migrate_*` YAML into the
   module's `config/install/` (keep the DB credentials out of git — define the connection in
   `settings.php` under the group's `source.key`).
5. Edit the YAML for your custom path; reinstall, enable the module + `migrate_tools`, and
   run/roll back the migrations with `drush migrate:import` / `migrate:rollback`.

## The upgrade marker (state)

A **non**-`--configure-only` run records the state key `migrate_drupal_ui.performed`
(request timestamp). `migrate:upgrade-rollback` only acts when that key is present, and
deletes it afterward. Inspect it with:

```
drush php:eval 'var_dump(\Drupal::state()->get("migrate_drupal_ui.performed"));'
```

Generated migrations are ordinary `migrate_plus` entities — list them with
`drush migrate:status` (from `migrate_tools`) or
`drush config:get migrate_plus.migration_group.migrate_drupal_7`.
