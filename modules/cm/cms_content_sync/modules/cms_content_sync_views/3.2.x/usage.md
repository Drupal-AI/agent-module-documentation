<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a Views integration for Content Sync's per-entity sync-status (`EntityStatus`) records, adding Views fields, filters and bulk-operation actions so you can build listings of what has synced, filtered by state, flags, pool, flow or entity type.

---

Content Sync tracks each syndicated entity in a `cms_content_sync_entity_status` content entity. Because those records reference many different entity types in one table, this submodule requires `dynamic_entity_reference` (DER): it adds a DER base field on the status entity (`hook_entity_base_field_info` plus `entity_create/insert/update` hooks that populate the reference) so Views can join to the referenced entity. It then registers Views **field** plugins (`SyncState`, `PoolLabel`, `FlowLabel`, `EntityTypeLabel`, `ParentEntity`, `RenderedFlags`) and Views **filter** plugins (`SyncState`, `EntityType`, `Flags`, `Flow`, `Pool`) via `hook_views_data_alter`, plus two Twig templates for rendering sync state and flags. It also installs three VBO-style `system.action` config entities against the status entity — `export_status_entity` (label "Force Push"), `import_status_entity` and `reset_status_entity` (backed by the `PushStatusEntity`, `PullStatusEntity`, `ResetStatusEntity` action plugins) — so a status View can offer force-push / pull / reset as bulk operations. It is a hard dependency of the `cms_content_sync_health` submodule. No config form, permissions, Drush or plugin types of its own.

---

- Build a Views listing of every entity's Content Sync status.
- Filter a sync-status View by sync state (e.g. pushed, pulled, failed).
- Filter synced entities by their flags (source entity, push enabled, deleted, …).
- Filter a status View by the pool the entity belongs to.
- Filter a status View by the flow that governs the entity.
- Filter sync-status records by referenced entity type.
- Show the human-readable pool label in a Views column.
- Show the flow label for each synced entity in a View.
- Render the entity-type label for mixed-entity status listings.
- Display the parent/referenced entity via the dynamic entity reference.
- Render the sync-state and flags with the bundled Twig templates.
- Offer a "Force Push" bulk action on a status View (export_status_entity action).
- Offer an import/pull bulk action on selected status rows (import_status_entity).
- Offer a reset bulk action to clear a status record (reset_status_entity).
- Power the Sync Health submodule's Entity Status view.
- Create a custom admin report of failed syndications for follow-up.
- Give editors a filterable dashboard of what content is in sync.
- Join sync-status records to their referenced entities via dynamic entity reference.
- Export a CSV of sync status using Views' data export with these fields.
- Build per-pool or per-flow sync monitoring views for operations teams.
