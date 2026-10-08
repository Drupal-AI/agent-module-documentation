<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# lightGallery (lightgallery) — agent index

Integrates the **lightGallery 2.x** JavaScript lightbox library with Drupal fields. Ships two field
formatters — `image_lightgallery_thumbnail` (image fields) and `media_lightgallery_thumbnail` (media
entity-reference fields) — that render a clickable thumbnail grid opening a lightbox gallery, plus a
reusable `lightgallery` theme hook for building galleries by hand. Version **2.0.3**, core `^10 || ^11`.

Depends on core `image` (`dependencies: drupal:image`); the media formatter also needs core `media`
at runtime. The lightGallery JS/CSS assets must be installed at `/libraries/lightgallery/dist/` (via
`composer require drupal/lightgallery` + asset-packagist), and lightGallery 2.x requires its own license
key set at the settings form.

- **Set the license key / global settings** → [configure/settings.md](configure/settings.md)
- **Apply and tune the image & media gallery formatters** → [fields/formatters.md](fields/formatters.md)
- **Build a custom gallery with the theme hook + libraries** → [theme/lightgallery.md](theme/lightgallery.md)
- **The one permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `lightgallery.settings`, single key `license_key` (schema constraints `NotBlank` +
  Regex `/^[A-Z0-9]+(-[A-Z0-9]+)+$/`). Install default `0000-0000-000-0000`.
- Settings route `lightgallery.admin.settings` → `/admin/config/user-interface/lightgallery`
  (`Drupal\lightgallery\Form\SettingsForm`), form id `lightgallery_settings_form`.
- Permission: `configure lightgallery`.
- Field formatter plugin ids: `image_lightgallery_thumbnail` (field type `image`),
  `media_lightgallery_thumbnail` (field type `entity_reference`, `isApplicable` only when
  `target_type === 'media'`).
- Formatter settings: `inline`, `thumbnail_image_style`, `thumbnail_loading` (`lazy`/`eager`),
  `gallery_image_style`, `custom_settings` (JSON); image adds `title_as_caption`, media adds
  `caption_view_mode`.
- Theme hook `lightgallery` (`lightgallery_theme()`; template `templates/lightgallery.html.twig`);
  preprocess `template_preprocess_lightgallery()`; also `lightgallery_preprocess_image()`.
- Asset library ids: `lightgallery/lightgallery`, `/init`, `/thumbnail`, and 13 plugin libraries
  `lightgallery/lightgallery-{autoplay,comment,fullscreen,hash,medium-zoom,pager,relative-caption,rotate,share,thumbnail,video,vimeo-thumbnail,zoom}`.
- No Drush commands; no plugin types defined; no services.
