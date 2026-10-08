<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service, Twig filter, DB table & file hooks

## Service `easy_lqp.manager`

`EasyLqpImagesManager` (`src/EasyLqpImagesManager.php`, interface
`EasyLqpImagesManagerInterface`). Constructor args (`easy_lqp.services.yml`):
`@entity_type.manager`, `@module_handler`, `@file_url_generator`, `@image.factory`,
`@file.validator`, `@database`. Constants: `EASY_LQP_WIDTH = 30`, `EASY_LQP_HEIGHT = 30`,
`EASY_LQP_ASPECT_RATIO_MULTIPLE = 5`, `EASY_LQP_TABLE_NAME = "easy_lqp"`.

Public API:

- `getAspectRatios(): array` — introspects existing `responsive_*` styles (via
  `initialImagesConfiguration()`), returns `['16_9' => '16:9', …]` (the `scale` group removed).
- `getImagesByScale(string $uri): array` — for the `scale` group, returns entries
  `{url, width, srcset_url}` sorted ascending by width; `url` is run through
  `getWebpDerivatives()`.
- `getImagesByAspectRatio(string $uri, string $aspect_ratio): array` — same but with a computed
  `height` per style, for the requested ratio group.
- `getLqp(FileInterface $file, string $derivative_url): ?string` — returns the cached base64 for
  `(fid, image_style-type)`; if absent, delegates to `generateLqp()`.
- `generateLqp(FileInterface $file, string $derivative_url): ?string` — resolves the LQP style name
  from the derivative URL (`getImageStyleName()` + `getLqpImageStyleDetails()`), builds the
  derivative with `$style->createDerivative()`, then
  `'data:' . mime_content_type($uri) . ';base64,' . base64_encode(file_get_contents($uri))`, inserts
  a row into `easy_lqp`, and returns the data URI.
- `validateImage(FileInterface $file): bool` — FALSE unless the file is **permanent** and passes the
  core `FileExtension` validator against `image.factory` supported extensions.

`getLqpImageStyleDetails()` maps a derivative style name to its LQP style: a 4-part name
(`responsive_16_9_500w`) → `responsive_<w*5>_<h*5>_lqp` (type `"ratio w:h"`); a 2-part name → the
`responsive_30w_lqp` (type `scale w`) or `responsive_30h_lqp` (type `scale h`) source.
`getWebpDerivatives()` rewrites the extension to `.<ext>.webp` only when `imageapi_optimize_webp`
or `webp` is installed and the URI is local with an extension.

## Twig filter `image_url`

Twig extension service `easy_lqp.image_url` → `ImageUrl` (`src/TwigExtension/ImageUrl.php`,
extension name `easy_lqp.image_url`). Registers filter **`image_url`** →
`ImageUrl::createImageUrl(?string $uri, ?string $style)`:

- Loads the image style (`ImageStyle::load($style)`); returns `''` if `$uri` or the style is
  missing.
- If `imagecache_external` is enabled and the URI has no stream wrapper, resolves it via
  `imagecache_external_generate_path($uri)` (external image support).
- Returns `file_url_generator->transformRelative($image_style->buildUrl($uri))`, rewriting to
  `.webp` when `imageapi_optimize_webp` / `webp` is installed.

The filter is **not** marked `is_safe`, so its output is auto-escaped like any string in a template.
Usage in a media view-mode template (e.g. `media--image--16-9.html.twig`):

```twig
{{ attach_library('easy_lqp/resizer') }}
{% set file = media.field_media_image.entity %}
{% set src = file.uri.value|image_url('responsive_16_9_50w') %}
{% set srcset = [
  file.uri.value|image_url('responsive_16_9_150w') ~ ' 150w',
  file.uri.value|image_url('responsive_16_9_1450w') ~ ' 1450w',
] %}
<picture class="easy-lqp-picture">
  <img src="{{ src }}" data-srcset="{{ srcset|join(',') }}"
       alt="{{ media.field_media_image.alt }}" loading="lazy" width="50" height="50" />
</picture>
```

## Database table `easy_lqp`

Defined in `easy_lqp.install` (`hook_schema()`), created by `hook_install()`:

| Field | Type | Notes |
|---|---|---|
| `id` | serial | Primary key. |
| `fid` | int | Drupal file ID (indexed; also `(fid, image_style)` index). |
| `lqp` | text (mediumtext) | The base64 `data:` URI. |
| `image_style` | varchar(128) | The LQP "type" label (`ratio w:h`, `scale w`, `scale h`). |

## File hooks (`easy_lqp.module`)

- `hook_theme()` — registers `easy_lqp_formatter`.
- `hook_help()` — project-page help on route `easy_lqp.image`.
- `easy_lqp_file_insert()` — if `generate_lqp_upload` is on, calls `easy_lqp_generate_derivatives()`
  to pre-build LQPs for the `responsive_30h`, `responsive_30w` and per-ratio
  `responsive_<w>_<h>_30w` styles.
- `easy_lqp_file_update()` — deletes cached rows for the file, then regenerates if
  `generate_lqp_upload` is on.
- `easy_lqp_file_delete()` — deletes the file's rows from `easy_lqp` (only when MIME type contains
  `image`).

## Programmatic use

```php
$manager = \Drupal::service('easy_lqp.manager');
$srcset = $manager->getImagesByScale($file->getFileUri());
$data_uri = $manager->getLqp($file, $srcset[0]['url']);
```
