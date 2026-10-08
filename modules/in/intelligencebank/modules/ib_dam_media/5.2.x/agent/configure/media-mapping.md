# Configure ib_dam_media (type mapping & upload location)

Form `Drupal\ib_dam_media\Form\MediaConfigurationForm` (form id `ib_dam_media_configuration_form`),
route `ib_dam_media.configuration_form` at **`/admin/config/services/ib_dam/media`**, permission
`administer intelligencebank configuration`. It edits config object **`ib_dam_media.settings`**.
Appears as the "Media settings" local task under the parent's global settings.

## Config keys (`ib_dam_media.settings`)

| Key | Type | Meaning |
|---|---|---|
| `upload_location` | string | Stream-wrapper URI where downloaded local copies are written. Default `public://intelligencebank` (used by `MediaLibraryIbDamBrowserForm::getUploadLocation()`). |
| `media_types` | sequence of `{source_type, media_type}` | Maps each IB **source asset type** (`image`, `video`, `audio`, `file`, `embed`) to a local **media type** id. Only mapped source types can be imported. |

## The mapping form

Rows come from `MediaTypeMatcher::getSupportedSourceTypes()`; for each source type you pick a target
media type from `getSupportedMediaTypes($type_id)`. On submit, rows with an empty media type are
dropped; the rest are saved as `{source_type, media_type}` entries.

## Set via PHP

```php
\Drupal::configFactory()->getEditable('ib_dam_media.settings')
  ->set('upload_location', 'public://intelligencebank')
  ->set('media_types', [
    'image' => ['source_type' => 'image', 'media_type' => 'image'],
    'embed' => ['source_type' => 'embed', 'media_type' => 'ib_dam_embed'],
  ])
  ->save();
```

The `embed` mapping must point at a media type whose source is `ib_dam_embed` for CDN-link embedding to
work; the shipped `ib_dam_embed` media type (source field `field_media_ib_dam_embed`) is the intended
target. The `embed` source type is only offered when the parent's `allow_embedding` setting is on.

## Install / update notes (`ib_dam_media.install`)

- `ib_dam_media_update_8601` migrates old embed field structures into the current
  `options.attributes.ib_dam` shape.
- `ib_dam_media_update_8602` removes the obsolete `dialog_mode` ("Stacked") setting; the Media Library
  now always uses the standard dialog flow.
