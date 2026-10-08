<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video Embed TikTok (video_embed_tiktok) — agent index

A single **provider plugin** for the **`video_embed_field`** module that adds **TikTok** as an
embeddable video source. Package `Video Embed Field`. Depends on `drupal/video_embed_field:^3`.
Core requirement `^10.3 || ^11`. License GPL-2.0-or-later. Version 3.0.x (packaged `3.0.0-beta1`).

- **Install/enable, the exact URL patterns matched, the iframe markup, thumbnails, and how to use it** →
  [providers/tiktok.md](providers/tiktok.md)

## What it actually is

- **One plugin:** class `TikTok` in `src/Plugin/video_embed_field/Provider/Tiktok.php`, annotated
  `@VideoEmbedProvider( id = "tiktok", title = @Translation("TikTok") )`, extending
  `Drupal\video_embed_field\ProviderPluginBase`. That is the module's entire code — no `.module`
  file, no forms, no permissions, no Drush, no config schema, no services.
- Video Embed Field auto-discovers the plugin (annotation-based plugin manager). It appears in the
  **Allowed providers** list on any *video embed field*; the module has no settings route of its own
  (`configure` is null).

## Mechanism (from source)

- **`getIdFromInput($input)`** — the matcher Video Embed Field uses to decide whether this provider
  handles a pasted URL. It runs:
  `preg_match('/https?:\/\/(www\.)?tiktok.com\/(?<user_id>@[\S]*)\/video\/(?<id>[0-9]*)\/?/', $input, $matches)`
  and returns `$matches['id']` (falls through to `NULL` on no match). The captured **id group is
  `[0-9]*` — digits only** (e.g. `6718335390845095173`). `http`/`https`, optional `www.`, a trailing
  slash and a query string (`?taken-by=…`) are all accepted; the unit test
  `tests/src/Unit/ProviderUrlParseTest.php` pins these five URL forms.
- **`renderEmbedCode($width, $height, $autoplay, $title_format = NULL, $use_title_fallback = TRUE)`**
  returns a render array `#type => 'video_embed_iframe'`, `#provider => 'tiktok'`,
  `#url => sprintf('https://www.tiktok.com/embed/%s', $this->getVideoId())`, with `#attributes`
  `width`, `height`, `frameborder => '0'`, `allowfullscreen => 'allowfullscreen'`. When
  `getName($title_format, $use_title_fallback)` resolves a title it is added as the iframe `title`
  attribute (accessibility, new in Video Embed Field 3.0.x). Note the `$autoplay` argument is
  accepted but not used.
- **`oembedData()`** lazily fetches
  `file_get_contents('https://www.tiktok.com/oembed?url=' . $this->getInput())` and `json_decode`s it
  (associative). **`getRemoteThumbnailUrl()`** returns that payload's `thumbnail_url`, which Video
  Embed Field imports as the field's thumbnail. The host fetched is always `www.tiktok.com`.

## Notes

- `getVideoId()` (from `ProviderPluginBase`) re-runs `getIdFromInput()` on the stored input, so the
  embed `#url` always contains the digits-only id, never arbitrary URL text.
- Minor: `oembedData()` guards on `!isset($this->oembedData)` (lowercase *e*) but assigns
  `$this->oEmbedData` (the declared property) — the property names differ, so the cache guard never
  hits and the oEmbed request is re-issued on each call. Behavioural quirk, not a correctness bug for
  callers.
