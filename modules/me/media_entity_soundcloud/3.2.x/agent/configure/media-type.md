<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up a SoundCloud media type

There is no module settings page (`configure` = null). You configure everything through a **media
type**, its **source field**, and the **display formatter**.

## 1. Create the media type (UI)

1. `/admin/structure/media/add`.
2. **Media source** → *Soundcloud*. Save.
3. Drupal creates/needs a **source field** (a `string`/`string_long`/`link` field) that holds the
   SoundCloud URL. Confirm/choose it under the type's source settings.

Config produced: `media.type.<id>` with `source: soundcloud` and
`source_configuration.source_field: <field_name>`.

## 2. Create the media type (config / drush php:eval)

```php
use Drupal\media\Entity\MediaType;
$type = MediaType::create(['id' => 'podcast', 'label' => 'Podcast', 'source' => 'soundcloud']);
$type->save();
// Let the source create its default URL field, then wire it up:
$field = $type->getSource()->createSourceField($type);   // string field, name field_media_soundcloud
$field->getFieldStorageDefinition()->save();
$field->save();
$type->set('source_configuration', ['source_field' => $field->getName()])->save();
```

(You may instead create your own `string`/`link` field on the `media` entity and set it as
`source_field`.)

## 3. Configure the embed display

On the type's **Manage display** (`/admin/structure/media/manage/<id>/display`):

- Set the **source field**'s Format to **Soundcloud embed** (`soundcloud_embed`).
- Click the cog to set player options (see [theming/embed.md](../theming/embed.md) for every key):
  `type` (visual/classic), `width` (default `100%`), `height` (default `450`), `color`
  (default `#ff5500`), and the `options` checkboxes.

Formatter config lives in `core.entity_view_display.media.<id>.<view_mode>` →
`content.<source_field>.type = soundcloud_embed` and `.settings`.

## 4. Module config object

`media_entity_soundcloud.settings` (schema `config/schema/…`) has a single key:

| Key | Default | Meaning |
|---|---|---|
| `thumbnail_destination` | `public://soundcloud` | Directory where thumbnails fetched from oEmbed are saved. |

```bash
drush cget media_entity_soundcloud.settings thumbnail_destination
drush cset media_entity_soundcloud.settings thumbnail_destination 'public://audio_thumbs' -y
```

## Adding items

Editors add a SoundCloud item by entering its URL in the source field, or via the **Media Library**
add form (`SoundcloudForm`, form id `soundcloud_media_add_form`) which shows an "Add Soundcloud
Track URL" textfield and validates that the URL matches `soundcloud.com` and is reachable.
