<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# audit_trail_entity settings

Config object `audit_trail_entity.settings` (install default: `types: {}`), form `EntityAuditSettingsForm` at `/admin/config/system/audit-trail/entity` (permission `administer audit trail entity bridge`). Schema `config/schema/audit_trail_entity.schema.yml`.

## Structure
```
types:
  <entity_type_id>:
    bundle_default:            # shared cascade rule (optional)
      ops: [create, update, delete]
      log_programmatic: false
      skip_no_op_updates: false
      selected_fields: []      # empty = all scalar fields minus a fixed noise list
      permanent_fields: []     # opt-in subset kept in the never-purged permanent tier
    bundles:
      <bundle>:                # per-bundle override (optional); same shape as bundle_default
        ops: [...]
        ...
```
Resolution (`AuditTrailEntityHooks::getEntityRule`): the entity's specific bundle rule wins; otherwise `bundle_default`; if neither exists the type is not tracked. An op not in `ops` is skipped.

## Key behaviours
- **`log_programmatic` (default false)**: only user-driven HTTP requests are audited. `isUserDriven()` returns false for no live request (CLI/queue), anonymous users, and cron routes (`system.cron`, `cron`, `ultimate_cron.run_job`, or any route with `_cron: TRUE`).
- **`skip_no_op_updates` (default false)**: skips an update row when the full pre/post entity digest is byte-identical (ignoring auto-bumped fields `changed`, `revision_*`, the revision key). Field selection does not affect this "did a save happen" check.
- **`selected_fields`**: scope of the recorded snapshot (empty = all scalar fields minus the default noise list).
- **`permanent_fields`**: fields the operator attests as PII-free; their values go to `context_permanent` (long retention). Everything else snapshotted goes to `context_transient` (purgeable). Default empty = nothing to permanent.
- **`$entity->_audit_trail_skip = TRUE`**: runtime per-operation opt-out (batches, migrations).

Snapshots use `EntitySnapshot` (`src/Snapshot/EntitySnapshot.php`) + `SnapshotDelta::computeStateWithDelta()`; updates diff `$entity->getOriginal()`.
