# Islandora IIIF — agent index

Exposes Islandora objects as IIIF Presentation manifests (Views style) backed by a IIIF Image server, for
deep-zoom / paged-content viewers. Configure at `/admin/config/islandora/iiif`. Depends on `islandora`. No
permissions.

- **Settings (`iiif_server`, relative paths, title), the `iiif_manifest` Views style, and the IIIF action** →
  [configure/iiif.md](configure/iiif.md)

Key facts:
- Config `islandora_iiif.settings`: `iiif_server` (IIIF Image API base URL, validated on save),
  `use_relative_paths` (bool), `show_title` (string). Form route
  `islandora_iiif.islandora_iiif_config_form`.
- Views style `iiif_manifest` (`src/Plugin/views/style/IIIFManifest.php`) → outputs a IIIF 2.1
  `sc:Manifest`; options include `iiif_tile_field`, `iiif_ocr_file_field`, `structured_text_term_uri`,
  `search_endpoint`, `metadata_fields`, `canvas_label`.
- Context Action `media_attributes_from_iiif_action` (`MediaAttributesFromIiif`) — sets media width/height
  fields from IIIF image info (config: `source_term_uri`, `width_field`, `height_field`).
- Service `IiifInfo` builds image-service URLs.
