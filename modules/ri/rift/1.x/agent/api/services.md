# Services, Twig filter, entities & endpoints

## Services (`rift.services.yml`)

| Service id | Class | Purpose |
|---|---|---|
| `rift.picture` | `RiftPicture` | Core generator: media entity + config → `<picture>` render array. |
| `rift.twig_extension` | `Rift` | Registers the `rift_picture` Twig filter. |
| `rift.settings` | `RiftSettings` | Read/save `rift.settings`, generate image-style/crop config, list plugin options + toolkit extensions. |
| `rift.media` | `RiftMedia` | **@deprecated** (removed in 2.0.0) — crop detection, superseded by RiftMediaSource plugins. |
| `plugin.manager.rift_source` | `RiftSourceManager` | `rift_source` plugin manager. |
| `plugin.manager.rift_media_source` | `RiftMediaSourceManager` | `rift_media_source` plugin manager. |
| `plugin.manager.rift_picture_view_modes` | `RiftPictureViewModes` | View-mode definitions (YAML + `rift.settings:view_modes`). |
| `rift.route_subscriber` | `Routing\RouteSubscriber` | Alters the core image-style delivery route (see below). |
| `cache.rift_image_dimensions` | cache bin | Caches computed derivative dimensions (`rift_image_dimensions`). |

## The Twig filter / `RiftPicture`

`Rift::getFilters()` registers one filter, `rift_picture`, and runs
`hook_rift_alter(&$filters)` + theme `rift` alter so other modules/themes can add filters.

```twig
{{ media|rift_picture({
  sizes: 'sm:100vw lg:50vw',
  aspect_ratios: '16x9 16x9',
  attributes: { loading: 'lazy' },
}) }}
```

`RiftPicture::responsivePicture(?MediaInterface $media = NULL, array $config = []): array` is the real
entry point (called by both formatters and the `rift_ui` media endpoint). Flow (`src/RiftPicture.php`):

1. `array_merge(getDefaultConfig(), $config)` — `getDefaultConfig()` returns `rift.settings:config`
   plus `url_generation_strategy` = the `source` plugin id. So a caller's `$config` (a view-mode
   definition) overrides the global block per key.
2. `PictureConfig` processes screens/sizes/transforms/multipliers/quality/aspect_ratios/formats/
   attributes/fallback/strategy. **The config keys actually read are** `sizes`, `aspect_ratios`,
   `quality`, `formats`, `attributes`, `fallback_transform`, `url_generation_strategy`, `screens`,
   `transforms`, `multipliers`, `id`. (Note: the README's `types:` key is **not** read — formats come
   from `formats`.)
3. For each `format × size × multiplier` it builds a `<source>`/`srcset` candidate; the URL for each
   is produced by the active **RiftSource** plugin (`generateImageUrlFromStyles()` →
   `$sourcePlugin->generate($styles, $uri)`), and pixels/alt/title come from the active
   **RiftMediaSource** plugin (`getImageData()` / `generateImageBoundaryStyle()`).
4. Builds the fallback `<img>` from `fallback_transform` (split on `-` into image-style ids), computes
   dimensions via `getImageDimension()` (loads each `ImageStyle` and calls `transformDimensions()`).
5. When Twig debug is on, prepends an `<!-- RIFT View Mode : … -->` comment.

Markup is assembled by the small element value-objects in `src/Html/` (`PictureElement`,
`ImgElement`, `SourceElement`, `SizesItem`, `SrcSetItem`, base `ElementBase`). Each renders through
`#type: inline_template` with a Drupal `Attribute` object, so attribute values are auto-escaped.

Deprecated methods on the service (removed in 2.0.0, kept for BC): `responsivePictureFromElement()`,
`getImageMedia()`, `bubbleUpCacheTags()` — they predate the "filter takes a media entity" design.

## `RiftSettings` (`src/RiftSettings.php`)

`final` service. Notable methods: `getSettings()` (raw `rift.settings` data), `saveSettings($input)`
(writes the whitelisted keys `source`, `media_source`, `aspect_ratios`, `config`, `view_modes`, then
regenerates crop/quality/format image styles), `getAvailableSourcePlugins()`,
`getAvailableMediaSourcePlugins()`, `getAvailableExtensions()` (toolkit extensions + a `nop` option).
`saveSettings()` performs no numeric/format validation of its own on `aspect_ratios`/`quality`
(that lives in the RIFT UI client and the starter-kit form).

## Entities & the image-delivery route

- `Drupal\rift\Entity\ImageStyle` replaces core's `image_style` entity class via
  `rift_entity_type_build()`. Its `flush()` also flushes any combined derivatives that embed the
  style (`CombinedImageStyle::loadCombinedBySingle()`), and `postSave()` avoids the parent's blanket
  flush, only flushing when effects actually change.
- `Drupal\rift\Entity\CombinedImageStyle` chains several image styles into a single derivative. It
  merges the effects of each child style, and builds a token as a `-`-joined list of per-style
  `Crypt::hmacBase64(...)` HMACs (`getPathToken()`), i.e. it keeps the standard `?itok` security
  token. `buildCombinedUrl()` mirrors core's URL generation (respects
  `image.settings:suppress_itok_output`). Dimensions are cached in the `image_dimensions` /
  `rift_image_dimensions` bins.
- `Routing\RouteSubscriber` (priority `-1024`): **only when the `combined_image_style` contrib module
  is NOT installed**, it rewrites the core `image.style_public` route path (`image_style` →
  `image_styles`) and points `_controller` at
  `Drupal\rift\Controller\ImageStyleDownloadController::deliverCombined`. That controller extends
  core's `ImageStyleDownloadController` and calls `deliver()` with a `CombinedImageStyle::fromName()`
  — so derivative delivery still runs core's access + `?itok` validation.

## `rift_ui` JSON endpoints

Controller `Drupal\rift_ui\Controller\RiftUiEndpointController` (`src/Controller/`):

| Route | Path | Method | Permission | Method → returns |
|---|---|---|---|---|
| `rift_ui.api.settings.get` | `/api/rift` | GET | `administer rift configuration` | `getSettings()` — `rift.settings` + `app_config` (plugin/extension option lists) as JSON. |
| `rift_ui.api.settings.post` | `/api/rift/update` | POST | `administer rift configuration` | `setSettings()` — `Json::decode($request->getContent())` → `RiftSettings::saveSettings()`, then returns `getSettings()`. |
| `rift_ui.media.endpoint.all` | `/media/{media}/rift` | GET | `access rift endpoint` | `getMedia(MediaInterface $media)` — renders every view mode's `<picture>` for the media as JSON `{view_modes: {key: {html}}}`. |
| `rift_ui.media` | `/media/{media}/rift-ui` | GET | `access rift endpoint` | `RiftUiMediaController::__invoke()` — empty `<div id="rift-ui">` + `rift_ui/admin` library. |
| `rift_ui.config` | `/admin/config/media/rift/rift-ui` | GET | `administer rift configuration` | `RiftUiConfigController::buildConfig()` — empty `<div id="rift-config">` + `rift_ui/config` library. |

The `{media}` routes take an `entity:media` parameter (upcast to a `MediaInterface`). The write
endpoint reads the raw request body and JSON-decodes it into `RiftSettings::saveSettings()`.

Permissions (`rift.permissions.yml`): `administer rift configuration` and `access rift endpoint` —
both `restrict access: true`.
