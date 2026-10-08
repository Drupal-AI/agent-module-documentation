Islandora Mirador integrates the [Mirador](https://projectmirador.org) IIIF image/document viewer into Drupal as a configurable block and field formatter, rendering a IIIF Presentation manifest for repository items.

---

The module ships a `mirador_block` Block plugin and a `mirador_image` field formatter (for `image`/`file` fields) that both render the `mirador` theme hook, which boots a Mirador viewer against a IIIF manifest URL. The manifest URL is a **token pattern** (default `[node:url:unaliased:absolute]/manifest`) resolved per node — Islandora's `islandora_iiif` REST view normally provides that manifest. A single admin settings form (`/admin/config/media/mirador`, permission `administer site configuration`) controls the library source (remote CDN build vs a local `/libraries/mirador/dist/main.js`), which Mirador plugins are enabled, the theme (light/dark/system + primary/secondary palette colors), interface-language support, and the manifest URL token pattern. It defines a small plugin type (`IslandoraMiradorPlugin`) whose implementations inject configuration into Mirador's `window` config array via `windowConfigAlter()`; two ship in-box — Mirador Image Tools and Text Overlay (hOCR text selection/accessibility). By default the compiled Islandora Mirador library loads from a jsDelivr CDN (`islandora/mirador-integration-islandora@0.2.3`). All viewer configuration is passed to the browser through `drupalSettings.mirador.viewers` and instantiated by `js/mirador_viewer.js`. Depends on `islandora`, `islandora_iiif`, core `block`, and `token`.

---

- Embed a Mirador IIIF viewer on Islandora Repository Item nodes via a block.
- Display a single image/file field through Mirador with the `mirador_image` field formatter.
- Show a multi-page (paged content / book) viewer by pointing the block at a `book-manifest` URL.
- Configure the IIIF manifest URL pattern with node tokens (e.g. `[node:url:unaliased:absolute]/manifest`).
- Serve the Mirador library from the default remote CDN build without self-hosting.
- Self-host the Mirador build at `/libraries/mirador/dist/main.js` and switch the module to "local".
- Flag a self-hosted local library as minified so it loads correctly.
- Enable the Mirador Image Tools plugin for brightness/contrast/invert image manipulation.
- Enable the Text Overlay plugin so OCR'd (hOCR) text is selectable and screen-reader accessible.
- Pick a light, dark, or OS-preference ("system") Mirador theme.
- Override the Mirador light/dark primary and secondary palette colors.
- Auto-localize the viewer UI to the site's current interface language.
- Place the Mirador block through core Blocks or Islandora Contexts keyed on a display-hint term.
- Trigger viewer placement using the "Mirador" term in the `islandora_display` vocabulary.
- Add a minimal-UI viewer (no close/maximize/sidebar) by instantiating the block plugin with `window_config` overrides.
- Alter Mirador window/workspace options from a theme via `hook_preprocess_mirador()`.
- Register support for an additional compiled-in Mirador plugin by implementing the `IslandoraMiradorPlugin` plugin type.
- Provide search-within-the-viewer over hOCR when paired with `islandora_iiif_hocr`.
- Import the `islandora_display` "Mirador" display hint term via `drush migrate:import islandora_mirador_tags`.
- Reuse one manifest URL pattern site-wide so every repository item renders consistently.
- Present digitized archival TIFF/JP2 scans with deep-zoom in a repository UI.
- Cache viewer render output per node/media with config-tag invalidation on settings changes.
