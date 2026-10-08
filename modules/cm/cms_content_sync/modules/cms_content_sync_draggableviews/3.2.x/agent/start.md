<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CMS Content Sync - DraggableViews — agent index

Glue submodule: carries DraggableViews manual-ordering weights across sites during Content
Sync push/pull. No config, UI, permissions, Drush or plugins.

Mechanism — one event subscriber `DraggableViewsSyncExtend`
(`src/EventSubscriber/DraggableViewsSyncExtend.php`, service
`cms_content_sync_draggableviews.event_subscriber`), subscribing to:
- `BeforeEntityTypeExport` (`cms_content_sync.entity_type.push.before`) → adds a
  `draggableviews` object property (`PROPERTY_NAME = 'draggableviews'`) to supported types.
- `BeforeEntityPush` (`cms_content_sync.entity.push.before`) → reads weight rows from the
  `draggableviews_structure` DB table and attaches them to the push payload.
- `AfterEntityPull` (`cms_content_sync.entity.pull.after`) → writes received weights back
  into the local `draggableviews_structure` table.

Requires the contrib `draggableviews` module plus `cms_content_sync`. See the parent event
API: `../../../../3.2.x/agent/api/events.md`.
