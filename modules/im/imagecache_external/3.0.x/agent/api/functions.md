<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: functions, theme hooks, Twig filter

The module's API is **procedural functions** in `imagecache_external.module` plus a Twig filter.

## Core functions

### `imagecache_external_generate_path(?string $url): bool|string`
The main entry point. Given an external image URL, returns a **local URI** to the cached copy
(e.g. `public://externals/<md5>.jpg`), fetching it if needed; returns `FALSE` on empty/failed.
Flow:
1. Empty URL → FALSE.
2. Computes `md5($url)` as the filename; builds the target dir from `imagecache_directory`
   (+ 2 hashed subdirs if `imagecache_subdirectories`).
3. Fires `hook_imagecache_external_destination_alter()` (scheme/directory).
4. If the URL is already on the site's default scheme, returns it as-is; other local schemes are
   `realpath`-resolved.
5. Adds the real extension (jpg/png/gif/jpeg/webp/svg) or `imagecache_default_extension`.
6. Fires `hook_imagecache_external_needs_refresh_alter()`; if no refresh needed and file exists,
   returns the path; otherwise calls `imagecache_external_fetch()`.

### `imagecache_external_fetch(string $url, string $cache_path): bool|string`
Downloads `$url` via `\Drupal::httpClient()`, checks the host whitelist, verifies the
`content-type` is in `imagecache_external_allowed_mimetypes`, sanitizes SVGs, then writes the file
(unmanaged `saveData` or managed `File`). On failure returns the fallback image URI (if
`imagecache_fallback_image` is set) or FALSE, logging the exception.

### `imagecache_external_validate_host(string $url): bool`
TRUE if the whitelist is off, or the URL's host matches `imagecache_external_hosts`.

### Other helpers
- `imagecache_sanitize_svg(&$content, $content_type)` — sanitizes SVG bytes using
  `enshrined/svg-sanitize` with `svg_settings` allowed tags/attributes.
- `imagecache_external_flush_cache()` / `imagecache_external_get_directory_path()` — flush plumbing.
- `imagecache_external_allowed_mimetypes()` / `imagecache_external_config()` — accessors.

## Theme hooks

- `imagecache_external` — vars `style_name`, `uri`, `alt`, `title`, `width`, `height`,
  `attributes`. Preprocess resolves `uri` via `generate_path` then reuses core
  `template_preprocess_image_style`.
- `imagecache_external_responsive` — vars `responsive_image_style_id`, `uri`, … Same idea with
  `template_preprocess_responsive_image`.

Render-array usage:

```php
$build['img'] = [
  '#theme' => 'imagecache_external',
  '#uri' => 'https://example.com/photo.jpg',
  '#style_name' => 'thumbnail',
  '#alt' => 'Photo',
];
```

## Twig filter `imagecache_external`

Provided by `Drupal\imagecache_external\TwigExtension` (service
`imagecache_external.twig_extension`). Signature `imagecache_external(path, style)`:

```twig
{{ 'https://my.site/my-image.jpg'|imagecache_external('thumbnail') }}
```

Returns the **relative URL** of the styled derivative (fetching/creating it on request), or nothing
(with a `trigger_error`) if the style can't be loaded or applied. Uses `generate_path()` then the
image style's `buildUrl()` + `FileUrlGenerator::transformRelative()`.

## Private file system

`imagecache_external_file_download()` grants access to cached externals under the private scheme
(only for the module's directory and allowed MIME types), overriding the Image module's handler.
