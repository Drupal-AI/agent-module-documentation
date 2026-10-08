<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig filter, resizer library, and template

## `image_url` Twig filter

Provided by `easy_responsive_images.image_url` (class `TwigExtension\ImageUrl`). Turns a file
URI (or external URL) + an image style name into a URL to that derivative:

```twig
{# smallest / base src #}
{% set src = file.uri.value|image_url('responsive_16_9_50w') %}

{# a full srcset built by hand #}
{% set srcset = [
  file.uri.value|image_url('responsive_16_9_150w') ~ ' 150w',
  file.uri.value|image_url('responsive_16_9_550w') ~ ' 550w',
  file.uri.value|image_url('responsive_16_9_1250w') ~ ' 1250w',
] %}
```

Signature: `image_url(?string $uri, ?string $style)` → derivative URL (empty string if the URI or
style is missing). It returns a WebP URL when `imageapi_optimize_webp`/`webp` is installed, an
Avif URL when `avif` is installed, and resolves external images through `imagecache_external`
when that module is present.

## Resizer library

Attach `easy_responsive_images/resizer` (depends on `core/drupal`, `core/drupalSettings`). Its
`js/resizer.js` reads each image's available container width and swaps `src` to the best entry
from `data-srcset`. The field formatter attaches it automatically; in a hand-built template add:

```twig
{{ attach_library('easy_responsive_images/resizer') }}
<img
  src="{{ src }}"
  data-srcset="{{ srcset|join(',')|raw }}"
  alt="{{ media.field_media_image.alt }}"
  loading="lazy"
  width="50" height="50" />
```

(Temporary width/height are updated by the resizer JS; `loading="lazy"` enables native lazy
loading, tuned by the `lazy_loading_threshold` setting.)

## Formatter template

`templates/easy-responsive-images-formatter.html.twig` (theme hook
`easy_responsive_images_formatter`) renders the formatter output: it attaches the resizer
library, builds `data-srcset` from the `srcset` variable, and prints
`<img src item_attributes>`. Override it per view mode (e.g.
`easy-responsive-images-formatter--16-9.html.twig`) to customise markup.
