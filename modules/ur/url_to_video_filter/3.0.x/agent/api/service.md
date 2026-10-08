# Service — URL→embed conversion (API)

`src/Service/UrlToVideoFilterService.php` (service id `url_to_video_filter.service`, autowired,
aliased to `Drupal\url_to_video_filter\Service\UrlToVideoFilterServiceInterface`). This is the whole
transform engine; the filter plugin (`FilterUrlToVideo::process()`) just calls it per enabled
provider and attaches the matching JS library.

```php
$svc = \Drupal::service('url_to_video_filter.service');
$result = $svc->convertYouTubeUrls($text);   // ['text' => <string>, 'url_found' => <bool>]
$result = $svc->convertVimeoUrls($text);      // same shape
```

## Interface

- `convertYouTubeUrls($text): array` — returns `['text' => $rewritten, 'url_found' => bool]`.
- `convertVimeoUrls($text): array` — same shape.

`url_found` is TRUE when at least one URL was matched *and* converted to a placeholder; the plugin
uses it to decide whether to attach `url_to_video_filter/youtube_embed` /
`url_to_video_filter/vimeo_embed`.

## How the transform works

1. **Parse** (`parseYouTubeUrls` / `parseVimeoUrls`): a `preg_match_all` collects candidate URLs.
   Both regexes require the URL to start the line or be preceded by whitespace / `]` / `>`
   (positive lookbehind `(^|(?<=[\]\>\s]))`) so URLs inside element attributes are skipped, and both
   restrict the URL body to a character class (`[\w\?\-=&\.;]+` for YouTube,
   `[a-zA-Z0-9\?\-=&\.;]+` for Vimeo).
2. **Extract the id** (`convertYouTubeUrlToEmbedCode` / `convertVimeoUrlToEmbedCode`): a second
   regex pulls the video key — `?v=…` / `/embed/…` / `youtu.be/…` for YouTube, the path segment for
   Vimeo. Returns `NULL` (URL left untouched) when no id is found.
3. **Replace** (back in `convert*Urls`): each exact matched URL is swapped for placeholder markup
   with `preg_replace`, preserving the leading boundary char.

Placeholder markup (JS turns it into a thumbnail/iframe client-side — see `js/youtube_embed.js`,
`js/vimeo_embed.js`):

```html
<span class="url-to-video-container youtube-container no-js"><span class="youtube-player url-to-video-player loader" data-youtube-id="VIDEO_ID"></span></span>
```

(`vimeo-container` / `vimeo-player` / `data-vimeo-id` for Vimeo.) Any `?query` after the id is split
off client-side in JS and re-appended to the embed `src`.

## Notes

- The service is stateless and has no injected dependencies — safe to call directly from PHP,
  migrations, or tests, independent of the filter plugin.
