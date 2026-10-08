<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simplenews Stats (simplenews_stats) — agent index

Open- and click-tracking add-on for the Simplenews newsletter module. When a
Simplenews issue is mailed it injects a tracking pixel and rewrites the links in
the body; recipients who open the mail or click a link hit two public routes that
record per-subscriber, per-issue events. Results are stored in two content entity
types and surfaced as an admin collection, a per-node "Stats" tab, and two Views.

- Depends on `simplenews:simplenews` (`drupal/simplenews: ^4.0`). Core `^10 || ^11`.
- No settings form. `configure` route is `entity.simplenews_stats.collection`
  (`/admin/content/simplenews-stats`).
- Defines permissions (7). No Drush commands. No config schema. No plugin *types*
  (it ships Views field/filter plugins only).
- Current release on this branch is `4.0.0-beta3` (no stable exists yet).

## Solution docs
- **Understand the tracking routes, tag scheme, and services** → [api/tracking.md](api/tracking.md)
- **See where stats appear / entity types / storage tables** → [configure/stats.md](configure/stats.md)
- **Grant who can view/administer stats** → [permissions/permissions.md](permissions/permissions.md)
- **How the pixel + links get injected into mail** → [hooks/hooks.md](hooks/hooks.md)
- **The shipped Views and custom Views plugins** → [views/views.md](views/views.md)

## Key facts
- Public routes: `simplenews_stats.hit_view` (`/simplenews-image`, pixel) and
  `simplenews_stats.hit_click` (`/simplenews-c/{tag}`, click receiver + redirect).
  Reporting: `simplenews_stats.stats_tab` (`/node/{node}/simplenews-stats`),
  `entity.simplenews_stats.collection`, `entity.simplenews_stats_item.collection`.
- Services: `simplenews_stats.engine`, `simplenews_stats.allowedlinks`,
  `simplenews_stats.tools`, `simplenews_stats.mail`, `simplenews_stats.symfony_mail`,
  `simplenews_stats.event_subscriber`.
- Entity types: `simplenews_stats` (per-issue totals; id `ssid`; table
  `simplenews_stats`) and `simplenews_stats_item` (one row per event; id `ssiid`;
  table `simplenews_stats_item`). Extra table `simplenews_stats_allowedlinks`.
- Tag scheme handled by the engine: `u{subscriber_id}nl{node_id}`; the pixel adds
  it as the `?sstc=` query param, click links use it as the `{tag}` route arg.
- Permissions: `administer simplenews stats`, `access simplenews stats overview`,
  `create/view/delete simplenews stats`, `access simplenews stats results`,
  `access simplenews stats results editable node`.
