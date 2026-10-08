<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video Embed Rutube (video_embed_rutube) — agent index

Adds **Rutube** as a provider plugin for **Video Embed Field**. Requires `video_embed_field:^3`.
Version **3.0.1**. Core requirement `^10.3 || ^11`. License GPL-2.0-or-later.

A thin adapter: URL recognition, embed iframe, oEmbed thumbnail. Everything else — field type,
formatters, WYSIWYG integration, Media source — comes from the parent module. The entire module is
one class.

## What it is

- Single plugin: `src/Plugin/video_embed_field/Provider/Rutube.php`, a `@VideoEmbedProvider`
  (id `rutube`, title "Rutube") extending `video_embed_field`'s `ProviderPluginBase`.
- No config, no schema, no permissions, no routes, no services, no submodules, no Drush.
- **It does not define a plugin type** — it registers one *instance* of Video Embed Field's
  existing `VideoEmbedProvider` plugin type.

## Mechanism (real behaviour)

- **URL parsing** — `getIdFromInput()` runs `preg_match('/https?:\/\/(www\.)?rutube.ru\/(video|shorts)\/(?<id>[a-z0-9]*)(.*?)/', ...)`.
  Matches `rutube.ru/video/<id>` and `rutube.ru/shorts/<id>`, with optional `www.`. The id is a
  Rutube hex hash constrained to `[a-z0-9]`. Empty id → `isApplicable()` returns FALSE (URL rejected).
- **Embed** — `renderEmbedCode()` returns a `video_embed_iframe` render element with
  `#url = https://rutube.ru/play/embed/<id>`. Attributes: formatter `width`/`height`,
  `frameborder=0`, the fullscreen trio, and `allow` = `clipboard-write` (plus `autoplay` when the
  formatter's autoplay option is on). If the source URL had `t=<digits>`, a `?t=` start offset is
  added as `#query['t']`.
- **Time index** — `getTimeIndex()` matches `t=(?<time_index>\d+)` (digits only).
- **Thumbnail** — `getRemoteThumbnailUrl()` → `oEmbedData('thumbnail_url')`, which GETs
  `https://rutube.ru/api/oembed/?url=https://rutube.ru/video/<id>/&format=json` and returns the
  `thumbnail_url` field. The parent `ProviderPluginBase::downloadThumbnail()` then downloads that
  poster and caches it locally at `<default_scheme>://video_thumbnails/<id>.jpg`.

## Sub-docs

- [providers/rutube-provider.md](providers/rutube-provider.md) — the provider plugin in detail:
  method contract, the render element / Twig template it feeds, and the oEmbed thumbnail path.

## When recommending it, always state

1. **Third-party video embeds are a consent question.** The Rutube player sets cookies and reports
   the view to its host — put it behind the site's consent manager as you would an analytics script.
2. **Provider plugins are fragile.** If Rutube changes its embed-URL format or oEmbed endpoint the
   plugin breaks until updated. Check the release date against Rutube's current behaviour.
