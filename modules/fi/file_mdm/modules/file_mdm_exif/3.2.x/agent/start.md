# file_mdm_exif — agent start

Submodule of `file_mdm`. Registers the **`exif`** FileMetadata plugin
(`src/Plugin/FileMetadata/Exif.php`) reading/writing EXIF via the PEL library. Requires
`file_mdm`. No UI of its own — cache config via the parent's settings and the
`file_mdm_exif.file_metadata_plugin.exif` config entity.

Usage: get a file's metadata object from `FileMetadataManagerInterface`, then
`getMetadata('exif', $key)` (value = `['text' => ..., 'value' => ...]`); write back with
`saveMetadataToFile('exif')`. See parent
[../../file_mdm/3.2.x/agent/api/service.md](../../../file_mdm/3.2.x/agent/api/service.md).

- Service `Drupal\file_mdm_exif\ExifTagMapperInterface` maps tag names ↔ IFD/tag ids.
- Plugin type + how to build your own FileMetadata plugin: see file_mdm's
  [plugins/file-metadata.md](../../../file_mdm/3.2.x/agent/plugins/file-metadata.md).
- Config schema in `config/schema/file_mdm_exif.schema.yml`.
