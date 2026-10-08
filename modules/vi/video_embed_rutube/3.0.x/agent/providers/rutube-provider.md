<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rutube provider plugin

`src/Plugin/video_embed_field/Provider/Rutube.php`
Class `Drupal\video_embed_rutube\Plugin\video_embed_field\Provider\Rutube`
extends `Drupal\video_embed_field\ProviderPluginBase`.

```php
/**
 * @VideoEmbedProvider(
 *   id = "rutube",
 *   title = @Translation("Rutube")
 * )
 */
```

This is the module's only class. It plugs into **Video Embed Field's** `VideoEmbedProvider` plugin
type (manager `plugin.manager.video_embed_field.provider`). It does **not** create a plugin type of
its own. Constructor, HTTP client (`$this->httpClient`), logger, file system, cache and the
`getVideoId()` helper are all inherited from `ProviderPluginBase`.

## Method contract

| Method | Purpose |
| --- | --- |
| `getIdFromInput($input)` *(static)* | Regex-extract the video id. Drives `isApplicable()` (id non-empty ⇒ this provider claims the URL). |
| `getTimeIndex($input)` *(static)* | Parse a `t=<seconds>` start offset. |
| `renderEmbedCode($width, $height, $autoplay, ...)` | Build the embed render array. |
| `getRemoteThumbnailUrl()` | Return the poster URL from Rutube's oEmbed data. |
| `oEmbedData($key = FALSE)` *(protected)* | GET and JSON-decode the oEmbed response; return one key or the whole array. |

## URL recognition

```php
preg_match('/https?:\/\/(www\.)?rutube.ru\/(video|shorts)\/(?<id>[a-z0-9]*)(.*?)/', $input, $matches);
return $matches['id'] ?? FALSE;
```

- Accepts `http`/`https`, optional `www.`, path `video` or `shorts`.
- Named group `id` captures the Rutube hash, restricted to lowercase-hex-ish `[a-z0-9]`.
- Trailing slash, `?r=wd`, `&t=825` etc. are ignored (the `(.*?)` tail).
- `rutube.ru/video/` (no id) and `rutube.ru/video/-/` yield an empty id → provider does not apply.

## Embed output

```php
$iframe = [
  '#type' => 'video_embed_iframe',
  '#provider' => 'rutube',
  '#url' => sprintf('https://rutube.ru/play/embed/%s', $this->getVideoId()),
  '#attributes' => [
    'width' => $width,
    'height' => $height,
    'frameborder' => '0',
    'webkitAllowFullScreen' => 'webkitAllowFullScreen',
    'mozallowfullscreen' => 'mozallowfullscreen',
    'allowfullscreen' => 'allowfullscreen',
  ],
];
$allowed = ['clipboard-write'];
if ($autoplay) { $allowed[] = 'autoplay'; }
$iframe['#attributes']['allow'] = implode('; ', $allowed);
if ($timeIndex = self::getTimeIndex($this->input)) {
  $iframe['#query']['t'] = $timeIndex;
}
```

The `video_embed_iframe` render element (`Drupal\video_embed_field\Element\VideoEmbedIFrame`) themes
via `templates/video-embed-iframe.html.twig`:

```twig
<iframe{{ attributes }}{% if url is not empty %} src="{{ url }}{% if query is not empty %}?{{ query | url_encode }}{% endif %}..."{% endif %}></iframe>
```

`#url` and `#query` are printed through Twig's autoescaping, and `#query` is additionally
`url_encode`d. `$width`/`$height`/`autoplay` come from the field formatter's settings (Video Embed
Field), not from the URL.

> Deprecation note: in `video_embed_field:3.1.0` the base `renderEmbedCode()` is deprecated in favour
> of `renderEmbed(array $options)`; the base class still bridges old overrides like this one, so the
> plugin keeps working. If Video Embed Field reaches 3.2.0 this override may need porting to
> `renderEmbed()`.

## Thumbnail path

```php
public function getRemoteThumbnailUrl() {
  return $this->oEmbedData('thumbnail_url');
}

protected function oEmbedData($key = FALSE) {
  $videoId = $this->getVideoId();
  $uri = "https://rutube.ru/api/oembed/?url=https://rutube.ru/video/$videoId/&format=json";
  $response = $this->httpClient->request('GET', $uri);
  $data = json_decode($response->getBody(), TRUE);
  // ... errors caught and logged to channel 'video_embed_rutube'.
  return $key ? $data[$key] : $data;
}
```

- The oEmbed request URL is built only from `getVideoId()` (the `[a-z0-9]` hash), so it cannot be
  steered off `rutube.ru`.
- `getRemoteThumbnailUrl()` is called by `ProviderPluginBase::downloadThumbnail()`, which fetches the
  returned URL with the default Guzzle client and saves it to
  `<default_scheme>://video_thumbnails/<id>.jpg`.
- Unlike the base `downloadJsonData()`, `oEmbedData()` does not cache and does not check the HTTP
  status before indexing `$data[$key]` — a non-200 or malformed response can raise an undefined-key
  warning. This is a robustness quirk, not a security issue.

## Tests

`tests/src/Kernel/ProviderUrlParseTest.php` covers `getIdFromInput()` and `getTimeIndex()` with a
table of URL/expected-id and URL/expected-time cases (including the empty-id and non-numeric-`t`
rejections). No render or thumbnail-fetch test.
