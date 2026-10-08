<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookies Addons Embed Video — the "Block YouTube videos" filter

## Enable

`drush en cookies_addons_embed_video`. Requires the COOKiES Video submodule (`cookies_video`), which
provides the placeholder library and its own YouTube cookies service. Then edit a text format and
enable **Block YouTube videos**.

## Filter plugin

`CookiesAddonsEmbedVideoFilter` (`src/Plugin/Filter/CookiesAddonsEmbedVideoFilter.php`):

- Annotation: id `cookies_addons_embed_video_filter`, title "Block YouTube videos", `type =
  Drupal\filter\Plugin\FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE`. Constant `EXTRA_CLASS =
  'cookies-video-embed-field'`.
- `process($text, $langcode)`: `Html::load($text)`; iterate `<iframe>` elements in reverse. For each
  with a non-empty `src` where `_cookies_addons_embed_video_is_youtube($src)` is TRUE: append
  `EXTRA_CLASS` to `class`, set `src=''`, set `data-src=<orig>`. If any matched,
  `setAttachments(['library' => 'cookies_video/cookies_video_embed_field'])` — i.e. it reuses the
  COOKiES Video module's embed-field library rather than shipping its own JS. Returns
  `Html::serialize($html_dom)`.
- `tips()`: "Converts Youtube embed to be cookies restricted."

## Match helper

`_cookies_addons_embed_video_is_youtube($src)` (`cookies_addons_embed_video.module`) runs
`preg_match_all()` on `htmlspecialchars_decode($src)` with a YouTube URL pattern (youtu.be /
youtube(-nocookie).com, 11-char video id, excluding `videoseries`) and returns
`isset($matches[0][0])`.

## Install / update

`cookies_addons_embed_video.install` → `cookies_addons_embed_video_update_8001()`: loads all
`filter.format.*` config; where a format still references the mistyped filter key
`cookies_addons_embed_viedeo_filter`, it copies the settings under the corrected key
`cookies_addons_embed_video_filter`, sets the internal `id`, unsets the old key, saves, and logs/messages
the change.

## Notes

- No filter settings (schema mapping is empty). The placeholder and consent restore are handled by
  COOKiES Video's `cookies_video_embed_field` library, keyed on the video cookies service.
- Together with `cookies_addons_embed_iframe` (non-YouTube iframes) this covers all iframe embeds in
  formatted text.
