OpenSeadragon Viewer displays image and file fields as deep-zoom, pan-and-zoom tiled images served by an external IIIF image server, using the OpenSeadragon JavaScript library. It provides a field formatter and a IIIF-manifest block, both wired to a site-wide viewer configuration.

---

The module (part of the Islandora ecosystem) exposes an `openseadragon_image` field formatter for `image`/`file` fields that turns each referenced file into an OpenSeadragon tile source. In `template_preprocess_openseadragon_formatter()` it checks `view` access on every file, builds tile-source URLs as `{iiif_server}/{urlencode(file public URL)}`, and attaches `drupalSettings.openseadragon[<id>]` plus the `openseadragon/init` library (which loads OpenSeadragon 6.0.2 from the jsDelivr CDN). A second path, the `openseadragon_block` block plugin, renders a viewer from a **IIIF Presentation manifest**: an admin enters a manifest URL (which may contain `[node:…]` tokens) when placing the block, and `IIIFManifestParser::getTileSources()` (using Guzzle) fetches the manifest, token-replaces against the current node, resolves relative URLs against the front page, and extracts each `sequences[].canvases[].images[].resource.service.@id` as a tile source. Global settings live in `openseadragon.settings` and are edited at *Configuration → Media → OpenSeadragon settings* (`configure` = `openseadragon.admin_settings`, gated by `administer site configuration`): the required `iiif_server` base URL, an optional `manifest_view`, and a very large `default_options`/`viewer_options` map mirroring OpenSeadragon's own options (zoom, pan, gestures, navigator, sequence/collection mode, etc.), all described in `config/schema/openseadragon.schema.yml`. The `Config` service merges user overrides over defaults and filters nulls; `FileInformation` guesses image mime types (adding JP2 and TIFF mappings via `hook_file_mimetype_mapping_alter`). There are no permissions of its own and no Drush. Requires `token`; the OpenSeadragon and IIIF server assets are external (CDN + your IIIF server), so nothing needs to be downloaded locally.

---

- Display a high-resolution image field as a zoomable, pannable deep-zoom viewer.
- Serve tiled images from a IIIF image server (e.g. Cantaloupe) instead of shipping full images.
- Show scanned manuscripts, maps, or artworks with smooth zoom for archives and GLAM sites.
- Present multi-page objects in sequence (paged) mode with previous/next controls.
- Display several images together in collection mode as a grid.
- Render a IIIF Presentation manifest via the OpenSeadragon block.
- Build per-node manifest URLs with tokens (e.g. `node/[node:nid]/manifest`) in the block.
- Point the viewer at a Views-generated IIIF manifest via the manifest view setting.
- Add JP2 and TIFF images to Drupal media (mime mappings registered by the module).
- Enforce file `view` access before exposing a file as a tile source in the formatter.
- Show a mini-map navigator overlay for large images.
- Enable rotation controls for orientation-sensitive scans.
- Constrain or free zoom limits (min/max zoom level, pixel ratio) per site.
- Fit the image to the viewport on load (constrain to viewport option).
- Tune pan/zoom gestures separately for mouse, touch, and pen input.
- Configure the reference filmstrip for browsing a sequence of images.
- Toggle navigation, zoom, home, and full-page controls.
- Set a default zoom level and initial rotation for all viewers.
- Integrate zoomable images into an Islandora repository site.
- Reuse one central viewer configuration across every image field on the site.
- Display a generic file field (not just image fields) through the IIIF server.
- Provide accessible tab-index control for the viewer canvas element.
