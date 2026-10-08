# Workflow, mapping tables & event subscriber

## The end-to-end workflow

1. **Install core Media** and make sure the target media types (image/document/…) exist.
2. **Generate media fields:** `drush migrate:file-media-fields node article image image` creates a
   `<field>_media` entity-reference field for each `image` field on `node.article`.
3. **Write/generate migrations** (`drush generate mf2m_media`) — a step-1 and a step-2 migration.
4. **Duplicate detection:** `drush migrate:duplicate-file-detection <step1>` computes binary hashes
   into `migrate_file_to_media_mapping` (required before import). Optionally
   `migrate:duplicate-media-detection` + `--check-existing-media` to reuse existing media.
5. **Import step 1** (`drush migrate:import <step1>`) — creates one media entity per unique file,
   deduping via `check_duplicate` / `check_media_duplicate`.
6. **Import step 2** (`drush migrate:import <step2>`) — sets each source entity's `<field>_media`
   reference by resolving file id → media id with `file_id_lookup`.

Translations (`include_translations` + `destination.translations: true`) create translated media;
revisions are supported (see the core patches listed in the module README for revision-heavy sites).

## Mapping tables (`migrate_file_to_media.install` → `hook_schema`)

| Table | Purpose | Key columns |
|---|---|---|
| `migrate_file_to_media_mapping` | file-hash dedup map | `migration_id`, `type`, `fid`, `target_fid`, `media_id`, `binary_hash` |
| `migrate_file_to_media_mapping_media` | existing-media hash map | `media_bundle`, `fid`, `entity_id`, `target_entity_id`, `binary_hash` |

Inspect them directly, e.g.:

```bash
drush sqlq "SELECT migration_id, fid, target_fid, binary_hash FROM migrate_file_to_media_mapping LIMIT 20"
```

## Event subscriber

`MediaMigrateSubscriber` (service `migrate_file_to_media.event_subscriber`) listens to
`MigrateEvents::POST_ROW_SAVE`. When a step-1 migration row (marked with
`source.toggle_media_mapping: true`) saves, it records the mapping between the source file id
(`target_fid`) and the created media id (`media_id`) back into `migrate_file_to_media_mapping`, so
step 2's `file_id_lookup` can resolve it. There is no configuration and no public service API you
call directly — you drive everything through the Drush commands and migrate_plus migrations above.
