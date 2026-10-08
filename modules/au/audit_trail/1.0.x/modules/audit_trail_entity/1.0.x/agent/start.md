<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Trail Entity events (audit_trail_entity) — agent index

Submodule of [audit_trail](../../../../agent/start.md). Bridges entity CRUD into the chain. Core `^11.3 || ^12`. Depends on `audit_trail`.

## What it does
`AuditTrailEntityHooks` (`src/Hook/AuditTrailEntityHooks.php`) implements `#[Hook('entity_insert'|'entity_update'|'entity_delete')]` and calls `AuditTrail::event('audit_trail_entity', $action, new AuditTrailSubject('entity:<type>/<id>', $entity), …)` when a per-type rule matches. `EntitySnapshotContributor` (`src/Plugin/ContextContributor/EntitySnapshotContributor.php`, plugin id `audit_trail_entity_snapshot`, weight 0) builds the before/after snapshot-delta payload the parent detail-page diff renders, splitting selected fields between the permanent allow-list and the transient bucket.

## Rule resolution (`getEntityRule`)
Config `audit_trail_entity.settings:types` (default `{}`). Per type: `bundles.<bundle>` override, else `bundle_default`; absence of both = not tracked. Each rule: `ops[]` (create/update/delete), `log_programmatic` (default FALSE — see `isUserDriven`, which excludes CLI/cron/anonymous), `skip_no_op_updates` (default FALSE — compares full `toArray()` digests via `EntitySnapshot::getStoredDigest`), `selected_fields[]`, `permanent_fields[]` (default empty = nothing to permanent). `$entity->_audit_trail_skip = TRUE` opts a single op out. Rule field-lists are passed to the contributor via `_audit_trail_entity_*` context keys the orchestrator strips from the row.

## Provides
- Chain: `audit_trail.chain.audit_trail_entity` (claims channel `audit_trail_entity`, wires the snapshot contributor).
- Permission: `administer audit trail entity bridge` (`restrict access: true`).
- Route/form: `audit_trail_entity.settings_form` `/admin/config/system/audit-trail/entity` (`EntityAuditSettingsForm`).
- Config schema: `audit_trail_entity.settings`.

See [agent/config/settings.md](config/settings.md) for the settings shape.
