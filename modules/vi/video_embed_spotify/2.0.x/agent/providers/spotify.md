<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Provider plugin: `spotify`

`Drupal\video_embed_spotify\Plugin\video_embed_field\Provider\Spotify`
(`@VideoEmbedProvider(id = "spotify", title = "Spotify")`), extends
`Drupal\video_embed_field\ProviderPluginBase`. This is the module's only class.

## The regex (`Spotify::URLREGEXP`)
Case-insensitive, anchored start-to-end:

```
/^https:\/\/(open\.spotify\.com\/)(embed-podcast\/|embed\/)?(?<type>album|artist|episode|playlist|show|track|user)\/(?<id>[0-9A-Za-z_-]*)(\?.*)?$/i
```

| Part | Meaning |
| --- | --- |
| `https://open.spotify.com/` | Host is fixed; only `https` and this exact host match. |
| `(embed-podcast/\|embed/)?` | Optional — already-embed URLs are also accepted and normalised. |
| `(?<type>album\|artist\|episode\|playlist\|show\|track\|user)` | Enumerated content type. |
| `(?<id>[0-9A-Za-z_-]*)` | Spotify id / user handle; **strict charset** `[0-9A-Za-z_-]`. |
| `(\?.*)?` | Optional trailing query string (e.g. `?si=...`), captured but ignored. |

## Recognised URL forms
Any of these are accepted (with or without a trailing `?...`):

```
https://open.spotify.com/track/1XuxjobTmFFSMS1vWx7pJm
https://open.spotify.com/album/49sy06JJUk1CRwkG9wbRY
https://open.spotify.com/artist/2uFUBdaVGtyMqckSeCl0Q
https://open.spotify.com/playlist/2PXdUld4Ueio2pHcB6sM8j?si=...
https://open.spotify.com/show/6R2ywcv4TDsbFDhMM2e5J
https://open.spotify.com/episode/0zB1BQQGh1Jrqo1FLI4Ce
https://open.spotify.com/user/tao55syilef?si=...
https://open.spotify.com/embed/track/...            (already-embed form)
https://open.spotify.com/embed-podcast/episode/...  (already-embed podcast form)
```

## Methods
- **`getIdFromInput($input)`** (static) — `preg_match` the regex, return `$matches['id']` or `FALSE`.
  The base's `isApplicable()` treats an empty id as "not mine", so a bare `open.spotify.com/track/`
  (no id) is rejected.
- **`buildEmbedUrl()`** — re-matches, then returns
  `https://open.spotify.com/embed` + (`-podcast` if `type` ∈ {`episode`,`show`}) + `/{type}/{id}`.
  Returns `""` if either capture is missing.
- **`renderEmbedCode($width, $height, $autoplay, $title_format = NULL, $use_title_fallback = TRUE)`** —
  builds a `video_embed_iframe` render array:
  ```php
  [
    '#type' => 'video_embed_iframe',
    '#provider' => 'spotify',
    '#url' => $this->buildEmbedUrl(),
    '#attributes' => [
      'width' => $width, 'height' => $height,
      'frameborder' => '0', 'allowfullscreen' => 'allowfullscreen',
      'allowtransparency' => 'true', 'allow' => 'encrypted-media',
    ],
  ]
  ```
  A `title` attribute is added when `getName()` yields one. Note `$autoplay` is **not** used (Spotify
  embeds do not honour it).
- **`getRemoteThumbnailUrl()`** — fetches `https://open.spotify.com/oembed?url={input}` with a raw
  `file_get_contents()` + `stream_context` (custom `User-Agent`), returns `->thumbnail_url`; any
  exception ⇒ `""`.
- **`getLocalThumbnailUri()`** — `{thumbsDirectory}/{str_replace('/', '', getVideoId())}.jpg`.

## Rendering safety
Both interpolated pieces of the `src` are constrained at the source: `type` is one of six literals and
`id` is `[0-9A-Za-z_-]` only, so no attribute-breaking characters (`"`, `'`, `>`, spaces) can reach the
markup. On top of that, Video Embed Field's `video-embed-iframe.html.twig` renders
`src="{{ url }}"` through Twig's auto-escaping. There is no raw-string or `Markup` interpolation of the
URL in this module.
