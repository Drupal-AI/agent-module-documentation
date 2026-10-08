<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Seeds Media (seeds_media) — agent index

Small media-library enhancement module from the **Seeds distribution**. Version **1.0.3**
(version-dir `1.0.x`). Core `^10 || ^11`. Package `Seeds`. License GPL-2.0-or-later. Configure
at **`/admin/config/seeds-media`** (route `seeds_media.config`, menu under Configuration → Media).

Despite the info.yml blurb ("Provide needed media types…"), the module **ships no media types,
view modes, or image styles** — no `config/install` beyond one settings object. It only augments
core Media's edit UX.

## Dependencies

Core: `field`, `file`, `image`, `media`, `path`, `text`, `user`, `views`, `media_library`.
Contrib (required, via composer): **`media_library_edit` `^3.0`** — edit a media item without
leaving the media library.

## What it actually provides (from source)

- **`is_default` base field** on every media entity — a required boolean, default FALSE. Declared
  in `hook_entity_base_field_info()` (`seeds_media.module`) and installed for existing sites by
  `seeds_media_update_8801()` (`seeds_media.install`).
- **Default-media guard + usability warning** on the media *image* edit form, via
  `seeds_media_form_media_image_edit_form_alter()`. See [config/settings.md](config/settings.md).
- **`MediaHelper` service** (`seeds_media.helper`, class `Drupal\seeds_media\MediaHelper`) — one
  method `mediaUseablity(MediaInterface $media)` returning the reference count across all media
  reference fields. See [api/media-helper.md](api/media-helper.md).
- **Config form** `SeedsMediaConfigForm` writing `seeds_media.settings` (one key
  `check_media_usability`). See [config/settings.md](config/settings.md).
- **Entity-embed link wrapper**: `seeds_media_preprocess_entity_embed_container()` turns an embed
  into a `#type => link` when the embed display settings carry a `link_url`.
- **Media-library widget tweak**: `seeds_media_field_widget_form_alter()` appends
  `?status=new|current` to each item's edit-button href so the usability check can tell the
  currently-selected item apart from others.

## Routes & permissions

- Route `seeds_media.config` → `/admin/config/seeds-media`, requires **`administer seeds media`**.
- Permissions (`seeds_media.permissions.yml`): `administer seeds media` (restricted),
  `bypass default media access`. Plus `assign default medias` referenced in code (see caveat in
  [config/settings.md](config/settings.md)).

## Solution docs

- [config/settings.md](config/settings.md) — settings object, the two form-alter behaviors,
  permissions, how to operate the default-media guard and usability warning.
- [api/media-helper.md](api/media-helper.md) — the `seeds_media.helper` service and
  `mediaUseablity()` for custom code.

No Drush commands. No config schema shipped. No plugin types. No custom entities.
