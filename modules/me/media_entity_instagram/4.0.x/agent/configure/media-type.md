<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Configure an Instagram media type

## What you build

A core **Media type** (`media_type` config entity) whose `source` is `oembed:instagram`, with a
**source field** that stores the post URL, and the **`instagram_embed`** formatter on its
display. The module itself only provides the source + formatter plugins and a credentials
form; everything else is core Media configuration.

## Source field rules

The source's `allowed_field_types` are **`string`** and **`link`** — the source field must be
one of those. Core's `createSourceField()` makes a `string` field named
**`field_media_oembed_instagram`** by default. You can reuse an existing field across several
Instagram types, or give each type its own.

## Create it with Drush (headless)

```php
// drush php:eval '<this>'
use Drupal\media\Entity\MediaType;

$type = MediaType::create([
  'id' => 'instagram',
  'label' => 'Instagram',
  'source' => 'oembed:instagram',
  'source_configuration' => ['source_field' => ''],
]);
$type->save();

// Let the source create + attach its default source field, then record it.
$source = $type->getSource();
$field = $source->createSourceField($type);
$field->getFieldStorageDefinition()->save();
$field->save();
$type->set('source_configuration', ['source_field' => $field->getName()])->save();
```

After this, `MediaType::load('instagram')->get('source')` is `oembed:instagram` and
`->getSource()->getSourceFieldDefinition($type)->getName()` is `field_media_oembed_instagram`.
`prepareViewDisplay()` on the source auto-sets the `instagram_embed` formatter on the source
field when the display is prepared (e.g. via the UI or `media.type` display defaults).

## Formatter (`instagram_embed`) display settings

Set on the media type's view display for the source field:

| Key | Type | Meaning |
|---|---|---|
| `max_width` | integer | Maximum embed width in px (passed to the oEmbed request; `0` = provider default) |
| `hidecaption` | boolean | Hide the Instagram caption in the rendered embed |

## API credentials (settings form)

Config object **`media_entity_instagram.settings`** — keys `facebook_app_id` (numeric string)
and `facebook_app_secret` (32-char hex). UI: **`/admin/config/media/instagram-settings`**
(route `media_entity_instagram.settings`, permission `administer media`). Set headlessly:

```bash
drush config:set media_entity_instagram.settings facebook_app_id 123456789012345 -y
drush config:set media_entity_instagram.settings facebook_app_secret <32-hex> -y
```

These authenticate calls to Instagram's oEmbed/Graph API; live embedding of real posts needs
valid credentials **and** network access. Media-type/config-level setup does not.
