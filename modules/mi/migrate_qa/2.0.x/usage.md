<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A toolkit for validating content migrations: track migrated items, flag problems, and log QA issues.

---

Migrate QA defines several entity types - **Tracker** (revisionable, with generators for content and for migrations), **Issue**, **Connector** (+ connector generator), and **Flag** - each with its own access control handler (`TrackerAccessControlHandler`, `IssueAccessControlHandler`, `FlagAccessControlHandler`, `ConnectorAccessControlHandler`) and a full set of CRUD/administer permissions (the `administer * entity`/`* generator` permissions are `restrict access: true`). Admin routes live under `/admin/structure/migrate-qa/*` (each gated by the matching `administer * entity` permission) with settings controllers/forms per entity; a `/node/{node}/note` route (`TrackerEdit::editForm`) requires both `node.view` entity access and `edit migrate_qa_tracker entity`. A `MigrateSubscriber` reacts to migrate events and `hook_entity_insert()` (`migrate_qa.module`) auto-runs a related tracker migration (`tm_<migration>`) and connector migration when content is created by a migration and a matching generator config exists, limiting execution to the current item's source id. Custom migrate process plugins (`FormattedTextPrepare`, `PregMatchAll`), a `MqaContent` source plugin, Views field plugins and a param converter round it out. Bundled submodules: **migrate_qa_demo_data** (example data; needs `migrate_source_csv`), **migrate_qa_views** (default views; needs `views_bulk_operations`, `views_bulk_edit`), **migrate_qa_views_media** (media views). Internal config entity queries use `accessCheck(FALSE)` appropriately (server-side generator lookups, not user-facing listings); all web routes are permission-gated.

---

- Track every item produced by a content migration for QA review.
- Attach QA notes to individual nodes via `/node/{node}/note`.
- Log and categorise migration issues with the Issue entity.
- Flag problematic migrated content for follow-up.
- Auto-run a per-item tracker/connector migration when migrated content is inserted.
- Generate tracker migrations from content or from existing migration configs.
- Diff tracker revisions to see what changed (via the `diff` module).
- Restrict QA administration with `administer migrate_qa_* entity` permissions (restricted).
- Gate note editing on node view access plus `edit migrate_qa_tracker entity`.
- Use dynamic entity references to relate trackers to any content entity.
- Tag trackers/issues/flags with taxonomy vocabularies shipped as optional config.
- Provide default Views for QA listings via the `migrate_qa_views` submodule.
- Add media-specific QA views via `migrate_qa_views_media`.
- Load example QA data via the `migrate_qa_demo_data` submodule.
- Validate migrated content quality without hand-checking each row.
- Integrate with `migrate_plus`/`migrate_tools` migration workflows.
