<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Provider plugins (audio_embed_field)

Providers are `@AudioEmbedProvider`-annotated plugins in `src/Plugin/audio_embed_field/Provider`,
discovered by `ProviderManager` (`audio_embed_field.provider_manager`). Each provider decides
whether it claims a URL (`isApplicable` → `getIdFromInput` returns non-empty), extracts an ID,
renders embed code, and optionally supplies a remote thumbnail URL. Interface:
`Drupal\audio_embed_field\ProviderPluginInterface`; base: `ProviderPluginBase`.

## CustomUrl (`custom_url`)
- **File:** `src/Plugin/audio_embed_field/Provider/CustomUrl.php`
- **Matches:** `getIdFromInput()` returns an extension token only when the input *contains*
  `http://` or `https://` **and** contains one of `.mp3`, `.mp4`, `.m4a`, `.aac`, `.ogg`, `.oga`,
  `.wav` (substring checks, not anchored). Otherwise `NULL` (no match).
- **Embed:** `renderEmbedCode()` returns a `#type => audio_embed_html5` element with
  `#url => getInput()` (the raw URL). Template `audio-embed-html5.html.twig`:
  `<audio ...><source src="{{ url }}"></audio>` — `url` is Twig-autoescaped in the `src` attribute.
- **Thumbnail:** none (`getRemoteThumbnailUrl()` returns `NULL`).
- **No network calls.**

## SoundCloud (`soundcloud`)
- **File:** `src/Plugin/audio_embed_field/Provider/SoundCloud.php`
- **Auth:** `SoundCloudOAuthService` (`audio_embed_field.soundcloud_oauth`) mints an OAuth 2.1
  `client_credentials` token by POSTing `client_id` + `client_secret` to
  `https://api.soundcloud.com/oauth2/token`; the token (+ expiry, 5-min buffer) is stored in
  `state` under `audio_embed_field.soundcloud_token`. Credentials come from config
  `audio_embed_field.settings` (`soundcloud_id`, `soundcloud_secret`).
- **ID resolution:** `getIdFromInput()` (a **static** method) GETs
  `https://api.soundcloud.com/resolve?url=<input>` with `Authorization: OAuth <token>` and reads
  `->id` (numeric). The result is cached in the `default` cache bin for 30 days keyed by
  `md5($input)`. This runs during **field validation** and rendering, so saving a SoundCloud URL
  triggers an outbound API call (host always `api.soundcloud.com`; only the `url` query value is
  user-controlled).
- **Embed:** iframe `https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/<id>`
  with fixed query params (`visual`, `show_user=false`, etc.) plus `auto_play`. `<id>` is the
  numeric API ID interpolated via `sprintf`.
- **Thumbnail:** `getRemoteThumbnailUrl()` GETs `api.soundcloud.com/resolve` again and returns
  `->artwork_url`; `ProviderPluginBase::downloadThumbnail()` saves it to
  `public://audio_thumbnails/<id>.jpg`.
- **TLS:** all requests use the default Guzzle client (certificate verification **on**).

## Writing a new provider
Implement `ProviderPluginInterface` (or extend `ProviderPluginBase`), annotate with
`@AudioEmbedProvider(id=..., title=...)`, place under `Plugin/audio_embed_field/Provider`.
Implement `getIdFromInput()` (claim/parse), `renderEmbedCode()`, and `getRemoteThumbnailUrl()`.
Return a constrained ID (used verbatim in the local thumbnail filename and, for iframe providers,
in the embed URL). To replace a shipped provider, use
`hook_audio_embed_field_provider_info_alter($definitions)` and swap the `class`.
