# Migrate File To Media — agent index

Tooling to migrate `file`/`image` fields to core Media entities, with binary-hash duplicate
detection. No config object of its own; you drive it with Drush commands + migrate_plus
migrations. Requires media, file, migrate, migrate_tools, migrate_plus, migrate_drupal.

- **Drush commands (generate media fields, duplicate detection) + the `mf2m_media` generator** →
  [drush/commands.md](drush/commands.md)
- **Migrate source/process/destination plugins it provides** →
  [plugins/migrate-plugins.md](plugins/migrate-plugins.md)
- **The step-1 / step-2 workflow, the mapping tables, and the event subscriber** →
  [api/workflow.md](api/workflow.md)

Submodule (documented separately, nested under this project):
- `migrate_file_to_media_example` — a complete worked Article image migration.

Key facts:
- `drush migrate:file-media-fields <entity_type> <bundle> <source_field_type> <target_media_bundle>`
  (alias `mf2m`) creates a `<field>_media` entity-reference field for each matching file field.
- `drush migrate:duplicate-file-detection <migration>` fills `migrate_file_to_media_mapping` with
  binary hashes; **must be run before importing step 1**.
- Step 1 source plugin `media_entity_generator` (creates media, dedupes); step 2 source
  `content_entity:<type>` + process `file_id_lookup` (links media onto the reference field).
- Mapping tables: `migrate_file_to_media_mapping`, `migrate_file_to_media_mapping_media`.
