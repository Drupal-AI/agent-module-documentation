<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# The Instagram source & formatter plugins

The module does **not** define new plugin types. It ships two plugins on existing core types.

## Media source: `oembed:instagram`

`src/Plugin/media/Source/Instagram.php`, class
`Drupal\media_entity_instagram\Plugin\media\Source\Instagram`, extends core
`Drupal\media\Plugin\media\Source\OEmbed`. Declared with the `#[OEmbedMediaSource]` attribute:

| Attribute key | Value |
|---|---|
| `id` | `oembed:instagram` |
| `label` | `Instagram` |
| `allowed_field_types` | `["string", "link"]` |
| `providers` | `["Instagram"]` |
| `default_thumbnail_filename` | `instagram.png` |
| `forms` | `media_library_add` → `InstagramMediaLibraryAddForm` |

This id (`oembed:instagram`) is what appears as the `source` key of any media type that uses
Instagram. To find which media types use it:

```bash
drush php:eval 'foreach (\Drupal\media\Entity\MediaType::loadMultiple() as $t) { if ($t->getSource()->getPluginId() === "oembed:instagram") print $t->id()."\n"; }'
```

### URL recognition

`Instagram::$validationRegexp` accepts these post URL shapes (case-insensitive, on
`instagram.com` and `instagr.am`), capturing a `shortcode`:

- `.../p/<shortcode>` — standard posts
- `.../reel/<shortcode>` — reels
- `.../tv/<shortcode>` — IGTV

## Field formatter: `instagram_embed`

`src/Plugin/Field/FieldFormatter/InstagramEmbedFormatter.php`, `#[FieldFormatter]` with
id `instagram_embed`, `field_types: ["link", "string", "string_long"]`. Renders the oEmbed
HTML in an iframe. Settings: `max_width` (int), `hidecaption` (bool). The source's
`prepareViewDisplay()` assigns this formatter to the source field automatically.
