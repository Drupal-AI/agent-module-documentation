<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cision (cision) — agent index

Integrates the **Cision (TrendKite) Communications Cloud API** (`https://api.trendkite.com/api`) and
renders the media mentions of a saved Cision search as a card block. Version **1.0.7**, core `^10 || ^11`,
package *Web services*.

## Dependencies
- Modules: `image`, `media`, `key`, `imagecache_external`.
- Composer: `embed/embed:^4.4` (used to discover thumbnails for mention URLs).
- Credentials are stored as two Key entities: `cision_username`, `cision_password` (shipped in
  `config/install`, empty by default, `key_provider: config`).

## What it provides
- **Service** `cision.api` → `Drupal\cision\Api` (final). Methods: `getTotalMentions()`, `getSearches()`,
  `getSearchesOptions()`, `getStats()`. Injects `http_client`, `state`, `key.repository`,
  `date.formatter`, `cache.default`. Caches responses 1h; caches a Cision auth token in state for 240s.
- **Block** `cision_cision_total_mentions` → `Drupal\cision\Plugin\Block\CisionTotalMentionsBlock`
  (attribute-defined, category "Cision"). Fetches mentions for a search + date range, enriches each with a
  thumbnail via `embed/embed`, themes them with `cision_item_list`.
- **Config form** `Drupal\cision\Form\CisionSettingsForm` at route `cision.cision_settings`
  (`/admin/config/services/cision`), stores `cision.settings:placeholder_image_id` (a Media id).
- **Theme hook** `cision_item_list` (`cision.module`) + template `templates/cision-item-list.html.twig`
  + CSS library `cision/cision`.
- Config schema: `block.settings.cision_cision_total_mentions`. No permissions, no entities, no drush,
  no plugin types.

## Routes & access
- `cision.cision_settings` — `_permission: 'administer site configuration'` (only route; admin-only).

## Solution docs
- [agent/api/service.md](api/service.md) — the `cision.api` service, endpoints, auth, caching.
- [agent/plugins/total-mentions-block.md](plugins/total-mentions-block.md) — the block, its config, and rendering.
- [agent/config/settings.md](config/settings.md) — settings form, Key entities, install/enable.
