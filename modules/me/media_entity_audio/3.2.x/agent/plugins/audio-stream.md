<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio Stream: media source, formatter & theme

## Media source `audio_stream` (`AudioStream`)

`@MediaSource(id = "audio_stream", label = "Audio Stream", allowed_field_types = {"link"}, default_thumbnail_filename = "audio.png")`
— extends `MediaSourceBase`.

- **Source field type**: `link` (the audio is referenced by URL, not uploaded).
- `getMetadataAttributes()` → `default_name`; `getMetadata()` returns the URI's basename as the
  default media name.
- `prepareViewDisplay()` sets the source field's display component to the `audio_stream_html5`
  formatter with `label => visually_hidden` when the type is created.

### Create a media type using it

```php
use Drupal\media\Entity\MediaType;

$type = MediaType::create(['id' => 'audio_stream', 'label' => 'Audio Stream', 'source' => 'audio_stream']);
$type->save();
// Let the source create its link source field, then wire it up:
$field = $type->getSource()->createSourceField($type);
$field->getFieldStorageDefinition()->save();
$field->save();
$type->set('source_configuration', ['source_field' => $field->getName()])->save();
```

Stored config (`media.type.<id>`):

```yaml
source: audio_stream
source_configuration:
  source_field: field_media_audio_stream   # a link field
```

Read back: `drush cget media.type.<id> source`.

In the UI: *Structure → Media types → Add media type*, choose **Audio Stream** as the media
source, save (core creates the link source field).

## Formatter `audio_stream_html5` (`AudioStreamHTML5`)

`@FieldFormatter(id = "audio_stream_html5", field_types = {"link"})`.

- Single setting **`controls`** (boolean, default TRUE) — whether the `<audio>` element shows
  transport controls. Summary reads "Audio controls displayed." / "not displayed.".
- Renders each item as `['#theme' => 'media_audio', '#sources' => [$item->uri], '#controls' => …]`.

Config (`field.formatter.settings.audio_stream_html5`): `controls: boolean`.

## Theme hook `media_audio`

`template_preprocess_media_audio()` + `templates/media-audio.html.twig`:

- Builds an `<audio>` element with one `<source src type>` per URL.
- MIME type is guessed with the `file.mime_type.guesser` service and mapped by
  `_media_entity_audio_map_mime()`: `audio/x-wav` → `audio/wav`; `audio/mpeg` and `audio/ogg`
  pass through; anything else yields **no** `type` attribute on that `<source>`.
- When `controls` is TRUE, adds the `controls` attribute to `<audio>`.
- Variables: `sources` (array of `{url, type}`), `controls` (bool), plus `attributes`.

## Notes

- No settings form, no permissions, no Drush, `configure = null`.
- `media_entity_audio_update_8301()` migrates legacy `audio` media sources: link-backed ones
  become `audio_stream`, file-backed ones become core `audio_file` (and switch the display to
  core's `file_audio` formatter).
