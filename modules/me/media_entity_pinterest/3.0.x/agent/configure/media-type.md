# Set up a Pinterest media type

The module ships no media type — you create one that uses the `pinterest` source. No admin settings page
and no permissions of its own; it relies entirely on core Media UI/permissions.

## Steps (UI)

1. *Structure → Media types → Add media type*. Give it a name (e.g. "Pinterest"); set **Media source** to
   **Pinterest**. Save.
2. Core auto-creates (or you add) a **source field** — must be a `link`, `string`, or `string_long`
   field. Add it if prompted.
3. On the media type edit form set **Field with source information** to that field
   (`source_configuration.source_field`).
4. *Manage display*: set the source field's formatter to **Pinterest embed** (`pinterest_embed`) so the
   URL renders as a live embed rather than plain text.
5. Optionally map metadata (`id`, `board`, `section`, `user`) to fields via the media type's **Field
   mapping**.

## The one setting

`media_entity_pinterest.settings:local_images` (default `public://pinterest-thumbnails`) — base folder for
locally stored thumbnails. There is no form for it; set via config:

```bash
drush cset media_entity_pinterest.settings local_images 'public://pinterest-thumbnails' -y
```

## Create the media type with Drush/config (example)

```php
// drush php:eval
$type = \Drupal::entityTypeManager()->getStorage('media_type')->create([
  'id' => 'pinterest',
  'label' => 'Pinterest',
  'source' => 'pinterest',
  'source_configuration' => ['source_field' => 'field_media_pinterest'],
]);
$type->save();
// Then add a string/link field named field_media_pinterest to media.pinterest and set its
// display formatter to 'pinterest_embed'.
```

## Using it

Editors create a Pinterest media entity and paste a Pinterest URL (pin/board/section/profile) into the
source field. The `PinEmbedCode` constraint rejects anything that is not a recognised Pinterest URL. On
display, the `pinterest_embed` formatter emits the correct embed markup and loads Pinterest's `pinit.js`.
See [../plugins/source.md](../plugins/source.md) for the exact URL patterns and metadata.
