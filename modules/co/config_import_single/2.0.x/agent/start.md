# Config import single — agent index

Adds one Drush command to import a **single** config YAML file into the active configuration
using core's `ConfigImporter` (no full sync). No UI, no config object, no permissions.
Requires `drush/drush >= 11.3`.

- **The `config_import_single:single-import` / `cis` command, arguments, and behaviour** →
  [drush/single-import.md](drush/single-import.md)

Key facts:
- Command `config_import_single:single-import`, alias `cis`. One argument: the file path.
- The config object name is derived from the **filename without extension** — so
  `user.role.editor.yml` imports as config object `user.role.editor`. Name the file after the object.
- Runs the same validated `ConfigImporter` as `drush config:import`, scoped to that one object
  (can create / update / recreate it).
- Throws on: no file argument ("No file specified."), missing file ("File not found."), or failed
  import ("Failed importing file").
