<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Source Directory (migrate_source_directory) — agent index

Migrate **source plugin** (`plugin: directory`) that walks one or more filesystem
directories and yields one migration row per file, exposing each file's path and stat
metadata as source properties. Consumed from a migration YAML `source:` block.

- **Depends on** core `migrate`. Core: `^9 || ^10 || ^11`. Package `Migration`.
- **No** configure route/settings form, permissions, services, drush commands, hooks, or
  new plugin type — `configure` is null.
- **Provides** one migrate source plugin (an instance of core's migrate-source plugin type).

Solution docs:
- **Use the directory source in a migration (config keys, source fields, worked examples)**
  → [plugins/directory.md](plugins/directory.md)

Key facts:
- Plugin id: `directory` (`@MigrateSource`, `source_module = "migrate_source_directory"`).
- Class: `Drupal\migrate_source_directory\Plugin\migrate\source\Directory` extends `SourcePluginBase`.
- Config keys: `directory` (required, string|list), `file_mask` (PCRE regex), `recurse_level`
  (int, default `-1`), `id_prefix` (string), `file_must_contain_string` (string|list); plus
  core `track_changes`. Legacy alias `urls` → `directory`.
- Row ID: `sourceID` (string). Source fields: `sourceID`, `source_file_basename`,
  `source_file_extension`, `source_file_filename`, `source_file_mtime`, `source_file_path`,
  `source_file_pathname`, `source_file_realpath`, `source_file_size`, `source_file_type`.
- The directory paths come from the migration definition (config), validated with `is_dir()`
  when the plugin is built; the directory is scanned at import time.
