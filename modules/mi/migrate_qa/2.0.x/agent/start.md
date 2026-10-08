<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate QA - agent index

QA tooling for migrations: Tracker / Issue / Connector / Flag entities + generators, per-node QA notes,
and event-driven auto-run of tracker/connector migrations. Deps: `diff`, `field`, `migrate`, `taxonomy`,
`dynamic_entity_reference`, `migrate_plus`, `migrate_tools`.

Access:
- Per-entity access handlers (`TrackerAccessControlHandler`, `Issue*`, `Flag*`, `Connector*`).
- Admin routes `/admin/structure/migrate-qa/*` gated by `administer <entity> entity` (restricted).
- `/node/{node}/note` (`TrackerEdit`) requires `node.view` + `edit migrate_qa_tracker entity`.

Automation: `migrate_qa.module` `hook_entity_insert()` + `MigrateSubscriber` run `tm_<migration>` /
connector migrations for migrated items when a generator config matches. Internal config queries use
`accessCheck(FALSE)` (server-side lookups, not user listings).

Submodules: `migrate_qa_demo_data`, `migrate_qa_views`, `migrate_qa_views_media`. Version dir `2.0.x`.
