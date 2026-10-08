<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Reading Instagram metadata programmatically

The source exposes oEmbed-derived fields via core Media's source API. Get the source from a
media entity and call `getMetadata()`:

```php
/** @var \Drupal\media\MediaInterface $media */
$source = $media->getSource();            // Drupal\media_entity_instagram\Plugin\media\Source\Instagram
$shortcode = $source->getMetadata($media, 'shortcode');
$author    = $source->getMetadata($media, 'author_name');
$html      = $source->getMetadata($media, 'html');
```

## Metadata attributes (`getMetadataAttributes()`)

| Name | Meaning |
|---|---|
| `shortcode` | The post shortcode parsed from the URL (no API call needed) |
| `type` | Resource type |
| `author_name` | Name of the author/owner |
| `default_name` | Default media name (`author_name - shortcode`, else shortcode) |
| `provider_name` | Provider name |
| `provider_url` | Provider URL |
| `thumbnail_uri` | Local URI of the fetched thumbnail |
| `thumbnail_width` / `thumbnail_height` | Thumbnail dimensions |
| `width` | Resource width |
| `html` | oEmbed HTML representation of the post |

## What needs the network vs. what doesn't

- **`shortcode`** and **`default_name`** (its fallback) are derived locally from the source
  field URL via `Instagram::$validationRegexp` — no API call.
- Everything else (`author_name`, `html`, `thumbnail_*`, `width`, …) comes from Instagram's
  **oEmbed API**, so it requires valid `facebook_app_id` / `facebook_app_secret` credentials
  and outbound network access. In an offline/eval environment these resolve to empty/`FALSE`;
  keep automated checks at the config level (media type, source id, source field), not on
  fetched post content.
