<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# xntt_views — agent index

Submodule of **[external_entities](../../../../3.0.x/agent/start.md)**. Adds **Views integration** so
external entity types can be used as a Views base table: a dedicated Views query plugin runs the query
against the remote source (via the parent's storage clients), plus field/link/operation handlers.
Core `^10 || ^11`. Depends on `drupal:views` and `external_entities:external_entities`. No settings
page, no permissions (governed by the parent + core Views permissions).

- **Build/understand a View of external entities** → [views/views.md](views/views.md)

Key facts:
- Views query plugin id: `xntt_query` (`Plugin/views/query/ExternalEntityViewsQuery`).
- Field handlers: `external_entity_field`, `rendered_external_entity`, plus link/edit/delete/operations handlers.
- Views data provider: `Plugin/views/data/ExternalEntityViewsData`. Event subscriber `xntt_views.event_subscriber`.
- Config schema: `xntt_views.views.schema.yml`.
