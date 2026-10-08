# Configuring OpenSeadragon

Form `\Drupal\openseadragon\Form\OpenSeadragonSettingsForm` at `/admin/config/media/openseadragon`
(`openseadragon.admin_settings`, permission `administer site configuration`). Single config object
`openseadragon.settings`; defaults in `config/install/openseadragon.settings.yml`; full schema in
`config/schema/openseadragon.schema.yml`.

## Top-level keys
| Key | Type | Notes |
|---|---|---|
| `iiif_server` | uri (required) | Base URL of your IIIF Image API server **without** trailing slash, e.g. `http://127.0.0.1:8080/cantaloupe/iiif/2`. Empty → viewers render nothing. |
| `manifest_view` | string | Optional machine name of a View that generates IIIF manifests (used by the block flow). |
| `default_options` | mapping | The shipped OpenSeadragon option defaults (see below). |
| `viewer_options` | mapping | User overrides; `Config::getSettings()` returns `viewer_options + default_options`, null-filtered before going to JS. |

## Viewer options (`default_options` / `viewer_options`)
A large map that mirrors the OpenSeadragon JS API, plus one module-specific flag. Grouped:
- **Module-specific:** `fit_to_aspect_ratio` (bool) — fit the whole image into the viewport on load.
- **Chrome / a11y:** `tabIndex`, `debugMode`, `debugGridColor`.
- **Rendering:** `blendTime`, `alwaysBlend`, `immediateRender`, `opacity`, `compositeOperation`,
  `placeholderFillStyle`, `useCanvas`, `minPixelRatio`, `smoothTileEdgesMinZoom`, `imageLoaderLimit`,
  `maxImageCacheCount`, `timeout`, `tileSize`, `crossOriginPolicy`, `ajaxWithCredentials`.
- **Initial view / rotation:** `defaultZoomLevel`, `degrees`, `homeFillsViewer`.
- **Zoom constraints:** `minZoomLevel`, `maxZoomLevel`, `minZoomImageRatio`, `maxZoomPixelRatio`,
  `visibilityRatio`.
- **Pan:** `panHorizontal`, `panVertical`, `constrainDuringPan`, `wrapHorizontal`, `wrapVertical`.
- **Resize:** `autoResize`, `preserveImageSizeOnResize`.
- **Controls / fade:** `autoHideControls`, `controlsFadeDelay`, `controlsFadeLength`.
- **Zoom/animation rates:** `zoomPerClick`, `zoomPerScroll`, `zoomPerSecond`, `springStiffness`,
  `animationTime`.
- **Click thresholds:** `clickTimeThreshold`, `clickDistThreshold`, `dblClickTimeThreshold`,
  `dblClickDistThreshold`, `minScrollDeltaTime`, `pixelsPerWheelLine`.
- **Gestures (per input):** `gestureSettingsMouse|Touch|Pen|Unknown` — each a map
  (`scrollToZoom`, `clickToZoom`, `dblClickToZoom`, `pinchToZoom`, `flickEnabled`, `flickMinSpeed`,
  `flickMomentum`, `pinchRotate`) validated by the reusable `openseadragon.gesture_settings` type.
- **Navigation controls:** `mouseNavEnabled`, `showNavigationControl`, `navigationControlAnchor`,
  `showZoomControl`, `showHomeControl`, `showFullPageControl`, `showRotationControl`.
- **Navigator (mini-map):** `showNavigator`, `navigatorPosition`, `navigatorSizeRatio`,
  `navigatorMaintainSizeRatio`, `navigatorTop/Left/Height/Width`, `navigatorAutoFade`, `navigatorRotate`.
- **Sequence (paged):** `sequenceMode`, `showSequenceControl`, `sequenceControlAnchor`,
  `navPrevNextWrap`, `initialPage`, `preserveViewport`, `preserveOverlays`.
- **Reference strip:** `showReferenceStrip`, `referenceStripScroll`, `referenceStripPosition`,
  `referenceStripSizeRatio`, `referenceStripHeight/Width`.
- **Collection:** `collectionMode`, `collectionRows`, `collectionColumns`, `collectionLayout`,
  `collectionTileSize`, `collectionTileMargin`.

`sequenceMode` is forced at render time to `count(tile_sources) > 1 && !collectionMode`.
The form validates numeric fields via an internal `elementValidateNumber`. `id`, `element`, and
`tileSources` are intentionally **not** user-configurable (set per viewer instance).

## Using the field formatter
On an entity's *Manage display*, set an `image` or `file` field's format to **OpenSeadragon**
(`openseadragon_image`). Each file becomes a tile source `{iiif_server}/{urlencode(file url)}`; files
failing `view` access are skipped.

## Using the block
Place the **Openseadragon block**; in its form enter a IIIF manifest URL — a relative path or full
URL, optionally with `[node:…]` tokens (validated by `token_element_validate`). See
[../api/services.md](../api/services.md) for the manifest fetch/parse.

## Related config
`block.settings.openseadragon_block.iiif_manifest_url` (string) stores the block's manifest URL.
Install `drupal/coi` (suggested) to inspect config overrides on some fields.
