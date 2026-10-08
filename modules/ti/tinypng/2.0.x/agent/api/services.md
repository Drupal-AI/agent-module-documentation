<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & how compression is wired

Two services do the work (`tinypng.services.yml`):

| Service id | Class | Role |
|---|---|---|
| `tinypng.compress` | `Drupal\tinypng\TinyPng` | thin wrapper over the `tinify/tinify` API client (set key, compress a file) |
| `tinypng.image_handler` | `Drupal\tinypng\TinyPngImageHandler` | decides what to compress on entity presave; used by hooks |
| `tinypng.route_subscriber` | `Drupal\tinypng\Routing\RouteSubscriber` | overrides the image-style derivative download route |

`TinyPng` is constructed with `@config.factory`, `@file_system`, `@file_url_generator`;
`TinyPngImageHandler` with `@tinypng.compress`, `@config.factory`, `@image.factory`,
`@logger.factory`.

## Wiring

- **`hook_entity_presave()`** (`tinypng.module`) → `tinypng.image_handler->hookEntityPresave($entity)`.
  When `on_upload` is set, uploaded image files are compressed as they are saved.
- **`tinypng_form_image_style_edit_form_alter()`** adds the "Compress with TinyPNG" checkbox
  to image-style edit forms (only if `image_action` on and `api_key` set) and, via an
  `#entity_builders` callback, saves the `tinypng.tinypng_compress` third-party setting on the
  `ImageStyle`.
- **`RouteSubscriber`** swaps the image-style download controller for
  `TinyPngImageStyleDownloadController`, so a flagged style's derivatives are routed through
  TinyPNG when generated/served.

## Programmatic use

```php
/** @var \Drupal\tinypng\TinyPngInterface $tiny */
$tiny = \Drupal::service('tinypng.compress');
// Uses api_key from tinypng.settings; requires the tinify/tinify library and network access.
```

Interfaces: `TinyPngInterface` (compression wrapper), `TinyPngImageHandlerInterface`
(presave handling). There are **no Drush commands** and **no plugin types** — all behavior is
config + hooks + the two services above. Nothing is compressed without a valid `api_key` and
outbound access to the TinyPNG API.
