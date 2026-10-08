Tracks changes to selected fields on selected entity types/bundles, recording the old and new values either to the Drupal logger or as dedicated Entity Log entities.

---

On the config form at `admin/config/entity-log` (permission `administer entity log entities`, `restrict access:
true`) an admin picks which entity types, bundles, and fields to watch, and whether to log to the **logger**
(`log_in_logger`) and/or to **Entity Log entities** (`log_in_entity`), plus a `row_limit` for pruning. All
choices are stored in the `entity_log.configuration` config object. `hook_entity_update()` calls
`EntityLogService`: for each watched field it compares the saved value against `$entity->original`, and when the
imploded old/new strings differ it writes a log line (`Entity type | Bundle | Field | Old | New`) and/or creates
an `entity_log` content entity capturing `old_value`, `new_value`, the logged entity reference (via
`dynamic_entity_reference`), the acting user and client hostname. Entity Log entities are fieldable, have their
own canonical/edit/delete routes and a `/admin/structure/entity_log` collection, publish status, and a granular
permission set. `hook_cron()` prunes the `entity_log` table to the configured `row_limit`. Only simple field
values are diffed (each item's `getString()` joined by commas); it is not a full revision diff.

---

- Keep an audit trail of who changed which field on which entity, and to what value.
- Log changes to the Drupal logger (dblog/syslog) for a lightweight watchdog trail.
- Store field-change history as queryable Entity Log entities instead of/in addition to the log.
- Track only the specific fields you care about (e.g. status, price, assigned user).
- Track changes across arbitrary entity types via dynamic entity reference.
- Record the acting user and client IP/hostname for each logged change.
- Watch changes on selected bundles of a content type only.
- Cap stored log rows with a row limit, pruned automatically on cron.
- Review changes on the `/admin/structure/entity_log` collection page.
- View an individual change record (old value vs new value) on its canonical page.
- Publish/unpublish log entities and gate viewing by published/unpublished permission.
- Build Views reports over Entity Log entities (Views data is provided).
- Add fields to the Entity Log entity itself via Field UI.
- Capture before/after values for compliance or moderation review.
- Detect unexpected edits to sensitive fields (roles, flags, config-like fields).
- Provide a per-field change history without enabling full node/entity revisions.
- Restrict who can create/edit/delete log entities with dedicated permissions.
- Log both to logger and to entities simultaneously when both toggles are on.
- Turn field logging on or off site-wide with the two master toggles.
- Reference the exact source entity of each change through the stored dynamic reference.
