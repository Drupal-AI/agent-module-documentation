<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: Smart Image (advanced_filesystem_smart_image) — agent index

Submodule of **Advanced FileSystem** that serves on-demand image derivatives from one endpoint,
`/adfs/image`, using a GD-backed `ImageTransform` plugin pipeline with HTTP caching, presets,
optional HMAC-signed URLs, Twig helpers and Drush tooling. Package `Advanced File System`.
Dependencies: core **`file`** + **`advanced_filesystem`**. Core `^10 || ^11 || ^12`, PHP >= 8.1,
**requires the PHP GD extension** at runtime. License GPL-2.0-or-later. Version 1.0.27.

## Solution docs

- **The `/adfs/image` endpoint, all query params, and the processing pipeline** →
  [api/endpoint.md](api/endpoint.md)
- **Settings, config object/schema, presets, signing, cache, permission & routes** →
  [config/settings.md](config/settings.md)
- **The ImageTransform plugin type + the 5 built-in transforms** →
  [plugins/image_transform.md](plugins/image_transform.md)
- **Twig filters/functions and the Drush commands** →
  [api/twig-and-drush.md](api/twig-and-drush.md)

## What it actually is (from source)

- **Route** `advanced_filesystem_smart_image.derive` → `/adfs/image`, `_access: 'TRUE'`
  (anonymous), `options.no_cache: TRUE`. Handler
  `ImageDerivativeController::derive()` (`src/Controller/ImageDerivativeController.php`).
- **Two admin routes** at `/admin/config/media/advanced_filesystem/smart-image[/warmup]`,
  both gated by permission **`administer advanced_filesystem_smart_image`** (`restrict access: true`).
- **Core service** `advanced_filesystem_smart_image.processor` = `Service\ImageProcessor::process()`:
  validate source URI → optional HMAC token check → resolve adaptive fmt/quality → cache lookup →
  load via GD → run ordered transforms → save derivative → return metadata.
- **Cache** `Service\DerivativeCacheManager` writes `public://adfs_derivatives/{aa}/{bb}/{sha256}.{ext}`
  keyed by `sha256(uri | serialize(params))`; `Service\PresetManager` reads named presets from config.
- **Plugin type** `ImageTransform` (annotation `Annotation\ImageTransform`, manager
  `ImageTransformPluginManager`, base `Plugin\ImageTransform\ImageTransformBase`). Built-ins:
  `resize_crop` (w10), `pad` (w15), `rotate_flip` (w20), `filter` (w30), `watermark` (w40) — run in
  ascending weight order.
- **Twig** `TwigExtension\AdfsImageTwigExtension`: filters `adfs_image`, `adfs_srcset`,
  `adfs_blurhash`, `adfs_lqip` + function `adfs_image()`.
- **Drush** `Commands\SmartImageCommands`: `adfs:image:derive|prebuild|warmup|purge|stats|token`.
- **Hook** `hook_cron()` prunes derivatives older than `cache.max_age_days` (default 30). Config
  object **`advanced_filesystem_smart_image.settings`** (schema in `config/schema/`, defaults in
  `config/install/`).

## Key facts

- Source `src` may be a stream-wrapper URI (`public://…`) or a bare path (normalized to
  `public://`). Only schemes in `allowed_schemes` (default `[public]`) are accepted; `..`, NUL and
  extra `:` are rejected. GD reads a real local path — the endpoint does **not** fetch remote HTTP
  URLs as sources.
- Output format via `fmt` (`jpg|png|webp|avif|auto`); `auto` picks AVIF/WebP/JPEG from the request
  `Accept` header. Quality `q` 1–100 or `auto` (per-format default). Response carries `ETag`,
  `Last-Modified`, `Cache-Control: immutable` and supports `304`.
- URL signing is **off by default** (`signing.enabled: false`); when enabled, a valid `token`
  (HMAC-SHA256, verified with `hash_equals`) is required.
