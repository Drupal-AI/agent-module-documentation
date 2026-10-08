<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Class `Drupal\config_auto_export\Drush\Commands\ConfigAutoExportCommands` (attribute-based Drush
commands, no aliases). All five verified registered on the enabled 2.2.2 build.

| Command | Method | Effect |
|---|---|---|
| `cae:trigger` | `trigger()` | Calls `Service::triggerExport()` (non-forced — respects paused/enabled/webhook/autorun). Prints success or "Config export can not be triggered!". |
| `cae:status` | `status()` | Prints whether auto export is paused or running (`Service::isPaused()`). |
| `cae:pause` | `pause()` | `Service::pause()` — sets State `config_auto_export.paused = TRUE`. |
| `cae:resume` | `resume()` | `Service::resume()` — clears the pause. |
| `cae:re-import` | `reImport()` | Diffs each file in the export `FileStorage` against active config; deletes unchanged files, writes changed ones back into active config (`CachedStorage::write`), prints the rendered diffs, then `triggerExport(TRUE)` if anything changed. |

`cae:re-import` reads from `config_auto_export.storage` (the configured export directory) and applies
those files onto the live `config.storage` — i.e. it pulls the exported directory back into the
running site. It uses `diff.formatter` + `renderer` only to display the changes.

Example:

```bash
ddev drush cae:status
ddev drush cae:pause      # stop auto-firing the webhook (config is still written on save)
ddev drush cae:resume
ddev drush cae:trigger    # fire the webhook now (only if enabled + webhook set + autorun on)
ddev drush cae:re-import  # apply the export directory back onto active config
```
