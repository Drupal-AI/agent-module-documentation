<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bunny Optimizer toolkit, URL generation & config

Covers `BunnyOptimizerToolkit`, `BunnyOptimizerImageStyle`, config, and install/enable. Grounded in
`src/Plugin/ImageToolkit/BunnyOptimizerToolkit.php`, `src/Entity/BunnyOptimizerImageStyle.php`,
`bunny_optimizer.module`, `config/`.

## Install & enable

1. `drush en bunny_optimizer` (pulls core `file`, `image`, and contrib `file_mdm`).
2. Go to **Configuration > Media > Image toolkit** (route `system.image_toolkit_settings`, permission
   `administer site configuration`), pick **Bunny Optimizer toolkit**, and set **CDN hostname** if you
   want derivative URLs re-pointed at a dedicated Bunny pull-zone hostname. Save.
3. Requires an external Bunny CDN account with a pull zone serving your images — the module itself
   contacts nothing.

The toolkit becomes the site default; from then on the two `hook_*_alter()` in
`bunny_optimizer.module` take effect (see below).

## Toolkit plugin — `BunnyOptimizerToolkit` (id `bunny_optimizer`)

Extends core `ImageToolkitBase`. It does **not** touch image bytes:

- `isValid()` → TRUE, `save($destination)` → TRUE (no file written), `parseFile()` → FALSE.
- `getWidth()/getHeight()/getMimeType()` lazily call `loadInfo()` → `getImageInfo()`, which asks the
  **File MDM** manager (`FileMetadataManagerInterface`) for the source's `getimagesize` metadata.
- Parameter store: `$params` array with `setParameter($k,$v)` (chainable), `getParameter($k)`,
  `unsetParameter($k)`, `mergeParameters($arr)`, `getParameters()`. Effects/operations write here;
  URL generation reads it.
- `getCdnHostname()` reads `bunny_optimizer.settings:cdn_hostname`.
- `getSupportedInputExtensions()`: jpg, jpeg, webp, gif, png, tga, bmp, pbm, tiff, heic, heif.
  `getSupportedOutputExtensions()`: jpg, jpeg, webp, png, gif. `isAvailable()` → TRUE.
- `buildConfigurationForm()` renders the info message and the single `cdn_hostname` textfield;
  `submitConfigurationForm()` writes `bunny_optimizer.settings`. Both **respect config overrides**:
  a key whose active value differs from its original (e.g. set in `settings.php`) is shown disabled
  and skipped on save.

## URL generation — `BunnyOptimizerImageStyle`

Installed as the `image_style` entity class **only when `bunny_optimizer` is the default toolkit**
(`bunny_optimizer_entity_type_alter()`); otherwise core `ImageStyle` is used unchanged. Also,
`bunny_optimizer_image_effect_info_alter()` swaps core's `image_convert` and `image_scale_and_crop`
effect classes for this module's versions while the toolkit is default.

- `buildUri($uri)` → returns the original `$uri` (no derivative path). If the image's toolkit is not
  Bunny's, delegates to `parent::buildUri()`.
- `buildUrl($uri, $clean_urls = NULL)`:
  1. Loads the image, confirms its toolkit is `BunnyOptimizerToolkitInterface` (else
     `parent::buildUrl()`).
  2. Runs `applyEffect()` for **every** effect on the style → fills the toolkit `$params`.
  3. Generates the absolute source URL (`file_url_generator`), `parse_url()`s it, merges any
     existing query with `$toolkit->getParameters()`.
  4. If `cdn_hostname` is set, replaces the host with it.
  5. Returns `scheme . host . path . '?' . http_build_query($queryParams)` — parameters are
     URL-encoded by `http_build_query()`.
- `flush()` is intentionally empty (there is no derivative to delete; the "derivative" is just the
  original + query params). `supportsUri()` allows only extensions in
  `getSupportedInputExtensions()`.

## Configuration object

`bunny_optimizer.settings` (config_object):

| key | type | default | meaning |
|-----|------|---------|---------|
| `cdn_hostname` | string | `''` | Bunny CDN pull-zone hostname to serve images from. Leave empty when the site hostname itself is fronted by Bunny CDN (full-page caching). |

Schema: `config/schema/bunny_optimizer.schema.yml`. Install default: `config/install/bunny_optimizer.settings.yml`.

Config-export snippet:

```yaml
# bunny_optimizer.settings.yml
cdn_hostname: 'cdn.example.com'
```

## Notes

- No local derivative files are ever written, so origin CPU/disk for image processing drops to zero;
  actual resizing/optimization happens on Bunny's edge from the query string.
- The module declares one service, `logger.channel.bunny_optimizer`, but the shipped code does not
  log anything through it.
- Nothing here adds access control: a derivative URL is just the public source URL plus query
  parameters, as public as the source file.
