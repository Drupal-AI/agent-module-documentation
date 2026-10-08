# The Facebook provider plugin

The whole module is one class:
`Drupal\video_embed_facebook\Plugin\video_embed_field\Provider\Facebook`, annotated
`@VideoEmbedProvider(id = "facebook", title = @Translation("Facebook"))`, extending
`ProviderPluginBase` from `video_embed_field`. Video Embed Field auto-discovers it; there is nothing
to configure.

## What it implements

| Method | Behaviour |
|---|---|
| `getIdFromInput($input)` | Regex-extracts the numeric video id. Matches `https?://(www.)?facebook.com/<page>/videos/<id>` and `https?://(www.)?facebook.com/video.php?v=<id>`; returns the `<id>` (digits) or FALSE. |
| `renderEmbedCode($width,$height,$autoplay)` | Returns a `#type => 'video_embed_iframe'` element with `#url => 'https://www.facebook.com/plugins/video.php?href=' . $this->getInput()`, `#query => ['autoplay' => …, 'show_text' => '0']`, and width/height/frameborder/allowfullscreen attributes. |
| `getRemoteThumbnailUrl()` | `https://graph.facebook.com/<id>/picture` — Video Embed Field downloads this for image-style thumbnails. |

`isApplicable()`, `renderThumbnail()`, `downloadThumbnail()`, `getLocalThumbnailUri()`, etc. are
inherited from `ProviderPluginBase`; `isApplicable($input)` there is simply
`!empty(static::getIdFromInput($input))`, so a URL "is a Facebook video" iff the regex matches.

## Using it (no module-specific setup)

There is no UI for this module itself. You use Video Embed Field:

1. Add a field of type **`video_embed_field`** to a bundle (e.g. Article).
2. (Optional) In the field settings, *Allowed providers* can be limited; leaving it empty allows all,
   including Facebook.
3. Set the display formatter (Video, Thumbnail, Colorbox…) on *Manage display*.
4. Editors paste a Facebook video URL; the value stored is the raw URL string. Provider resolution
   (`video_embed_field.provider_manager` → `loadProviderFromInput($url)`) picks `facebook`.

```php
// Programmatic: store a Facebook video in a video_embed_field field.
\Drupal\node\Entity\Node::create([
  'type' => 'article', 'title' => 'FB clip',
  'field_video' => 'https://www.facebook.com/somepage/videos/1234567890',
])->save();
```

## Important compatibility caveat (observed on this site)

`Facebook::renderEmbedCode($width, $height, $autoplay)` overrides
`ProviderPluginBase::renderEmbedCode($width, $height, $autoplay, $title_format = NULL,
$use_title_fallback = TRUE)` with **fewer parameters**, which PHP rejects at class-load time:

```
Declaration of …\Facebook::renderEmbedCode($width, $height, $autoplay) must be compatible with
…\ProviderPluginBase::renderEmbedCode($width, $height, $autoplay, $title_format = null,
$use_title_fallback = true)
```

Consequences on this environment:
- **Storing** a Facebook URL in a `video_embed_field` and **reading the raw value** work (the plugin
  class is not loaded for that).
- **Rendering** the field, or any call that resolves providers for a video URL (e.g.
  `ProviderManager::loadDefinitionFromInput()`, which calls `Facebook::isApplicable()` and thus loads
  the class), **fatals**.

To actually use the provider, the plugin would need `renderEmbedCode()` updated to the current base
signature (add `$title_format = NULL, $use_title_fallback = TRUE`). This is a module/dependency
version mismatch, not a configuration issue.
