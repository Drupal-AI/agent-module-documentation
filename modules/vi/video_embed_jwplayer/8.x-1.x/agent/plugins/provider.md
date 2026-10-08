# `jwplayer` — Video Embed Field provider plugin

The module's only code: `src/Plugin/video_embed_field/Provider/JwPlayer.php`, a plugin of the
**`VideoEmbedProvider`** type that `video_embed_field` defines. It extends
`Drupal\video_embed_field\ProviderPluginBase`.

```php
/**
 * @VideoEmbedProvider(
 *  id = "jwplayer",
 *  title = @Translation("JW Player")
 * )
 */
class JwPlayer extends ProviderPluginBase { … }
```

## Lifecycle (how the parent uses it)

1. When a URL is entered/stored in a `video_embed_field`, the parent's `ProviderManager` asks each
   provider `isApplicable($input)`, which calls the static `getIdFromInput($input)` — a non-`FALSE`
   return means "this URL is a JW Player URL, I own it".
2. `ProviderPluginBase::__construct` then sets `$this->videoId = static::getIdFromInput($input)`.
   `getVideoId()` returns that extracted id (never the raw URL) for the rest of the plugin.
3. The "Video" formatter calls `renderEmbedCode()`; the thumbnail formatter/download uses
   `getRemoteThumbnailUrl()`.

## URL formats accepted (`getIdFromInput`)

```php
public static function getIdFromInput($input) {
  if (preg_match('@\/\/\w+\.(jwplayer|jwplatform)\.com\/[^\/]+\/(?<id>[\_\-a-zA-Z0-9]+)@i', $input, $matches)) {
    return !empty($matches['id']) ? $matches['id'] : FALSE;
  }
  return FALSE;
}
```

Matches any `//SUBDOMAIN.jwplayer.com/SOMETHING/<id>` or `…jwplatform.com/…` URL (case-insensitive),
capturing the trailing path segment as the **combined id** `MEDIAID-PLAYERID`. Concretely the README
lists: `//content.jwplatform.com/players/MEDIAID-PLAYERID.html` (iframe),
`…/players/MEDIAID-PLAYERID.js` (JS), `https://content.jwplatform.com/previews/MEDIAID-PLAYERID`
(preview), and the `cdn.jwplayer.com` equivalents. The named group `(?<id>[\_\-a-zA-Z0-9]+)` is a
strict allowlist — the captured id can only contain letters, digits, `_` and `-` (it stops at the
first `.`, so the `.html`/`.js` suffix is dropped).

## Id decomposition

```php
public function getJwPlayerMediaId() {   // "nPripu9l"  — 8-char media id, before the first "-"
  if ($embed_id = $this->getVideoId()) {
    @[$media_id] = explode('-', $embed_id);
    return $media_id ? $media_id : NULL;
  }
}
public function getJwPlayerPlayerId() {   // "ALJ3XQCI" — 8-char player id, after the "-"
  if ($embed_id = $this->getVideoId()) {
    @[, $player_id] = explode('-', $embed_id);
    return $player_id ? $player_id : NULL;
  }
}
```

## Rendered markup (`renderEmbedCode`)

```php
public function renderEmbedCode($width, $height, $autoplay) {
  return [
    '#type' => 'video_embed_iframe',
    '#provider' => 'jwplayer',
    '#url' => sprintf('//content.jwplatform.com/players/%s.html', $this->getVideoId()),
    '#attributes' => [
      'width' => $width, 'height' => $height,
      'frameborder' => '0', 'allowfullscreen' => 'allowfullscreen',
      'title' => $this->t('Embedded video from JW Player'),
    ],
  ];
}
```

Note: `$autoplay` is accepted (interface contract) but **not** applied — the plugin never adds an
autoplay query param. The host is always the hardcoded `content.jwplatform.com`; only the extracted
id varies. The parent's `video_embed_iframe` render element (`Element\VideoEmbedIFrame`) hands `#url`
to the `video-embed-iframe.html.twig` template as `src="{{ url }}…"`, which Twig auto-escapes.

## Thumbnail (`getRemoteThumbnailUrl`)

```php
const REMOTE_THUMBNAIL_WIDTH = 720;
public function getRemoteThumbnailUrl() {
  if ($media_id = $this->getJwPlayerMediaId()) {
    return sprintf("https://cdn.jwplayer.com/thumbs/%s-%s.jpg", $media_id, $this->getRemoteThumbnailWidth());
  }
}
```

The parent downloads this poster once and caches it locally (per `ProviderPluginBase::downloadThumbnail`).
Host is the hardcoded `cdn.jwplayer.com`; only the media id (allowlisted charset) and the fixed width
`720` vary. Override `getRemoteThumbnailWidth()` in a subclass to change the requested poster size.

## Writing your own provider like it

Put a class at `my_module/src/Plugin/video_embed_field/Provider/MyProvider.php`, annotate it
`@VideoEmbedProvider(id = "myprovider", title = @Translation("My host"))`, extend
`ProviderPluginBase`, and implement at minimum `getIdFromInput($input)` (return the id or `FALSE`),
`renderEmbedCode($width, $height, $autoplay)`, and `getRemoteThumbnailUrl()`. Keep the id-extraction
regex an allowlist (as here) and interpolate only the extracted id into fixed-host URLs. Clear caches
after adding.
