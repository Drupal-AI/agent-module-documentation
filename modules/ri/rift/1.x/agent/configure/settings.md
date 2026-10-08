# Configure RIFT — settings, view modes, starter kit, UI

All RIFT behaviour is driven by one config object: **`rift.settings`** (schema in
`config/schema/rift.schema.yml`, defaults in `config/install/rift.settings.yml`). Settings route:
`rift.settings` → `/admin/config/media/rift` (permission `administer rift configuration`).

## `rift.settings` structure

```yaml
media_source: multiple_image          # RiftMediaSource plugin id (input processor)
source: combined_image_style          # RiftSource plugin id (output/URL processor)
aspect_ratios: ['7x3', '3x2', '1x1']  # aspect ratios crop/image styles are generated for
config:                               # the GLOBAL default block (merged under every view mode)
  screens:                            # breakpoints keyed by short name
    sm: { width: 768, media: '(max-width: 768px)' }
    lg: { width: 960, media: '(max-width: 960px)' }
  transforms: ''                      # optional per-size extra image-style chain
  multipliers: ['1x', '2x']           # pixel densities → each becomes a srcset candidate
  quality: { '1x': 80, '2x': 70 }     # image-style-quality value per multiplier
  formats: ['webp', 'jpeg']           # <source type=image/…> formats, in preference order
  attributes: { loading: lazy, preload: '' }   # extra attributes on the <img>/<picture>
  fallback_transform: rift_fallback   # image style(s) for the <img> fallback (split on '-')
view_modes:                           # named RIFT view modes (each also a rift_picture_view_modes plugin)
  hero:
    label: 'Hero (7x3)'
    sizes: 'xs:468 sm:100vw md:100vw lg:100vw'   # space-separated "screen:viewwidth" tokens
    aspect_ratios: '7x3 7x3 7x3 7x3'             # one per size (space-separated)
    attributes: { loading: eager }
```

Key semantics (see `RiftPicture::responsivePicture()` and `DTO/PictureConfig.php`):

- **`sizes`** is a space-separated list of `screen:viewwidth` tokens, e.g. `sm:100vw`, `lg:400px`,
  `xl:256`. `100vw` means "screen width × 100%"; a bare number / `px` is a fixed width. The `screen`
  key must exist in `config.screens`.
- **`aspect_ratios`** is a space-separated list aligned index-for-index with `sizes`. A value like
  `16x9`. Empty falls back to `100x1`. Used both to pick a manual crop (`crop.type.<ar>`) and to
  compute height.
- At render time the effective config = `config` (global) `array_merge`'d with the view-mode
  definition, so `screens`, `multipliers`, `quality`, `formats` normally come from the global block
  and `sizes`/`aspect_ratios`/`attributes` from the view mode.
- Missing pieces short-circuit to an HTML comment: `<!-- Missing Image -->`, `<!-- Missing Formats -->`,
  `<!-- Missing screens -->`.

## Config-generation from templates (important side effect)

RIFT does **not** ship the image styles / crop types it needs — it generates them from YAML
templates in `assets/templates/` by string-substituting `%placeholder%` tokens then `Yaml::parse`,
via `RiftSettings::generateConfig()` (and an identical copy in `RiftStarterKit`). Generated config:

- `crop.type.<aspect_ratio>` (from `crop.type.aspect_ratio.yml`) and `image.style.<aspect_ratio>`
  (from `image.style.crop_crop.yml`) — for each entry in `aspect_ratios`.
- `image.style.<quality>` (from `image.style.image_style_quality.yml`) — for each quality value.
- `image.style.<extension>` (from `image.style.image_convert.yml`) — for each toolkit-supported
  format only (`generateExtensionConfigurations()` filters against `getSupportedExtensions()`).
- Fixed helpers: `image.style.nop`, `crop.type.focal_point`, and (starter kit) `image.style.rift_fallback`.

`generateConfig()` only writes when the config is new unless `$replace_existing_config = TRUE`. The
combined `source` plugin then chains these styles by machine name at URL-build time.

## Settings form — `RiftSettingsForm` (`src/Form/RiftSettingsForm.php`)

`ConfigFormBase` on `rift.settings`. Two `select`s (`media_source`, `source`, options from the two
plugin managers) plus two YAML `textarea`s (`config`, `view_modes`) with `data-yaml-editor`
attributes (pairs with the optional `ace_editor` module). It shows a warning nudging you toward RIFT
UI. `submitForm()` `Yaml::parse`s each textarea straight into config.

## Starter kit — `rift_starter_kit` (deprecated)

Route `rift_starter_kit.wizard` → `/admin/config/media/rift/rift-starter-kit`
(`administer rift configuration`). Form fields: `aspect_ratios` (textarea, validated `NxN`),
`extensions` (checkboxes of toolkit extensions), `quality` (textarea, numeric), and a
`generate_rift_settings` checkbox that **overwrites** `rift.settings` from the bundled
`rift.settings.yml` template. Submitting generates the crop-type/image-style config described above.
`info.yml` marks it `lifecycle: deprecated` — RIFT UI replaces it.

## RIFT UI app — `rift_ui`

Route `rift_ui.config` → `/admin/config/media/rift/rift-ui` renders an empty
`<div id="rift-config">` and attaches the `rift_ui/config` library (a compiled Svelte SPA under
`assets/config/`). The SPA reads/writes config over the JSON endpoints documented in
[api/services.md](../api/services.md#rift_ui-json-endpoints). RIFT UI is the recommended editor; it
adds client-side validation/auto-healing the raw YAML form does not.

## Update hooks

- `rift_update_9101` — migrates the removed `config.url_generation_strategy` string into the new
  `source` + `media_source` plugin ids.
- `rift_update_9102` — populates top-level `aspect_ratios[]` from the aspect ratios found across
  `view_modes`.
