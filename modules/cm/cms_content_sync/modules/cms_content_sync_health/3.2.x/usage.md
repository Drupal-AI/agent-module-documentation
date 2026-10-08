<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a "Sync Health" admin dashboard to Content Sync that surfaces per-entity syndication status and flow version mismatches, so site owners can see at a glance what has and hasn't synced.

---

This submodule builds a reporting UI on top of Content Sync's `EntityStatus` records. It registers routes under `/admin/content/sync-health`: an overview (`SyncHealth::overview`) and a version-mismatches aggregate (`VersionMismatches::aggregate` at `/admin/content/sync-health/pushing/version-mismatches`), plus an "Entity Status" tab backed by a bundled View, `content_sync_entity_status`. Access is gated by a single permission it defines, `access sync health`. It depends on the `cms_content_sync_views` submodule (for the views integration over the `cms_content_sync_entity_status` entity), `dynamic_entity_reference` and core `views`. The dashboard is presented through three Twig templates (overview, push, pull). It has no configuration form, no Drush commands and no plugins of its own — it is a read-only reporting layer over data the parent module already tracks.

---

- See which entities have been pushed or pulled and which are pending or failed.
- Give site owners a single Sync Health dashboard at /admin/content/sync-health.
- Spot flows whose entity-type version no longer matches the backend (version mismatches).
- Audit syndication status across all content from one screen.
- Provide editors a read-only view of per-entity sync state without admin access to Content Sync config.
- Grant a support role just `access sync health` to monitor syndication without full admin.
- Review the Entity Status view to filter synced entities by state, pool or flow.
- Diagnose why content is out of sync by inspecting the health overview.
- Track pushing vs pulling health separately via the dedicated templates.
- Aggregate version mismatches so site builders know which flows to re-export.
- Support operations teams monitoring a multi-site content hub's sync health.
- Surface stuck or errored EntityStatus records for follow-up.
- Combine with the developer submodule to detect and then resolve version drift.
- Offer a management-friendly reporting page separate from the technical Content Sync config UI.
- Confirm that a recent bulk push completed by checking the overview counts.
- Give QA a place to verify syndication before a release.
- Monitor entity syndication coverage as part of routine site health checks.
- Provide a permission-gated dashboard so only authorized users see sync internals.
