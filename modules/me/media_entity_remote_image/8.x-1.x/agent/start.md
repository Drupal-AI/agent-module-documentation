<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Remote Image (media_entity_remote_image) — agent index

Provides a **Media source** (`remote_image`) plus a bundled **Remote image** media type for images
that live on another host: the media entity stores a URL, not a file, yet participates fully in the
media system (library, entity reference, fields, WYSIWYG, media access). The stored value is a
Link-derived field (`remote_image_url`) holding a URL plus alt text; a matching widget
(`remote_image_url_widget`) and formatter (`remote_image_url_formatter`, label "Image") render it as
a standard `<img>`. Supports external URLs and, when the field's link type allows, internal paths
(stored as `internal:/…` and resolved against the site's base URL). Because the bytes stay remote,
Drupal image styles do not apply to the displayed image.

The module fetches the URL server-side in three places, all through the
`media.remote_image.resource_fetcher` service (Guzzle GET, 15s timeout): a source-field validation
constraint (`RemoteImageUrl`) confirms the URL returns image content when media is saved, the media
source's metadata/thumbnail flow fetches on save, and the Media Library "add via URL" form validates
before creating media. Optionally (setting `generate_thumbnails`, **off by default**) it also
downloads the image on save and stores a local thumbnail preview via an image style. The remote host
must be reachable from the Drupal server for validation and thumbnails to succeed; a broken remote
URL is a broken image with no local fallback.

- **Depends on:** core `link`, `media (>= 8.4)`. Package: **Media**. No composer.json (no external
  libraries).
- **Core:** `^8 || ^9 || ^10 || ^11`. Version **8.x-1.2-beta2** (beta).
- **Settings page:** yes — `media_entity_remote_image.settings` at
  `/admin/config/media/media-entity-remote-image-settings` (`administer site configuration`).
- **Permissions:** none of its own (creating remote_image media uses core media permissions).
  **Drush:** none. **Plugin types defined:** none (it provides plugin *instances*).
- **Config schema:** yes (settings + source + formatter). One service. One library (`admin`, CSS).

## What you'd do → where

- **Understand the `remote_image` media source, the fetcher service, the validation constraint, and
  Media Library integration** → [plugins/media-source.md](plugins/media-source.md)
- **Configure the `remote_image_url` field, its widget (URL + alt), or the "Image" formatter (max
  width/height, lazy loading, image link)** → [fields/field-widget-formatter.md](fields/field-widget-formatter.md)
- **Turn on local thumbnail previews / pick the thumbnail image style / find the config keys** →
  [configure/settings.md](configure/settings.md)

## Key facts (real machine names)

- Media source: `remote_image` (`Plugin/media/Source/RemoteImage`); default media type `remote_image`,
  source field `field_media_remote_image_url`; metadata attrs `title`, `url`, `alt`, `thumbnail_uri`,
  `default_name`; `default_thumbnail_filename = remote-image.png`.
- Field type: `remote_image_url` (extends LinkItem; adds `alt`, drops `title`/`options`). Widget:
  `remote_image_url_widget`. Formatter: `remote_image_url_formatter`. Formatter settings:
  `max_width`, `max_height`, `image_loading[attribute]` (lazy/eager), `image_link` (''/content/image).
- Validation constraint: `RemoteImageUrl` (`RemoteImageUrlConstraint` + `…ConstraintValidator`).
- Service: `media.remote_image.resource_fetcher` (`RemoteImage\RemoteImageFetcher`;
  `fetchResource()`, `validateResource()`; cache key `media:remote_image_resource:{style}:{url}`).
- Route: `media_entity_remote_image.settings` (`Form\SettingsForm`). Menu link under
  `system.admin_config_media`.
- Config: `media_entity_remote_image.settings` — keys `generate_thumbnails` (bool, default false),
  `thumbnail_image_style` (default `media_library`; special `_original` =
  `MEDIA_ENTITY_REMOTE_IMAGE_ORIGINAL_IMAGE`), `local_images` (default `public://remote_image_thumbnails`).
- Media Library add form: `Form\RemoteImageForm` (id `media_library_add_form_remote_image`),
  registered via `hook_media_source_info_alter`.
- Hooks: `media_presave`, `field_config_presave`, `form_media_remote_image_edit_form_alter`,
  `form_field_config_edit_form_alter`, `media_source_info_alter`, `page_attachments`. Update hooks
  `8001`–`8005`.
- Library: `media_entity_remote_image/admin` (css/admin.css).
