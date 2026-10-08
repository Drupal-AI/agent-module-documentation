<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Sync (content-sync.io) syndicates content entities (nodes, media, taxonomy terms, menu links, paragraphs, files, etc.) between multiple Drupal sites through a Node.js "Sync Core" backend hosted by content-sync.io. Sites register with the backend and then push/pull entities according to configurable Flows and Pools.

---

The module models syndication with two config entities: a **Pool** (`cms_content_sync_pool`, the shared channel identified by a `backend_url` Sync Core URL, an `authentication_type` and a `site_id`) and a **Flow** (`cms_content_sync_flow`, which entity types/bundles this site pushes or pulls, and to/from which pools). Registration is done at `/admin/config/services/cms_content_sync/site` (route `cms_content_sync.site`) or with `drush cms_content_sync:register`, and the credentials are AES-encrypted at rest using bundled `encrypt`/`real_aes` profiles keyed by a `key.key` entity. Actual serialization of each entity is delegated to pluggable **entity handlers** (`cms_content_sync_entity_handler`) and **field handlers** (`cms_content_sync_field_handler`) — e.g. `DefaultNodeHandler`, `DefaultEntityReferenceHandler` — so references, files, translations, paragraphs and layout data travel correctly. Push/pull can happen automatically on save, manually via the Content Sync dashboards embedded from the backend, or in bulk from the CLI (`cms_content_sync:push`, `cms_content_sync:pull`). Per-entity sync state is tracked in `EntityStatus` records, and the module dispatches events (`BeforeEntityPush`, `AfterEntityPull`, `BeforeEntityTypeExport`, …) so other modules can extend the payload. Eight submodules add views integration, a health dashboard, DraggableViews/Simple Sitemap/Acquia Content Hub support, developer tooling and private-environment polling. It requires an external content-sync.io/Sync Core backend; nothing syncs without one.

---

- Syndicate published articles from an editorial "staging" Drupal site to one or more live "production" sites.
- Push a shared media library (images, documents) from a central site out to many affiliate sites.
- Distribute taxonomy vocabularies and terms consistently across a fleet of Drupal sites.
- Pull curated content from a headquarters site into regional or brand micro-sites.
- Set up a content hub where one site is the source of truth and others subscribe to a Pool.
- Move paragraphs- or Layout Builder-based landing pages between environments with their nested references intact.
- Keep menu links in sync alongside the nodes they point to using the bundled menu-link handler.
- Register a site with the Sync Core backend from CI using `drush cms_content_sync:register`.
- Bulk-push all entities of a Flow after an initial configuration with `drush cms_content_sync:push my_flow`.
- Bulk-pull changed entities from a pool on a schedule with `drush cms_content_sync:pull my_flow --type=pull-changed`.
- Export the Flow/Pool configuration to the Sync Core backend with `drush cms_content_sync:configuration-export`.
- Author a custom entity or field handler to control exactly how a bespoke field type is serialized during sync.
- Extend the sync payload from another module by subscribing to `BeforeEntityPush` / `AfterEntityPull` events.
- Provide a canonical source URL for syndicated nodes via the `[cms_content_sync:source_url]` token.
- Track which entities have been pushed/pulled and their status using the EntityStatus records and Sync Health dashboard.
- Reset stuck sync-status entities after a backend change with `drush cms_content_sync:reset-status-entities`.
- Debug why an entity did or did not sync with `drush cms_content_sync:check-entity-flags <uuid>`.
- Restrict who can administer syndication, view sync status, or publish changes using the module's permissions.
- Build editorial workflows where content is drafted centrally and pulled into brand sites on demand from the Manual Pull dashboard.
- Migrate an existing Acquia Content Hub setup into Content Sync Flows/Pools with the migrate submodule.
- Sync DraggableViews manual ordering weights along with the referenced content.
- Carry Simple Sitemap per-entity settings across sites during sync.
- Expose sync-status entities in Views (state, flags, pool, flow, entity type) with the views submodule.
- Run local/private development environments that the backend cannot reach directly by polling with the private-environment submodule.
- Warn site builders when a Flow's entity-type version is out of date after a field change (developer submodule).
- Present a per-pool site identifier so the same site can participate in several independent syndication channels.
- Encrypt syndication credentials at rest with the bundled real_aes encryption profile and key entity.
