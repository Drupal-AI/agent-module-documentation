<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Download — agent index

Makes a media entity's canonical URL `/media/{id}` serve its **source file directly** (inline,
or `?dl=1` to force a download) instead of rendering the entity page. No settings, no config
schema, no permissions, no Drush, no plugins. Depends on core `file` + `media`.

- **How the download works: route override, `?dl=1`, forced standalone URL, caching, headers** →
  [api/downloads.md](api/downloads.md)

Key facts:
- `RouteSubscriber` removes core `entity.media.canonical` and re-adds `/media/{media}` →
  `Drupal\media_download\DownloadController::save`, requirement `_entity_access: media.view`.
- `DownloadController::save()` returns a `CacheableBinaryFileResponse`; disposition is
  `inline` by default, `attachment` when the request has `?dl=1`.
- `MediaSettingsOverride` (a `config.factory.override`) forces `media.settings:standalone_url`
  to `TRUE` at runtime — the stored value is ignored while this module is enabled.
- `PageCacheResponsePolicy` denies page-caching of `BinaryFileResponse`/`StreamedResponse`.
- Responses carry `Content-Security-Policy: sandbox`; `Content-Type` comes from the file entity;
  `ETag`/`Last-Modified` are set automatically.
