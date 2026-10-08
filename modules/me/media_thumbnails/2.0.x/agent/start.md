<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Thumbnails — agent index

A **plugin manager only** — it generates nothing by itself. Enable (or write) at least one
`@MediaThumbnail` plugin, keyed by MIME type, and the module wires it into media
create/update/delete.

- **Global settings (`media_thumbnails.settings`), admin routes, permission** →
  [configure/settings.md](configure/settings.md)
- **Write a `media_thumbnail` plugin; the manager API and the presave/delete flow** →
  [plugins/media-thumbnail.md](plugins/media-thumbnail.md)
- **`drush thumbnails:refresh` and the batch** → [drush/refresh.md](drush/refresh.md)

Key facts:
- Plugin type id: **`media_thumbnail`** — annotation `@MediaThumbnail` (`id`, `label`,
  `mime[]`), directory `Plugin/MediaThumbnail`, interface
  `Drupal\media_thumbnails\Plugin\MediaThumbnailInterface`, base
  `MediaThumbnailBase`, manager service `plugin.manager.media_thumbnail`,
  alter hook `hook_media_thumbnails_media_thumbnail_info_alter()`.
- Only method to implement: `createThumbnail($sourceUri)` → managed `\Drupal\file\Entity\File`.
- Config object `media_thumbnails.settings`: `width` (500), `bgcolor_active` (false),
  `bgcolor_value` ('#eeeeee'), `no_thumbnail_update` (false), `allow_thumbnail_edit` (false).
- Config UI `/admin/config/media/thumbnails` (route `media_thumbnails.admin`, the `configure`
  route) + `/admin/config/media/thumbnails/refresh`; permission
  `manage media thumbnails settings`.
- No plugins are bundled in this release — `media_thumbnails_pdf` and friends are separate
  projects.
