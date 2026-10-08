<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — the Youku provider plugin

`src/Plugin/video_embed_field/Provider/Youku.php`, plugin id `youku`, extends
`video_embed_field\ProviderPluginBase`. This is an *implementation* of Video Embed Field's provider
plugin type (the module defines no plugin type of its own). Injected: `config.factory`, `cache.default`,
`logger.factory`, `messenger`, `http_client` (Guzzle).

## URL → video id — `getIdFromInput($input)` (static)
- Returns `FALSE` for empty/non-string input.
- `parse_url($input)`; requires a `path`; splits on `/`; finds the segment containing `id_`, strips
  `id_` and `.html`.
- Accepts the id **only if** `preg_match('/^[a-zA-Z0-9]+$/', $id)` — otherwise `FALSE`. This is what
  Video Embed Field uses to decide the provider matches and to validate the field value.

## Embed markup — `renderEmbedCode($width, $height, $autoplay)`
- If no valid id: returns a `div.video-embed-error` with "Invalid Youku video ID."
- Otherwise returns `#type => html_tag`, `#tag => iframe` with `width`, `height`, `frameborder=0`,
  `allowfullscreen`, and
  `src = sprintf('https://player.youku.com/embed/%s?autoplay=%d', $video_id, $autoplay)`.
- The id is alphanumeric-validated and the URL is placed in a render-array attribute (auto-escaped on
  render), so there is no HTML/attribute injection vector from the pasted URL.

## Remote metadata — `oEmbedData()` (protected, cached)
- Reads `api_client_id` + `api_cache_duration` from `video_embed_youku.settings`.
- No client id → warning (log + messenger) and NULL.
- Cache hit on `video_embed_youku:<id>` returns cached object; otherwise GETs
  `https://api.youku.com/videos/show.json?client_id=<id>&video_id=<id>` (timeout 10s, custom UA),
  `json_decode`s the body, caches it (`time()+duration`, tag `video_embed_youku`).
- `RequestException` / generic exceptions are caught and logged (error message shown to editor on
  request failure). Host is the fixed `api.youku.com` — not user-controllable (no SSRF surface).
- Consumers: `getName()` (title, default "Youku Video"), `getDescription()`, `getRemoteThumbnailUrl()`
  (`bigThumbnail`).

## Services file note
`video_embed_youku.services.yml` declares a `settings_form` service with args
`['@config.factory','@logger.factory','@messenger']`, but `SettingsForm` is a plain `ConfigFormBase`
resolved by route `_form` — the service entry is unused by normal operation.
