<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple oEmbed (soembed) — agent index

One text-format **filter plugin** (`filter_soembed`) that turns a bare oEmbed-supported URL —
on its own line, or optionally inline — into rich media (video iframe, image, or link), by
delegating to Drupal core Media's oEmbed services. No dedicated settings page; the filter is
enabled and tuned inside each text format at `/admin/config/content/formats`. Depends on core
`media`. Core `^9.5 || ^10 || ^11`.

Resolved release: **8.x-2.0-beta14** (the 2.x branch has no stable release; this is the newest).

- **Enable/order the filter on a text format; set max width, inline mode, provider buckets**
  → [configure/filter.md](configure/filter.md)

Key facts:
- Filter plugin id `filter_soembed`, class `Drupal\soembed\Plugin\Filter\SoEmbedFilter`
  (type `TYPE_TRANSFORM_IRREVERSIBLE`).
- Filter settings keys: `soembed_maxwidth` (int, default `0`), `soembed_replace_inline`
  (bool, default `FALSE`), `soembed_allowed_buckets` (sequence of strings, default empty).
- Config schema: `filter_settings.filter_soembed`.
- Optional integration: contrib `oembed_providers` (config entity `oembed_provider_bucket`) to
  scope which providers a format may embed; without it, all providers the core repository lists
  are available.
- Uses core services `media.oembed.provider_repository`, `media.oembed.url_resolver`,
  `media.oembed.resource_fetcher`, `media.oembed.iframe_url_helper`; rich embeds render through
  core route `media.oembed_iframe` (library `media/oembed.formatter`).
- Defines no routes, permissions, own services, hooks, drush commands, blocks, or plugin types.
