# Plugin type: embed providers (`VideoEmbeddableProvider`)

Remote video hosts are pluggable. To support a new host (or override an existing one), add a
provider plugin.

| Aspect | Value |
|---|---|
| Plugin directory | `src/Plugin/video/Provider/` |
| Annotation | `@VideoEmbeddableProvider` (`Drupal\video\Annotation\VideoEmbeddableProvider`) |
| Interface | `Drupal\video\ProviderPluginInterface` |
| Base class | `Drupal\video\ProviderPluginBase` |
| Manager service | `video.provider_manager` (`Drupal\video\ProviderManager`, extends `DefaultPluginManager`) |

Ships with: `youtube`, `vimeo`, `dailymotion`, `facebook`, `instagram`, `vine`.

## Annotation properties

- `id` — plugin id, **must equal the stream-wrapper scheme** (see below).
- `label`, `description`.
- `regular_expressions` — array of PCRE patterns matched against the pasted URL/embed code;
  a named `(?<id>…)` capture group supplies the video id used to build the stream URI.
- `mimetype` — e.g. `video/youtube`, stored on the created `file` entity.
- `stream_wrapper` — the scheme (e.g. `youtube`) the file URI is built under.

## Interface methods

```php
public function renderEmbedCode($settings);   // return a render array (iframe/html_tag)
public function getRemoteThumbnailUrl();       // return remote thumbnail URL (or FALSE)
```

`ProviderPluginBase` supplies the rest: it is constructed with `['file','metadata','settings']`
plus the `http_client` service, and provides `renderThumbnail($image_style, $link_url)`,
`downloadThumbnail()`, `getLocalThumbnailUri()`, and helpers `getVideoFile()`,
`getVideoMetadata()`, `getVideoSettings()`.

## Example (abridged, YouTube)

```php
namespace Drupal\my_module\Plugin\video\Provider;

use Drupal\video\ProviderPluginBase;

/**
 * @VideoEmbeddableProvider(
 *   id = "youtube",
 *   label = @Translation("YouTube"),
 *   regular_expressions = {
 *     "@//(?:www\.)?youtube\.com/watch(\?|\?.*\&)v=(?<id>[a-z0-9_-]+)@i",
 *     "@//youtu\.be/(?<id>[a-z0-9_-]+)@i"
 *   },
 *   mimetype = "video/youtube",
 *   stream_wrapper = "youtube"
 * )
 */
class MyYouTube extends ProviderPluginBase {
  public function renderEmbedCode($settings) {
    $data = $this->getVideoMetadata();
    return ['#type' => 'html_tag', '#tag' => 'iframe', '#attributes' => [
      'width' => $settings['width'], 'height' => $settings['height'],
      'src' => 'https://www.youtube.com/embed/' . $data['id'],
    ]];
  }
  public function getRemoteThumbnailUrl() {
    $data = $this->getVideoMetadata();
    return 'http://img.youtube.com/vi/' . $data['id'] . '/hqdefault.jpg';
  }
}
```

## Register the stream wrapper

Each provider needs a matching read-only stream wrapper so embeds become managed files.
Declare it in `*.services.yml` tagged `stream_wrapper` with the `scheme` equal to the plugin
`stream_wrapper`/id, and extend `Drupal\video\StreamWrapper\VideoRemoteStreamWrapper`:

```yaml
services:
  stream_wrapper.myhost:
    class: Drupal\my_module\StreamWrapper\MyHostStream
    tags:
      - { name: stream_wrapper, scheme: myhost }
```

Clear caches so the plugin manager (`video_embed` widget's provider list) picks up the new
provider.
