<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bridges entity create / update / delete events into the tamper-evident audit trail, with per-entity-type and per-bundle opt-in, per-operation selection, and field-level snapshot filtering.

---

`audit_trail_entity` subscribes to `hook_entity_insert` / `_update` / `_delete` and records each tracked change as a chained audit-trail row on channel `audit_trail_entity` (resource `entity:<type>/<id>`). Tracking is opt-in per entity type in `audit_trail_entity.settings:types`, with an optional per-bundle cascade (`bundle_default` plus per-bundle overrides), a selectable operation set (`create`/`update`/`delete`), a `log_programmatic` toggle (default off — only HTTP-driven authenticated actions, so drush/cron/migrate/queue changes are excluded unless enabled), an optional skip-no-op-updates rule, and a per-rule field selection split into a purgeable transient snapshot and an operator-attested permanent allow-list. The `EntitySnapshotContributor` plugin builds the before/after snapshot-delta the parent module's detail page renders as a field-by-field diff. The base `audit_trail` module provides the HMAC chain and verifier. Requires `audit_trail`.

---

- Log every node create/update/delete into a tamper-evident chain for compliance.
- Track only specific content types by adding them to `types` with a per-bundle rule.
- Choose which operations are audited per bundle (e.g. deletes only).
- Restrict the recorded snapshot to selected fields, not the whole entity.
- Attest a PII-free subset of fields to the permanent (never-purged) retention tier.
- Exclude programmatic/CLI changes by leaving `log_programmatic` off (default).
- Suppress no-op re-saves (content_moderation/scheduler churn) with `skip_no_op_updates`.
- Opt an individual operation out at runtime with `$entity->_audit_trail_skip = TRUE` in a batch/migration.
- Get a side-by-side before/after diff of changed fields on the entry detail page.
- Audit config/other entity types, not just content, via their type id.
- Combine with `audit_trail_entity_paragraphs` to trace paragraph edits to their host entity.
- Keep entity audit rows in their own filterable channel separate from operational logs.
- Configure it all at Configuration → System → Audit Trail → Entity events.
- Feed a defensible change history for regulated records without touching the tracked modules' code.
- Distinguish create vs update vs delete by the row's `action` column.
