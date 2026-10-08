<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# URL To Video Filter (url_to_video_filter) — agent index

One text-format filter, `filter_url_to_video` ("Convert URLs to embedded videos"), that scans body
text for bare YouTube and Vimeo URLs and replaces each with a placeholder `<span>` carrying the
extracted video id. A shipped JS library then swaps the placeholder for a clickable thumbnail (or,
with `autoload`, an `<iframe>` player). It behaves like core's "Convert URLs into links" filter but
produces embeds instead of links. The filter is `TYPE_TRANSFORM_REVERSIBLE` — nothing is stored
changed, so disabling the filter reverts content to the plain URL.

The URL matching/replacement is done by the injectable service `url_to_video_filter.service`
(`UrlToVideoFilterService`, interface `UrlToVideoFilterServiceInterface`); the filter plugin only
wires settings and attaches libraries. There is no settings page/route, no permissions, no Drush, no
hooks, and no custom plugin types — configuration is entirely per text format (this 3.0.x branch
supports YouTube and Vimeo only; the plugin-based provider architecture and Twitter/X support arrive
in 4.x).

- Depends on: nothing (info.yml `dependencies` empty; core `filter` provides the base class).
- Core: `^10 || ~11`. Package: none declared (info.yml has no `package`).
- No `configure` route. Provides config schema (`filter_settings.filter_url_to_video`). No
  permissions, no Drush commands, no custom plugin types, no submodules.
- Composer/package name: `drupal/url_to_video_filter` (no `composer.json` ships in the module).

## What you'd do → where

- **Enable the filter on a text format, pick providers, order it vs. other filters** →
  [configure/text-format.md](configure/text-format.md)
- **Call the URL→embed conversion from PHP / understand the transform & placeholder markup** →
  [api/service.md](api/service.md)

## Key facts (real machine names)

- Filter plugin: `#[Filter(id: "filter_url_to_video", type: FilterInterface::TYPE_TRANSFORM_REVERSIBLE)]`
  → `Drupal\url_to_video_filter\Plugin\Filter\FilterUrlToVideo`.
- Service: `url_to_video_filter.service` (autowired), aliased to interface
  `Drupal\url_to_video_filter\Service\UrlToVideoFilterServiceInterface`
  (`convertYouTubeUrls($text)`, `convertVimeoUrls($text)` → `['text' => …, 'url_found' => bool]`).
- Filter settings keys (config schema `filter_settings.filter_url_to_video`): `youtube`, `vimeo`,
  `youtube_webp_preview`, `autoload` — **all default to FALSE** (the `#[Filter(settings: …)]`
  attribute, which is what `process()` reads via `settings.youtube` / `settings.vimeo`). The
  plugin's `defaultConfiguration()` also sets top-level `youtube`/`vimeo` to TRUE, but at the wrong
  nesting level (top-level, not under `settings`), so it has no effect — you must explicitly enable
  a provider or the filter transforms nothing.
- Libraries (`url_to_video_filter.libraries.yml`): `player_embed` (CSS `css/url_to_video_embed.css`,
  with `.scss` source + `.css.map`), `youtube_embed` (`js/youtube_embed.js`), `vimeo_embed`
  (`js/vimeo_embed.js`); JS libs depend on core/drupal, jquery, drupalSettings, once. `process()`
  attaches only the libraries for providers that actually matched, plus
  `drupalSettings.urlToVideoFilter` (`youtubeWebp`, `autoload`).
- Placeholder markup emitted server-side: `<span class="url-to-video-container {youtube|vimeo}-container no-js"><span class="{youtube|vimeo}-player url-to-video-player loader" data-{youtube|vimeo}-id="…"></span></span>`.
- Assets: `images/no-js.png`, `images/play-button.png`, `images/ajax-loader.gif`.
