<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `MigrateUpgradeCommands` (registered via `drush.services.yml`). These are the
module's entire public surface — there is no admin UI or API.

| Command | Aliases | Does |
|---|---|---|
| `migrate:upgrade` | `mup`, `migrate-upgrade` | Build and run (or export) a full Drupal-to-Drupal upgrade from a legacy D6/D7 source. |
| `migrate:upgrade-rollback` | `mupr`, `migrate-upgrade-rollback` | Remove everything a previous upgrade imported. |

## `migrate:upgrade` options

You must supply the source database via **exactly one** of `--legacy-db-url` or
`--legacy-db-key` (omitting both throws `You must provide either a --legacy-db-url or
--legacy-db-key.`).

| Option | Purpose |
|---|---|
| `--legacy-db-url` | Drupal 6-style DB URL of the source, e.g. `mysql://user:pw@127.0.0.1/d7db`. |
| `--legacy-db-key` | Name of a source connection already defined in `settings.php` `$databases`. Alternative to `--legacy-db-url`. |
| `--legacy-db-prefix` | Shared table prefix of the source. For a Postgres schema, use `schema.` (trailing period). Partial/mixed prefixing is unsupported. |
| `--legacy-root` | Location of the source's public files: either a site web address (files pulled by HTTP) or a local filesystem path. Needed for file migrations. |
| `--configure-only` | Do **not** run the migrations; export them as `migrate_plus` config entities instead. See [configure/configure-only.md](../configure/configure-only.md). |
| `--migration-prefix` | With `--configure-only`, prefix applied to generated migration ids. Default `upgrade_`. |

The source Drupal version is auto-detected via `migrate_drupal`. Without `--configure-only`
the command imports immediately and sets the `migrate_drupal_ui.performed` state key (the
marker the rollback command looks for).

```
# D7 → current, run the import now (DB URL inline, files over HTTP):
drush migrate:upgrade --legacy-db-url='mysql://root:pw@127.0.0.1/d7' --legacy-root='https://old.example.com'

# D7 source connection already in settings.php as $databases['drupal_7']:
drush migrate:upgrade --legacy-db-key='drupal_7'

# Generate customizable config entities instead of running (custom prefix):
drush migrate:upgrade --legacy-db-url='mysql://root:pw@127.0.0.1/d7' --configure-only --migration-prefix='d7_custom_'
```

## `migrate:upgrade-rollback`

No arguments or options. Prompts for confirmation, then, **if** the
`migrate_drupal_ui.performed` state marker is present (set by this command's earlier import
run or by core's Migrate Drupal UI), removes all imported content and the config entities
(content types, fields, …) created by the upgrade, and deletes the marker. Simple config
that the upgrade merely *modified* (e.g. site name) is **not** restored — recover that from
backup. It does **not** roll back migrations that were exported via `--configure-only`
(those are managed with `migrate_tools`). If no marker is present it just warns
`No upgrade operation has been performed.`

```
drush migrate:upgrade-rollback
```

Run both commands on the current site; they operate on the target, reading the legacy site
only as a data source.
