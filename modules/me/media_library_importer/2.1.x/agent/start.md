# Media Library Importer — agent index

Scans a server folder and bulk-creates File + Media entities for matching files, via a queue processed as a
batch (needs `queue_ui`). Idempotent (skips existing bundle+filename). Depends on `media`, `media_library`,
`queue_ui`. Submodule: `media_image_exif_importer`.

- **Settings form, all config keys, the two routes** → [configure/settings.md](configure/settings.md)
- **`media_library_importer.service`: `generateImportQueue()`, `processImportQueue()`, folder scan, cron use** →
  [api/service.md](api/service.md)
- **Drush `media-library:import` / `mli`** → [drush/commands.md](drush/commands.md)
- **The `hook_alter_media_library_importer_media_extra_fields` alter** → [hooks/hooks.md](hooks/hooks.md)
- **The two permissions and what they gate** → [permissions/permissions.md](permissions/permissions.md)

Submodule:
- `media_image_exif_importer` → [../../modules/media_image_exif_importer/2.1.x/agent/start.md](../../modules/media_image_exif_importer/2.1.x/agent/start.md)

Key facts:
- Config object `media_library_importer.settings`: `import_folder`, `exclude_styles`, `import_files_to_media_location`,
  `media_types_import`, `media_types_fields`.
- Import folder is scanned with `glob("$folder/*.{<exts>}", GLOB_BRACE)`; extensions come from each selected media
  type's source field `file_extensions`.
- Queue id `media_library_importer`; worker `MediaLibraryImporterQueue` calls `createMediaEntity()`.
