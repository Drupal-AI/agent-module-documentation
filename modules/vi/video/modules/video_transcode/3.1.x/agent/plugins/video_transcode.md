# Plugin type: transcoders (`@Transcoder`)

Transcoding backends are pluggable. Add one to convert with a different engine (e.g. a cloud
service) instead of, or alongside, the bundled FFmpeg plugin.

| Aspect | Value |
|---|---|
| Plugin directory | `src/Plugin/video/Transcoder/` |
| Annotation | `@Transcoder` (`Drupal\video_transcode\Annotation\Transcoder`) |
| Interface | `Drupal\video_transcode\TranscoderInterface` |
| Base class | `Drupal\video_transcode\TranscoderBase` |
| Manager service | `video_transcode.provider_manager` (`Drupal\video_transcode\TranscoderManager`) |
| Alter hook | `video_transcode_transcoder_info` |
| Cache | `video_transcode_transcoders` |

Ships with the `ffmpeg` plugin (`isExternal = false`, a local service).

## Annotation properties

- `id` — plugin id (e.g. `ffmpeg`).
- `label` — human name.
- `description` — optional.
- `isExternal` — boolean; `false` for a locally installed engine like FFmpeg, `true` for a
  remote/cloud service.

## Interface

```php
interface TranscoderInterface extends PluginInspectionInterface {
  public function getOutputFiles();      // array of transcoded output files
  public function getVideoThumbnails();  // array of generated thumbnails
}
```

`TranscoderBase` (extends `PluginBase`, implements `ContainerFactoryPluginInterface`) is
constructed with `['file' => …]` plus the `http_client` service and adds:

- `getLabel()` — from the plugin definition.
- `getInputFile()` — the source `file` entity.
- `getAvailableCodecs()` — supported encode codecs (video: h264, vp8, theora, vp6, mpeg4, wmv;
  audio: aac, mp3, vorbis, wma).
- `getAvailableFormats($type = FALSE)` — supported container formats (3gp, aac, f4v, flv, m4v,
  mov, mp3, mp4, oga, ogg, ogv, ts, webm, wma, wmv, …).

## Example

```php
namespace Drupal\my_transcoder\Plugin\video\Transcoder;

use Drupal\video_transcode\TranscoderBase;

/**
 * @Transcoder(
 *   id = "cloud_encoder",
 *   label = @Translation("Cloud Encoder"),
 *   isExternal = true
 * )
 */
class CloudEncoder extends TranscoderBase {
  public function getOutputFiles() { /* return [['format' => 'mp4', 'url' => …, 'id' => …]] */ }
  public function getVideoThumbnails() { /* return [['id' => …, 'url' => …]] */ }
}
```

Clear caches so the manager rediscovers the plugin. **Caveat:** the shipped `ffmpeg` plugin's
`getOutputFiles()`/`getVideoThumbnails()` currently return hardcoded placeholder values rather
than performing a real conversion — treat it as a reference implementation.
