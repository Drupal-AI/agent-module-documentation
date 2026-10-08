# file_mdm_font — agent start

Submodule of `file_mdm`. Registers the **`font`** FileMetadata plugin
(`src/Plugin/FileMetadata/Font.php`) reading TTF/OTF/WOFF metadata via php-font-lib
(`dompdf/php-font-lib`). Requires `file_mdm`. Read-only; no UI of its own (cache config
via the parent's settings and the `file_mdm_font.file_metadata_plugin.font` config
entity).

Usage: get a file's metadata object from `FileMetadataManagerInterface`, then
`getMetadata('font', $key)`. Supported keys: `FontType`, `FontWeight`, plus all
OpenType `name`-table entries (family, subfamily, full name, PostScript name, version,
copyright, …). See parent
[api/service.md](../../../file_mdm/3.2.x/agent/api/service.md) and the plugin-type doc
[plugins/file-metadata.md](../../../file_mdm/3.2.x/agent/plugins/file-metadata.md).

- Config schema in `config/schema/file_mdm_font.schema.yml`.
