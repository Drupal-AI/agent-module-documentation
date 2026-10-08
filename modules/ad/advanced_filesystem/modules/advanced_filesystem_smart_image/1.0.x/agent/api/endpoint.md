<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The /adfs/image endpoint & processing pipeline

Route `advanced_filesystem_smart_image.derive` (`advanced_filesystem_smart_image.routing.yml`):
`path: /adfs/image`, `_controller: ImageDerivativeController::derive`, `_access: 'TRUE'`,
`options.no_cache: TRUE`. Anonymous by design (like a public image style). Requires PHP GD; without
it the controller returns HTTP 500.

## Request → response flow

1. `ImageDerivativeController::derive(Request)`
   (`src/Controller/ImageDerivativeController.php`):
   - 500 if `!extension_loaded('gd')`; 400 if `src` query param is empty.
   - `resolveParams()` merges the named `preset` (via `PresetManager::get()`) as a base, then
     overlays any of the known query params, then forwards `token`.
   - Calls `ImageProcessor::process($src, $params, $request)`. Exception → HTTP status:
     `\InvalidArgumentException` → **403**, `\RuntimeException` → **404**, any other `\Throwable`
     → **500** (logged).
   - Builds a `BinaryFileResponse` with `Content-Type`, `Content-Length`,
     `Cache-Control: public, max-age=31536000, immutable`, `ETag` (`"<hash>"`), `Last-Modified`,
     `X-Cache: HIT|MISS`, `Vary: Accept`. Honors `If-None-Match` / `If-Modified-Since` → **304**.

2. `ImageProcessor::process()` (`src/Service/ImageProcessor.php`):
   - `validateSrc()` — normalizes a bare path to `public://`, extracts the scheme, enforces the
     `allowed_schemes` whitelist (default `[public]`, → 403 otherwise), and rejects `..`, NUL and a
     stray `:` in the path.
   - If `signing.enabled`, `validateToken()` recomputes `generateToken()` and compares with
     `hash_equals()` (→ 403 on mismatch/missing).
   - `resolveAdaptive()` — `fmt=auto` → `avif`/`webp`/`jpg` from the `Accept` header (and GD
     capability); `q=auto` → per-format default (avif 60 / webp 75 / png 92 / else 82). `q` is then
     clamped 1–100.
   - Cache key `DerivativeCacheManager::hash($uri, $params)` = `sha256($uri.'|'.serialize($params))`
     (the `token` key is excluded). On hit, returns cached metadata with `cache_hit=TRUE`.
   - On miss: `realpath($uri)` + `is_readable` check (→ 404), `getimagesize()` to read type and
     enforce `security.max_input_pixels` (default 25,000,000; → 403 if exceeded), load via the
     matching `imagecreatefrom*`, run `orderedPlugins()` in ascending weight, then
     `saveGdImage()` to `public://adfs_derivatives/{aa}/{bb}/{hash}.{ext}`.

## Query parameters (all optional except `src`)

`src` (required, stream URI or bare public path), `preset`, `w`, `h`, `fit`
(`contain`|`cover`|`crop`|`fill`), `gravity`, `fp_x`, `fp_y`, `bg`, `pad`, `pad_x`, `pad_y`, `q`,
`fmt` (`jpg`|`png`|`webp`|`avif`|`auto`), `rotate`, `flip` (`horizontal`|`vertical`|`both`),
`grayscale`, `sepia`, `brightness` (-100..100), `contrast` (-100..100), `blur` (1–10), `sharpen`
(1–100), `wm` (watermark URI), `wm_pos`, `wm_opacity` (0–100), `wm_w`, `wm_pad`, `token`.

Full per-parameter semantics live in the transform docstrings; see
[../plugins/image_transform.md](../plugins/image_transform.md).

## Examples

```
GET /adfs/image?src=public://hero.jpg&w=1920&fmt=webp
GET /adfs/image?src=public://photo.jpg&w=300&h=300&fit=crop&fp_x=0.5&fp_y=0.3
GET /adfs/image?src=public://product.jpg&w=800&h=600&fit=fill&bg=ffffff
GET /adfs/image?src=public://photo.jpg&preset=thumbnail_small
```

The response is the derivative bytes; a repeat request with matching `If-None-Match` returns 304.
