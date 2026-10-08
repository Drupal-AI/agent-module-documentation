<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Provided by `Drupal\eme\Commands\EmeCommands` (registered in
`drush.services.yml`, service `eme.commands`). Requires Drush
`^10.4 || ^11 || ^12 || ^13`.

| Command | Alias | Purpose |
|---|---|---|
| `eme:export` | `emex` | Export content entities into a generated migration module. |
| `eme:cleanup` | `emecl` | Delete the temporary export (dir + `eme.tar.gz`) from Drupal's temp directory. |
| `eme:release-lock` | `emerl` | Release a stuck `eme` process lock (persistent lock backend / `semaphore` table). |

## `eme:export` options

| Option | Default | Effect |
|---|---|---|
| `--types` | (required) | Comma-separated content-entity type IDs to export (e.g. `node,block_content`). Validated against exportable, non-ignored types. |
| `--id` | `eme.settings:eme_id` or `eme` | Base id; fills in module/prefix/group when those are not given. |
| `--module` | `<id>_content` | Machine name of the generated module. Must not clash with an existing module or a previous export. |
| `--name` | `"<Id> Content Entity Migration"` | Human-readable module name. |
| `--id-prefix` | `<id>` | ID prefix of the generated migrations. |
| `--group` | `<id>` | `migration_group` of the generated migrations. |
| `--destination` | `modules/custom` | Where the module is written (relative to Drupal root, leading/trailing `/` trimmed). |
| `--plugin` | `json_files` | Export plugin id (see `../plugins/export.md`). |
| `--update` | — | Refresh a previously generated export by module name; only `--types` may be re-specified, everything else is read back from the module's `eme_settings`. |
| `--use-batch` | off | Run through Drupal's batch API + `drush_backend_batch_process()` instead of the inline progress-bar loop. |

CLI exports write the module straight into `--destination` (a codebase path), so
no tarball is produced. The web UI leaves `path` empty, which instead builds
`temporary://eme.tar.gz` for download.

```bash
# New export: writes DRUPAL_ROOT/modules/custom/demo_content
drush eme:export --id demo --types node,block_content

# Refresh it after content changed (types kept from the module):
drush eme:export --update demo_content
```

Errors are logged and abort the run: unknown/ignored type IDs, empty
destination, a module name that already exists on disk, or an export module of
that name already present.

## Import (run the generated module)

```bash
# On the target site, after enabling <module> (needs migrate_plus + migrate_tools):
drush migrate:import --group <group> --execute-dependencies
```

## Generated module structure (json_files plugin)

```
<module>/
  <module>.info.yml         # type:module; dependencies include migrate + migrate_plus;
                            # carries an `eme_settings` block (plugin, migrations, types, id-prefix, group)
  <module>.module           # implements hook_migration_plugins_alter + hook_module_implements_alter
  src/MigrationPluginAlterer.php   # rewrites source urls / eme_file_path to the module's real path at runtime
  src/ModuleImplementsAlterer.php  # suppresses content_moderation save hooks during import
  migrations/<prefix>_<type>[_<bundle>].yml   # one migrate plugin definition per type+bundle
  data/<type>[/<bundle>]/<type>-<id>.json     # one JSON source file per exported entity
  assets/<scheme>/...       # copied binary file assets, for exported `file` entities
```

Migration source is Migrate Plus `url` + `file` fetcher + `json` parser. Content
discovery follows entity references (direct and reverse) via the reference
discovery plugins, so selecting `node` also exports referenced media, files,
taxonomy terms, etc. `user:0` (anonymous) is dropped from the result set.
