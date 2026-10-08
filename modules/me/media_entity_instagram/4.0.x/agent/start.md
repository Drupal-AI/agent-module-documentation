<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# media_entity_instagram — agent index

Adds an **Instagram media source** to core Media. It registers one oEmbed source plugin
**`oembed:instagram`** (extends `Drupal\media\Plugin\media\Source\OEmbed`) and one field
formatter **`instagram_embed`**. You build a Media type with source "Instagram"; a
**string**- or **link**-typed source field holds the post URL; the source pulls the post HTML,
thumbnail and metadata from Instagram's oEmbed API. No new plugin types, permissions, or Drush
commands. Depends only on `media`.

- **Create / configure an Instagram media type** (source `oembed:instagram`, source field
  types `string`/`link`, formatter `instagram_embed` + its settings, credentials settings
  form) → [configure/media-type.md](configure/media-type.md)
- **The source & formatter plugins** (ids, allowed field types, providers, URL patterns) →
  [plugins/source.md](plugins/source.md)
- **Programmatic metadata** (metadata attributes, reading the shortcode / author in PHP) →
  [api/metadata.md](api/metadata.md)

Facts: source plugin id **`oembed:instagram`**, `allowed_field_types: ["string", "link"]`,
provider `Instagram`, default thumbnail `instagram.png`. Formatter id **`instagram_embed`**
(field types `link`, `string`, `string_long`; settings `max_width`, `hidecaption`). Settings
config object `media_entity_instagram.settings` (`facebook_app_id`, `facebook_app_secret`) at
route `media_entity_instagram.settings` → `/admin/config/media/instagram-settings`
(permission `administer media`). In a media_type config entity the chosen source is stored as
the `source` key = `oembed:instagram`.
