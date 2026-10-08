<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
# Drush: `config-partial-export` (`cpex`)

Defined in `src/Commands/ConfigPartialExportCommands.php` (registered via `drush.services.yml`).

```
drush config-partial-export <config>     # export named config to the sync dir
drush cpex <config>                       # alias
drush cpex <config> --changelist          # print active-vs-sync diff, do NOT export
```

## Exporting

- `<config>` is a **comma-separated** list of config object names, e.g.
  `system.site,user.role.editor`.
- Each name may contain a shell-style `*` **wildcard**; matching active config names are
  resolved with `StorageInterface::listAll()` + a substring match, e.g.
  `drush cpex "webform.webform.*"` or `drush cpex "views.view.*"`.
- For each resolved name the command reads the object from **active** config storage
  (`config.storage`; if empty it falls back to the config factory's raw data) and **writes** it
  as `<name>.yml` into the site's **config sync directory**
  (`\Drupal\Core\Site\Settings::get('config_sync_directory')`, e.g. `sites/default/files/sync`).
  It logs `Writing <name> to <dir>.` for each file.
- It writes raw data (no config overrides applied). Quote wildcards so the shell doesn't expand
  them.

Example — export one view and read it back:

```bash
drush cpex views.view.frontpage
SYNC=$(drush ev 'print \Drupal::service("file_system")->realpath(\Drupal\Core\Site\Settings::get("config_sync_directory"));')
cat "$SYNC/views.view.frontpage.yml"
```

## `--changelist` (inspect, don't export)

`drush cpex --changelist` builds a `StorageComparer(sync, active)` and prints the config that
differs, grouped by action (create / update / delete):

```
Your configuration has changed:
create
- config.name.added
update
- config.name.changed
```

Notes:
- If the **sync storage is empty** (`config.storage.sync->listAll()` returns nothing) it prints
  *"There are no configuration changes."* and lists nothing — so `--changelist` is only
  meaningful once the sync directory has been populated (e.g. after a `drush cex`).
- `--changelist` never writes files; drop it to actually export.

## Related

The command's public helper `writeConfig($key, $source, $destination, $dir)` performs the single
-object write and is what the wildcard loop calls per match.
