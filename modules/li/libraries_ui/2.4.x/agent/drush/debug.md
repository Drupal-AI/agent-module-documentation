<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `libraries:debug`

Class `Drupal\libraries_ui\Commands\LibrariesUiCommands` (registered via `drush.services.yml`).

| Command | Alias | Effect |
|---|---|---|
| `libraries:debug` | `ld` | Interactive picker of extensions (or "All libraries"); prints a table of each selected library's **Name / Version / Dependencies**. |

```bash
drush libraries:debug     # or: drush ld
```

It calls the same `LibrariesUiService::getAllLibraries()` the report page uses, then renders a
Symfony console table per chosen extension. Useful for scripting/CI inspection of library metadata
without a browser.
