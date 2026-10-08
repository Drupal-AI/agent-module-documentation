# Migrate Default Content Export — agent index

Companion submodule of `migrate_default_content`. Exports live site content into
`ENTITY_TYPE.BUNDLE.yml` fixture files (the format the parent imports), via a Drush command.
Adds a `content_export_dir` setting to the parent's settings form. No permissions, no UI beyond
that field. Two extensible plugin types govern serialization.

- **Drush command** (`migrate-default-content:export-content` / `mdcec`, all options & scoping)
  → [drush/commands.md](drush/commands.md)
- **`FieldProcessor` and `ExportEntityFilter` plugin types** (how field values are serialized /
  which entities are skipped, and how to add your own) → [plugins/processors.md](plugins/processors.md)

Parent module: [../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md)

Key facts:
- Export dir: `content_export_dir` on `migrate_default_content.settings` (relative to `source_dir`).
- Default filters skip uid-1 (admin) and anonymous users; password fields are stripped.
- Null field values are dropped unless `--allow-null`; a `DEFAULT_IGNORED_FIELDS` list removes
  revision/timestamp/translation bookkeeping fields.
