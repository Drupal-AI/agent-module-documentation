<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Registered via `drush.services.yml`. All are ACMS operational/diagnostic tooling.

| Command | Alias | Args / options | Behavior |
| --- | --- | --- | --- |
| `acms:get-schema` | `ags` | `--modules=a,b` (optional CSV) | Prints installed schema version of the given modules (all installed modules if none given). Reads the `system.schema` key-value store. |
| `acms:update-db` | `aupdb` | — | Runs `drush updatedb` on self with `cache-clear=1, entity-updates=0, post-updates=1`, logging each line to the `acquia_cms_db_update` logger channel (so syslog/Sumo Logic captures it). |
| `acms:rerun-schema` | `ars` | `<module_name> <schema_version>` | Sets a module's schema version in `system.schema`, then runs `updatedb` — used to re-run a specific `hook_update_N()`. Validates version ≥ 8000 and ≤ current installed version. |
| `acms:import-site-studio-packages` | `aissp` | — | Calls `AcmsUtilityService::siteStudioPackageImport()` — rebuilds/imports Site Studio (cohesion) packages when `acquia_cms_site_studio` + cohesion keys are present. |
| `acms:starter-kit` | `askt` | — | Prints the human-readable starter-kit name from `AcmsUtilityService::getStarterKit()`. |
| `acms:toggle:modules` | `atm` | — | Calls `ToggleModulesService::toggleModules()` — installs/uninstalls modules by detected environment (dev: dblog/field_ui/views_ui/jsonapi_extras, uninstall autologout; non-dev: autologout; non-prod: reroute_email; Acquia non-IDE: imagemagick). |
| `acms:config-reset` | `acr` | `[package...]` `--scope=` `--delete-list=` | Interactive wizard that re-imports the canonical shipped config (`config/install` + `config/optional`) for selected ACMS modules back over active config. Destructive — warns to test off-production first. |

`acms:config-reset` scope values: `config`, `site-studio`, `all` (default allowed scope is `config`;
`site-studio`/`all` become available when Site Studio is present). `--delete-list` is a comma-separated
list of config names to delete during the import. Non-interactive use (`-y`) requires both a package and a
`--scope`.

## Command-alter hook

`Commands\Hooks::processConfig` implements `@hook alter config:get` adding a `--generic` option to core's
`config:get` that strips `uuid` and `_core` from the output:

```bash
drush config:get --generic system.site
```
