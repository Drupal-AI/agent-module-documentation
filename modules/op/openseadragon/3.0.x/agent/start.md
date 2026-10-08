# OpenSeadragon Viewer — agent index

Deep-zoom (IIIF) image viewing for Drupal: a field formatter and a IIIF-manifest block, driven by a
site-wide viewer config. OpenSeadragon 6.0.2 loads from a CDN; tiles come from an external IIIF image
server you configure. Config UI at `/admin/config/media/openseadragon`
(`configure` = `openseadragon.admin_settings`, gated by `administer site configuration`). Requires
core-ish `token`. No permissions of its own, no Drush.

- **Global settings form + every config key (iiif_server, manifest_view, the OpenSeadragon options map)**
  → [configure/settings.md](configure/settings.md)
- **Services & code entry points (Config, IIIFManifestParser, FileInformation), the formatter, the block**
  → [api/services.md](api/services.md)
- **Theme hooks, templates, and the OpenSeadragon/CDN library** → [theming/templates.md](theming/templates.md)

Key facts:
- Field formatter `openseadragon_image` (`src/Plugin/Field/FieldFormatter/…`) for `image`/`file`
  fields → theme `openseadragon_formatter`. Tile source = `{iiif_server}/{urlencode(file url)}`;
  file `view` access is checked per item before exposure.
- Block plugin `openseadragon_block` renders a viewer from a IIIF Presentation manifest URL
  (admin-entered when placing the block; supports `[node:…]` tokens). `IIIFManifestParser` fetches it
  with Guzzle and extracts `sequences[].canvases[].images[].resource.service.@id` tile sources. The
  manifest URL is admin-configured (by-design outbound fetch, not user-controllable host).
- Config service merges `viewer_options` over `default_options`, strips nulls. `iiif_server` is a
  required base URL; empty → viewer renders nothing.
- Adds JP2/TIFF mime mappings via `hook_file_mimetype_mapping_alter`.
- No plugin type of its own; it plugs into core FieldFormatter + Block plugin systems.
