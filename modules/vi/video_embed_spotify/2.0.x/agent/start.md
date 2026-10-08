<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video Embed Spotify (video_embed_spotify) — agent index

A single **provider plugin for Video Embed Field** that recognises `open.spotify.com` URLs and
renders the **Spotify embed iframe player**. No config, no permissions, no schema, no services.
Depends on `video_embed_field` (`^3.0`). Version **2.0.2**, core `^10.3 || ^11`, GPL-2.0-or-later.

## What it actually is
One class: `Drupal\video_embed_spotify\Plugin\video_embed_field\Provider\Spotify` extending
`ProviderPluginBase`. Everything Spotify-specific is: (1) a URL regex, (2) the embed-URL builder,
(3) the iframe attributes, (4) an oEmbed thumbnail lookup. All field UI, formatters, allowed-provider
selection and modal/colorbox behaviour come from Video Embed Field itself.

## Mechanism (read the code, not the README)
- **Recognition regex** (`Spotify::URLREGEXP`, case-insensitive):
  `^https://(open\.spotify\.com/)(embed-podcast/|embed/)?(?<type>album|artist|episode|playlist|show|track|user)/(?<id>[0-9A-Za-z_-]*)(\?.*)?$`
  - Matches **more than the README says**: `album`, `artist`, `episode`, `playlist`, `show`, `track`,
    `user`, plus already-`embed/` and `embed-podcast/` forms. A trailing `?...` query string
    (e.g. `?si=...`) is allowed and ignored.
  - `id` charset is strictly `[0-9A-Za-z_-]` — Spotify base-62 ids plus `_`/`-` (covers `user`
    handles). No quotes, spaces, `<`, `>` or other markup-breaking characters can be captured.
- **`getIdFromInput($input)`** returns the named `id` capture or `FALSE`. Used by the base class both
  for `isApplicable()` (empty id ⇒ plugin not selected) and as the video ID.
- **`buildEmbedUrl()`** re-runs the regex and returns
  `https://open.spotify.com/embed[-podcast]/{type}/{id}` — `-podcast` is inserted only for `episode`
  and `show`. Both `type` (enum) and `id` (strict charset) come straight from the regex captures.
- **`renderEmbedCode()`** returns a `#type => video_embed_iframe` render array with `#url` set to the
  built embed URL and attributes `width`, `height`, `frameborder=0`, `allowfullscreen`,
  `allowtransparency=true`, `allow=encrypted-media` (optional `title`). Video Embed Field's
  `video-embed-iframe.html.twig` renders the `<iframe>` and **auto-escapes** the `src`.
- **Thumbnails**: `getRemoteThumbnailUrl()` overrides the base to call Spotify's oEmbed endpoint
  `https://open.spotify.com/oembed?url={input}` via a raw `file_get_contents()` (with a custom
  User-Agent header) and returns `thumbnail_url`; failures return `""`. `getLocalThumbnailUri()`
  stores it as `{scheme}://video_thumbnails/{id-without-slashes}.jpg`.

## Files
- `src/Plugin/video_embed_field/Provider/Spotify.php` — the whole implementation.
- `video_embed_spotify.module` — only `hook_help()` (renders README).
- `video_embed_spotify.info.yml` — dependency on `video_embed_field`.
- `tests/src/Unit/ProviderUrlParseTest.php` — URL→id parsing cases (canonical URL examples).
- `tests/src/Functional/WidgetTest.php` — widget/field functional test.

## Gotchas
- **Not really video.** Spotify is audio; the common real use is **podcasts**. Treat the field as
  media/audio, and remember audio needs a transcript for accessibility and search.
- **Third-party embed.** The iframe loads from Spotify and can set cookies/report the visit before
  play — put it behind a consent manager like any tracker.
- **`renderEmbedCode()` is the legacy API.** Video Embed Field 3.1 deprecates it in favour of
  `renderEmbed()`; the base still delegates `renderEmbed()` → `renderEmbedCode()`, so this provider
  keeps working, but expect a change before VEF 3.2.
- **oEmbed thumbnail is best-effort** and network-dependent; a failed lookup just yields no remote
  thumbnail.

## Sub-docs
- `providers/spotify.md` — the provider plugin in full (regex table, URL forms, embed-URL rules).
