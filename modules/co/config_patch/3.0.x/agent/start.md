# Config Patch — agent index

Creates unified-diff patches between active and sync configuration so UI config changes can
be committed back to source. Adds a **Patch** tab on the config-sync page, a toolbar
drift-count widget, a pluggable output system, and two Drush commands.

- **Global settings (`config_base_path`, default output plugin), routes & permissions,
  `settings.php` override** → [configure/settings.md](configure/settings.md)
- **The `output` plugin type: annotation, interfaces, base class, text fallback, how to add
  a submission target** → [plugins/output.md](plugins/output.md)
- **Drush `config:patch` and `config:patch:list`** → [drush/commands.md](drush/commands.md)

Key facts:
- Config object `config_patch.settings`: `config_base_path` (relative), `output_plugin`.
- Access: patch/toolbar/clear-cache = `export configuration`; revert = `import configuration`;
  settings = `administer config_patch` — all restricted core/admin permissions.
- Comparison in `src/ConfigCompare.php` (uses `sebastian/diff`); respects Config Ignore.
- Bundled output plugin `config_patch_output_text` (`Text`) is the fallback for any unknown id.
