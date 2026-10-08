<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Brandfolder — image toolkit & CDN stream wrapper

Brandfolder images are **not** downloaded/processed locally. Instead the module records the image-style
operations and translates them into Brandfolder Smart CDN URL parameters, so the CDN renders the derivative.

## Stream wrapper `bf://`
`src/StreamWrapper/BrandfolderStreamWrapper.php` (service `stream_wrapper.brandfolder`, scheme `bf`, base
`https://cdn.bfldr.com`). File URIs look like `bf://…` and encode the attachment/CDN identifiers.
- `getExternalUrl()` builds the public CDN URL. When an image style is in play it appends transformation query
  params (width/height/crop, plus `format`/`auto`, WebP, and `quality` per the `io_*` settings) and a
  `drupal-image-style` marker. Config `io_format_auto` / `io_format_auto_force` / `io_auto_webp` / `io_quality`
  govern format & compression.
- `brandfolder_parse_uri()` / `brandfolder_parse_cdn_url()` (`brandfolder.module`) parse these URIs/URLs.
- **Alter hook:** `hook_brandfolder_file_url_alter(&$url, &$url_options, $context)` (`brandfolder.api.php`) lets
  other modules tweak the generated URL / query options (e.g. per-style quality) before `Url::fromUri()`.

## Image toolkit `brandfolder`
`src/Plugin/ImageToolkit/BrandfolderToolkit.php` (`@ImageToolkit id = "brandfolder"`). It overrides the core GD
toolkit for `bf://` files: `parseFile()` reads width/height/mime/attachment ID from the `brandfolder_file` table
(no pixel work), `getWidth()/getHeight()` return stored dimensions, and `recordOperation()` /
`getOperationsRecord()` accumulate the requested operations. `setCdnUrlParams()/getCdnUrlParams()` hold the params
the stream wrapper will emit. `save()` is effectively a no-op (nothing is written locally).

The `image.factory` service is overridden by `BrandfolderImageFactory` (`src/Image/BrandfolderImageFactory.php`)
so Brandfolder URIs get this toolkit.

## Toolkit operations (`src/Plugin/ImageToolkit/Operation/brandfolder/`)
All extend `BrandfolderImageToolkitOperationBase` and, instead of manipulating bytes, record CDN parameters:
- `brandfolder_scale_and_crop` (`scale_and_crop`)
- `brandfolder_scale` (`scale`)
- `brandfolder_crop` (`crop`)
- `brandfolder_resize` (`resize`)
- `brandfolder_convert` (`convert`)

Net effect: standard Drupal image styles "just work" on Brandfolder media, served straight from the CDN with no
local derivative files.

## MIME-type guessing
`src/File/MimeType/BrandfolderMimeTypeHandler` (service `file.mime_type.guesser.brandfolder`, priority 100, with
proxy class `src/ProxyClass/File/MimeType/BrandfolderMimeTypeGuesser.php`) resolves MIME types for `bf://` files
using the module's stored data rather than a local file read.
