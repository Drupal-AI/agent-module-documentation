# Configure Islandora IIIF

## Settings form

Route `islandora_iiif.islandora_iiif_config_form` → `/admin/config/islandora/iiif`
(`IslandoraIIIFConfigForm`), requires `administer site configuration`. Writes `islandora_iiif.settings`:

| Field | Key | Notes |
|---|---|---|
| IIIF Image server location | `iiif_server` | URL of a IIIF Image API server (e.g. Cantaloupe). On save it is validated as a URL **and** checked for reachability. |
| Use relative file paths in manifest | `use_relative_paths` | bool. |
| Show title in viewer | `show_title` | select/string. |

```bash
drush cset islandora_iiif.settings iiif_server 'https://iiif.example.org/cantaloupe/iiif/2/' -y
```

## The `iiif_manifest` Views style

`src/Plugin/views/style/IIIFManifest.php` (`@ViewsStyle(id="iiif_manifest")`) renders a View as a IIIF
Presentation 2.1 `sc:Manifest`. Build a View (usually a `manifest.json` path display listing a node's
children/pages), pick **IIIF Manifest** as the style, then set its options (schema `views.style.iiif_manifest`):

- `iiif_tile_field` — image field(s) whose file is the tile source for each canvas.
- `iiif_ocr_file_field` + `structured_text_term_uri` — structured OCR (hOCR) file field + the media-use term
  that identifies it (enables text highlighting).
- `search_endpoint` — path for IIIF Content Search (in-viewer full-text search).
- `metadata_fields` — fields to include as manifest `metadata`.
- `canvas_label` — field used to label each canvas.

`render()` reads `iiif_server` from config, builds one canvas per row with an image service URL, and sets the
manifest `label` from the View title. Point a IIIF viewer (OpenSeadragon, Mirador, Universal Viewer) at the
resulting manifest URL.

## The IIIF media-attributes Action

`media_attributes_from_iiif_action` (`src/Plugin/Action/MediaAttributesFromIiif.php`) queries the IIIF image
info of a media's source and writes the image **width/height** into configured fields
(`source_term_uri`, `width_field`, `height_field`). Run it (e.g. from a Context or bulk action) so manifests
have correct canvas dimensions. It uses the `IiifInfo` service and the configured `iiif_server`.
