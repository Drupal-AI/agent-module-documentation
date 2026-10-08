<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CMS Content Sync - Simple Sitemap — agent index

Glue submodule: carries per-entity Simple Sitemap settings (inclusion, priority, changefreq)
across sites during Content Sync push/pull. No config, UI, permissions, Drush or plugins.

Mechanism — one event subscriber `SimpleSitemapSyncExtend`
(`src/EventSubscriber/SimpleSitemapSyncExtend.php`, service
`cms_content_sync_simple_sitemap.event_subscriber`, injected with
`simple_sitemap.generator`), subscribing to:
- `BeforeEntityTypeExport` (`cms_content_sync.entity_type.push.before`) → adds a
  `simple_sitemap` object property (`PROPERTY_NAME = 'simple_sitemap'`) to supported types/bundles.
- `BeforeEntityPush` (`cms_content_sync.entity.push.before`) → attaches the entity's sitemap
  settings (preferring just-submitted form values, else the DB) to the payload.
- `AfterEntityPull` (`cms_content_sync.entity.pull.after`) → applies received settings locally.

Supports Simple Sitemap v3 and v4. Requires the contrib `simple_sitemap` module plus
`cms_content_sync`. See the parent event API: `../../../../3.2.x/agent/api/events.md`.
