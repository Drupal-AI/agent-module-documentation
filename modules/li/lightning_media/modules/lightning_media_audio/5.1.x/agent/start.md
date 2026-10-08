<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Audio (`lightning_media_audio`) — agent index

Glue submodule of Lightning Media. **No routes, no permissions, no services, no settings
form (`configure` = null), no config schema, no Drush, no plugin types.** Depends only on
`lightning_media`.

## All of the code

```php
// lightning_media_audio.module
function lightning_media_audio_media_source_info_alter(array &$sources) {
  Override::pluginClass($sources['audio_file'], AudioFile::class);
}

// src/Plugin/media/Source/AudioFile.php
class AudioFile extends \Drupal\media\Plugin\media\Source\AudioFile implements InputMatchInterface {
  use \Drupal\lightning_media\FileInputExtensionMatchTrait;
}
```

That makes core's `audio_file` media source answer
`appliesTo($file, $media_type)` — TRUE when the file's extension is in the source field's
`file_extensions` setting — so `MediaHelper` can auto-detect the Audio type from a dropped
file. `lightning_media_audio.install` only declares
`hook_update_last_removed(): 8001`.

## Configuration it installs (all `config/optional/`, so existing config wins)

| Config | Value |
|---|---|
| `media.type.audio` | label **Audio**, source `audio_file`, source field `field_media_audio_file` |
| `field.storage.media.field_media_audio_file` + `field.field.media.audio.field_media_audio_file` | file field, default extensions **`mp3 wav aac`** |
| `field.field.media.audio.field_media_in_library` | Lightning Media's "Show in media library" boolean |
| `core.entity_form_display.media.audio.{default,media_library}` | form displays |
| `core.entity_view_display.media.audio.{default,embedded,media_library,thumbnail}` | view displays |

Useful commands:

```bash
drush config:get media.type.audio
drush config:get field.field.media.audio.field_media_audio_file settings.file_extensions
drush config:set field.field.media.audio.field_media_audio_file settings.file_extensions 'mp3 wav aac flac m4a' -y
```

Create an Audio media item programmatically:

```php
use Drupal\media\Entity\Media;
$media = Media::create(['bundle' => 'audio', 'name' => 'Episode 12']);
$media->set('field_media_audio_file', ['target_id' => $file->id()]);
$media->set('field_media_in_library', TRUE);
$media->save();
```

Nothing else to learn — for the input-matching contract and `MediaHelper` see the parent's
[`../../../../5.1.x/agent/api/media-helper.md`](../../../../5.1.x/agent/api/media-helper.md).
