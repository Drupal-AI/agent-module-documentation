# file_mdm — agent start

Service to read/cache/write file metadata (image size, EXIF, fonts) via pluggable
FileMetadata plugins. Consumed by other modules (e.g. ImageEffects), not site builders.
Config UI: **Admin → Config → System → File metadata manager** (`file_mdm.settings`).
Submodules: `file_mdm_exif`, `file_mdm_font`.

- Caching settings + per-plugin config entities → [configure/settings.md](configure/settings.md)
- Use the manager/metadata service in code → [api/service.md](api/service.md)
- Define a FileMetadata plugin (new metadata type) → [plugins/file-metadata.md](plugins/file-metadata.md)
