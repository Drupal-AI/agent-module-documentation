<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Video (`lightning_media_video`) — agent index

Glue submodule of Lightning Media that installs **two** media types. **No routes, no
permissions, no services, no settings form (`configure` = null), no config schema, no Drush,
no plugin types.** Depends only on `lightning_media`.

## All of the code

```php
// lightning_media_video.module
function lightning_media_video_media_source_info_alter(array &$sources) {
  Override::pluginClass($sources['video_file'], VideoFile::class);
}

// src/Plugin/media/Source/VideoFile.php
class VideoFile extends \Drupal\media\Plugin\media\Source\VideoFile implements InputMatchInterface {
  use \Drupal\lightning_media\FileInputExtensionMatchTrait;
}
```

Only the **local** `video_file` source gains input matching. `remote_video` uses core's
`oembed:video` source and is *not* input-matched, so a pasted YouTube URL is not
auto-detected by `MediaHelper`. `lightning_media_video.install` only declares
`hook_update_last_removed(): 8004`.

## Configuration it installs (all `config/optional/`)

| Media type | Source | Source field | Notes |
|---|---|---|---|
| `media.type.video` (**Video**) | `video_file` | `field_media_video_file` | default extensions **`mp4`** |
| `media.type.remote_video` (**Remote video**) | `oembed:video` | `field_media_oembed_video` | `providers: [YouTube, Vimeo]`, `thumbnails_directory: public://oembed_thumbnails/[date:custom:Y-m]` |

Both also get `field_media_in_library` and form displays (`default`, `media_library`) plus
view displays (`default`, `embedded`, `media_library`, `thumbnail`).

```bash
drush config:get media.type.remote_video source_configuration
drush config:get field.field.media.video.field_media_video_file settings.file_extensions
drush config:set field.field.media.video.field_media_video_file settings.file_extensions 'mp4 webm mov' -y
```

Add an oEmbed provider (core's oEmbed provider list, not this module):

```bash
drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("remote_video");
  $c = $t->getSource()->getConfiguration();
  $c["providers"][] = "Dailymotion";
  $t->set("source_configuration", $c)->save();
'
```

Create items programmatically:

```php
use Drupal\media\Entity\Media;
// local
Media::create(['bundle' => 'video', 'name' => 'Demo'])
  ->set('field_media_video_file', ['target_id' => $file->id()])->save();
// remote (fetches the oEmbed resource + thumbnail on save — needs network access)
Media::create(['bundle' => 'remote_video', 'name' => 'Keynote'])
  ->set('field_media_oembed_video', 'https://www.youtube.com/watch?v=XXXXXXXXXXX')->save();
```

Input-matching contract and `MediaHelper` API:
[`../../../../5.1.x/agent/api/media-helper.md`](../../../../5.1.x/agent/api/media-helper.md).
