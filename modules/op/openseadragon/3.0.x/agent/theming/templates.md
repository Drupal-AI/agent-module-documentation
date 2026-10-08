# Theming

## Theme hooks (`openseadragon_theme()`)
- `openseadragon_formatter` — variables `item`, `entity`, `settings`. Template
  `templates/openseadragon-formatter.html.twig`. Preprocessed by
  `template_preprocess_openseadragon_formatter()` which builds tile sources from the entity's file
  field (checking file `view` access), sets `attributes` (class `openseadragon-viewer`, id
  `openseadragon-viewer-<entity id>`), and attaches the library + `drupalSettings`.
- `openseadragon_iiif_manifest_block` — variable `iiif_manifest_url`. Template
  `templates/openseadragon-iiif-manifest-block.html.twig`. Preprocessed by
  `template_preprocess_openseadragon_iiif_manifest_block()` which parses the manifest into tile
  sources (unique id via `Html::getUniqueId`) and attaches the same library/settings.

Both early-return (rendering nothing) when `iiif_server` is empty or there are no tile sources.

## Library (`openseadragon.libraries.yml`)
- `openseadragon/init` — `js/openseadragon_viewer.js` + `css/openseadragon.css`, depends on
  `core/drupal`, `core/once`, `core/drupalSettings`, and `openseadragon/openseadragon`.
- `openseadragon/openseadragon` — the OpenSeadragon 6.0.2 library loaded **externally** from
  `https://cdn.jsdelivr.net/npm/openseadragon@6.0.2/…` (New BSD). Control button sprites also load
  from that CDN path (`prefixUrl`). No local library download is required.

## Overriding
Copy either template into your theme, or restyle `.openseadragon-viewer`. Viewer behavior is driven
by `drupalSettings.openseadragon[<id>].options` (see [../configure/settings.md](../configure/settings.md)),
so most visual/interaction changes belong in the settings form rather than the template.

## Mime types
`hook_file_mimetype_mapping_alter()` adds `image/jp2` (`.jp2`) and `image/tiff` (`.tiff`) so those
files are recognized as images and become valid tile sources.
