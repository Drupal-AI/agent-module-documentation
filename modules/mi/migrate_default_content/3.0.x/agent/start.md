# Migrate Default Content — agent index

Auto-generates Migrate API migrations from YAML files in a `default_content/` directory to
import seed/fixture/default content. Depends on core `migrate` + contrib `migrate_source_yaml`.
Provides a Drush command, a config settings form, and one plugin type (source formats).
Content is authored as files by developers — a build/deploy tool, not a runtime feature.

- **Authoring the content YAML files** (file naming, identifiers, entity refs, files, menus,
  multi-component fields, translations, passwords) → [api/content-files.md](api/content-files.md)
- **How migrations are generated & run** (`hook_migration_plugins_alter`, tags/groups,
  `drush migrate:import`) → [api/migrations.md](api/migrations.md)
- **Settings** (`source_dir`, override/export dirs, config form) → [configure/settings.md](configure/settings.md)
- **Drush command** (`migrate-default-content:export-migrations`) → [drush/commands.md](drush/commands.md)
- **`Source` plugin type** (add a non-YAML source format) → [plugins/source.md](plugins/source.md)

Submodule (own docs):
- `migrate_default_content_export` (export site content back to YAML) →
  [../../modules/migrate_default_content_export/3.0.x/agent/start.md](../../modules/migrate_default_content_export/3.0.x/agent/start.md)

Key facts:
- Files live in `source_dir` (default `../default_content`, relative to Drupal root) named
  `ENTITY_TYPE.BUNDLE.yml` (or `...LANGCODE.yml` for translations).
- Migrations are generated dynamically; nothing to enable per file. Tag: `migrate_default_content`.
- No permissions; the settings route requires `administer site configuration`.
