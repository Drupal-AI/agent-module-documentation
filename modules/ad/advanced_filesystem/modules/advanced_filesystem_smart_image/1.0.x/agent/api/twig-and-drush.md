<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig helpers & Drush commands

## Twig extension (`TwigExtension\AdfsImageTwigExtension`)

Service `advanced_filesystem_smart_image.twig_extension` (tagged `twig.extension`), injected with
`PresetManager` + `file_url_generator`. Filters and one function:

- `|adfs_image` (also `adfs_image()` function) — `buildUrl($uri, $params = [])`. Normalizes the URI
  (string, field item `->value`, `__toString`, or array `['value']`), merges a named `preset` then
  overlays `$params`, and returns a root-relative `/adfs/image?src=…&…` URL (RFC3986 query).
  Example: `<img src="{{ file.uri.value|adfs_image({w:800, fmt:'webp', fit:'cover'}) }}">`.
- `|adfs_srcset` — `buildSrcset($uri, $widths = [400,800,1200], $params = [])`. Emits a
  `"<url> 400w, <url> 800w, …"` string, one derivative URL per width.
- `|adfs_blurhash` — `buildBlurhash($uri, $cx = 4, $cy = 3)`. Pure-PHP/GD BlurHash encoder; returns
  a short base83 string for a placeholder (reads the file, downscales to 64px, DCT encode).
- `|adfs_lqip` — `buildLqip($uri, $width = 20, $quality = 20)`. Returns a tiny
  `data:image/jpeg;base64,…` low-quality placeholder.

Note: `buildBlurhash`/`buildLqip` read bytes via a private `readFileContents()` helper (stream URI →
`realpath` + `file_get_contents`; `http(s)://` → `file_get_contents`; else absolute path). These are
template-author-driven build helpers, not request-parameter endpoints.

## Drush commands (`Commands\SmartImageCommands`, `drush.services.yml`)

- `adfs:image:derive <src> [--preset --w --h --fit --fmt --q --rotate --flip --grayscale --blur
  --sharpen]` (alias `adfs-derive`) — pre-generate a single derivative via `ImageProcessor::process()`.
- `adfs:image:prebuild --preset=<id> [--limit=50 --mime=image/]` (`adfs-prebuild`) — apply a preset to
  managed files from `file_managed` (status 1, MIME prefix filter). `--preset` required.
- `adfs:image:warmup [--widths=400,800,1200 --fmt=webp --fit=cover --limit=0 --mime=…]`
  (`adfs-img-warmup`) — bulk pre-generate width variants (± a preset) for managed image files.
- `adfs:image:purge [--age=N --src=<uri|glob>]` (`adfs-img-purge`) — `--src` glob →
  `purgeBySourcePattern()` (queries `file_managed`), exact `--src` → `purgeBySourceUri()`, `--age>0`
  → `pruneByAge()`, else confirm + `purgeAll()`.
- `adfs:image:stats` (`adfs-img-stats`) — table of directory, cached file count, total size, preset
  count.
- `adfs:image:token <src> [--w --h --fit --fmt --q --preset]` (`adfs-img-token`) — mints an
  HMAC-signed URL token via `generateToken()`; errors if `signing.secret` is empty.

## Cache manager purge/prune (`Service\DerivativeCacheManager`)

`purgeAll()`, `purgeBySourceUri($uri)`, `purgeBySourcePattern($glob)` (glob → SQL LIKE over
`file_managed.uri`), `pruneByAge($seconds)`, `stats()`. Derivatives live at
`<cache.directory>/{aa}/{bb}/{sha256}.{ext}`.
