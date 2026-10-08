Islandora IIIF exposes repository objects as IIIF Presentation manifests (via a Views style) and points them at a IIIF Image server, so viewers like OpenSeadragon or Mirador can display deep-zoom tiles and paged content.

---

The submodule adds a **Views style plugin** `iiif_manifest` (`IIIFManifest`) that renders a View of a node's
children/pages as a IIIF Presentation 2.1 `sc:Manifest` JSON document: each row becomes a canvas whose image
service points at the configured IIIF Image server, with options for the tile-source image field(s), a
structured-OCR (hOCR) file field and structured-text term, a search endpoint (for IIIF Content Search), and
which fields become canvas labels/metadata. Configuration lives at `/admin/config/islandora/iiif`
(`IslandoraIIIFConfigForm`, `islandora_iiif.settings`): the **IIIF Image server URL** (`iiif_server`, e.g. a
Cantaloupe server, validated for reachability on save), whether to use **relative paths** in the manifest
(`use_relative_paths`), and whether/how to **show the title** in the viewer (`show_title`). A helper service
`IiifInfo` builds image-service URLs, and a Context Action `media_attributes_from_iiif_action` populates a
media's width/height fields by querying the IIIF image info of its source. Typically you create a
`manifest.json` View display on a node using the `iiif_manifest` style and feed its URL to a IIIF viewer.
Depends only on `islandora`. No permissions.

---

- Serve a IIIF Presentation manifest for a compound/paged repository object from a View.
- Drive an OpenSeadragon or Mirador viewer from Islandora content.
- Provide deep-zoom tiled access to large images via a IIIF Image server (e.g. Cantaloupe).
- Configure the IIIF Image server URL centrally at `/admin/config/islandora/iiif`.
- Validate that the configured IIIF server is reachable when saving settings.
- Choose which image field supplies the tile source for each canvas.
- Include structured OCR (hOCR) data so viewers can highlight/search text on the page.
- Expose a IIIF Content Search endpoint path for in-viewer full-text search.
- Map node/media fields to canvas labels and manifest metadata.
- Use relative or absolute paths in the manifest depending on deployment.
- Show or hide the object title in the viewer.
- Populate media width/height from IIIF image info via the `media_attributes_from_iiif_action` Action.
- Build a `manifest.json` Views display per content model (paged content, books, newspapers).
- Present multi-page books/newspapers as ordered canvases.
- Integrate Islandora with the broader IIIF ecosystem for interoperable image delivery.
- Combine with islandora_image derivatives to serve service files as tile sources.
