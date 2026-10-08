<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Juicer — agent index

**Embeds Juicer.io social-media feeds** (aggregated social posts) into Drupal. Version **1.4.0**. Core
`^10.3||^11||^12`.

Social-media/integration — loads content/assets from the **external Juicer.io service** (third-party embed/JS/
cookies — trust the provider); public feed content; no access role.

## Mechanism

- One block plugin `juicer_block` (category "Social Media"). Config: `feed_name` (Juicer slug, required),
  `posts_per_page`, `source_filter`, `subtitle`, `title_tag` (h1–h6). No permissions, no routes, no services
  beyond the hook object.
- The block renders a placeholder `<section class="juicer-drupal-feed" data-feed-id=… data-per=… data-source=…>`
  (Twig-autoescaped) and attaches `juicer/juicer_embed`.
- `js/juicer-feed.js` fetches feed HTML client-side from `https://www.juicer.io/api/feeds/<slug>.html?origin=…`
  and inserts it into the block; it resolves and loads Juicer's digested `embed_juicer20.css/js` bundle, then
  mounts Juicer's feed components (vanilla `JuicerFeedComponents` runtime, or Alpine on older bundles). Load-More
  / infinite-scroll pagination is driven by the module with its own `fetch()` when the fetch-engine markup is
  absent.
- The block form validates the slug server-side with a Guzzle GET to `https://www.juicer.io/api/feeds/<slug>`
  (host fixed to juicer.io, slug urlencoded, 5s timeout); on any error validation is skipped and a warning
  logged.
- No API key or credential — the feed slug is public.

## Diff 1.3.x → 1.4.x

- **Origin identifier bumped**: the loader URL and the feed request's `origin=` parameter now carry
  `drupal-plugin-1-4` (major.minor, matching the WordPress plugin's scheme) instead of the generic embed
  origin. Juicer records the origin per embedding site. No change to how the feed renders.
- **New request headers**: feed requests (initial fetch and paginated fetches) now send `X-Juicer-Embed: true`
  and `X-Juicer-Referrer: <current page URL>` — the same headers Juicer's own embed sends — so Juicer's
  per-site page tracking works even when the site's Referrer-Policy trims the Referer header.
- No config-schema, block-form, or PHP-behavior changes beyond these; block build, validation, and templates
  are unchanged from 1.3.x.
