# Video Filter — the `video_filter` codec plugin type

Each supported provider is a plugin of the module's own `video_filter` plugin type. Add support for a
new site by writing one.

## Plugin mechanics

- **Manager**: `plugin.manager.video_filter` (`VideoFilterManager extends DefaultPluginManager`),
  discovers `Plugin/VideoFilter/*` classes.
- **Attribute/annotation**: `@VideoFilter` (`src/Annotation/VideoFilter.php`). Properties: `id`, `name`
  (Translation), `example_url`, `regexp` (array of PCRE patterns), `ratio` (e.g. `"16/9"`),
  `control_bar_height` (int).
- **Base class**: `Drupal\video_filter\VideoFilterBase` (implements `VideoFilterInterface`). Override the
  render methods you need.

## Minimal codec

```php
namespace Drupal\my_module\Plugin\VideoFilter;

use Drupal\video_filter\VideoFilterBase;

/**
 * @VideoFilter(
 *   id = "example",
 *   name = @Translation("Example"),
 *   example_url = "https://www.drupal.org/project/video_filter",
 *   regexp = { "/drupal\.org\/project\/([0-9a-z_]+)/i" },
 *   ratio = "4/3",
 * )
 */
class ExampleCodec extends VideoFilterBase {

  public function iframe($video) {
    // $video['codec']['matches'] holds the regexp capture groups; [1] is the first.
    return [
      'src' => 'https://example.com/embed/' . $video['codec']['matches'][1],
      'properties' => ['allowfullscreen' => 'true'],
    ];
  }
}
```

Place it in `my_module/src/Plugin/VideoFilter/ExampleCodec.php`. After a cache rebuild it appears in the
per-format *Enabled plugins* checkboxes. (See the shipped `video_filter_example` submodule for a working
copy.)

## Methods you can override (`VideoFilterInterface` / `VideoFilterBase`)

| Method | Return | Purpose |
|---|---|---|
| `iframe($video)` | `['src' => ..., 'properties' => [...]]` | Build the iframe `src` and extra attributes. Most codecs implement this. |
| `html($video)` | HTML string | Raw HTML embed (oEmbed etc.); rendered via `{{ video.html\|raw }}`. Sanitize yourself. |
| `flash($video)` | array | Deprecated Flash `<object>`; removed in 2.0. |
| `options()` | Form API array | Per-video option fields shown in the (legacy CKEditor) dialog. |
| `instructions()` | string | Special syntax notes shown in the filter tips. |
| `preview($video)` | absolute URL | Preview image for the WYSIWYG dialog. |
| `getName/getRegexp/getRatio/getControlBarHeight/getExampleUrl` | — | Read annotation values (provided by base). |

## The `$video` array passed to your methods

Keys include: `source` (matched URL), `codec` (`matches`, `delta`, `ratio`, `control_bar_height`, `id`),
resolved `width`/`height`, `align`, plus any inline option the author supplied (`autoplay`, `loop`, …).
Note inline option values are pre-filtered to `[0-9a-zA-Z/]`.

## Regexp captures

`regexp` is an array; the first pattern that matches the URL wins. Use a capture group for the video id —
it lands in `$video['codec']['matches'][1]`. YouTube, for example, uses several patterns to accept
`watch?v=`, `youtu.be/`, `/v/`, and `/embed/` forms.

## Altering the final video (hook)

Any module may adjust the assembled `$video` array just before rendering:

```php
function my_module_video_filter_video_alter(array &$video) {
  // e.g. force width, add a query param to $video['codec']['matches'], etc.
}
```

Invoked as `$moduleHandler->alter('video_filter_video', $video)` inside the filter's `process()`.
