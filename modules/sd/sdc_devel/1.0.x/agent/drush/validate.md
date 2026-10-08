# Drush: `sdc-devel:validate`

Class `src/Drush/Commands/SdcDevelCommands.php`.

```
drush sdc-devel:validate <project> [id] [--install]
drush sdcv <project>                 # alias
```

- `project` (arg) — machine name of the module/theme whose components to validate. Accepts a
  comma-separated list for several projects.
- `id` (arg, optional) — a single component id (e.g. `mytheme:card`) to validate instead of all.
- `--install` — install the project first if it is disabled (module via drush `pm:install`, theme
  via the theme installer), then uninstall it again after validating.

Output is a `RowsOfFields` table with columns `component`, `severity`, `message`, `type`, `line`,
`source`. Exit/logging: a per-project notice, `success` when clean, `warning` with a problem count
otherwise. It clears the SDC plugin cache and iterates `plugin.manager.sdc->getAllComponents()`,
filtering by `getBaseId() === project`. Read-only apart from the optional temporary install/uninstall.

Typical CI use: `drush sdc-devel:validate my_theme` and fail the build on warnings.
