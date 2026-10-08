<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Log (log) — agent index

Defines a **`log` content entity type** for real-world record keeping — inspections,
deliveries, treatments, activities — NOT PHP/watchdog logging. Logs are fieldable,
revisionable, translatable, owned, and carry a `state_machine` workflow status
(pending → done). Bundles are the **`log_type`** config entity ("log types"). Originates
in the farmOS ecosystem but has no agriculture-specific dependencies.

Dependencies: `entity` (Entity API), `state_machine`, `token`, core `system`/`user`/`views`.
`core_version_requirement: ^11.3` (Drupal 11 only; no Drupal 10).

No global settings form (`configure: null`). Log types are configured at
`/admin/structure/log-type`. No drush commands. No plugin types defined (ships core
Action + Views plugins).

- **Create/configure a log type (bundle)** → [configure/log-types.md](configure/log-types.md)
- **Permissions (per-bundle entity perms + module perms)** → [permissions/permissions.md](permissions/permissions.md)
- **The Log entity: fields, interface, auto-naming, workflow, programmatic create** → [api/entity.md](api/entity.md)
- **Bulk actions: clone / reschedule / mark done / mark pending** → [api/actions.md](api/actions.md)
- **`log_clone` event (alter cloned logs before save)** → [events/log-clone.md](events/log-clone.md)
- **Views integration (data, sort, field, admin view)** → [views/views.md](views/views.md)
- **Theme hook + template + suggestions** → [theme/theme.md](theme/theme.md)

Key facts:
- Entity type id `log`; bundle/config entity id `log_type` (config prefix `log.type.*`).
- Tables: base `log`, data `log_field_data`, revision `log_revision`, revision data `log_field_revision`.
- Entity keys: id `id`, revision `revision_id`, bundle `type`, label `name`, owner `uid`, uuid, langcode.
- Base fields: `name`, `timestamp`, `status` (state), `uid`, `created`, `changed` (+ revision-log + owner fields).
- Access handlers (from `entity` module): `UncacheableEntityAccessControlHandler`,
  `UncacheableEntityPermissionProvider`, `UncacheableQueryAccessHandler`; `permission_granularity: 'bundle'`.
- Admin permission `administer log`; collection permission `access log collection`.
- Module-declared perms: `access log collection`, `administer log types`, `view all log revisions`, `revert all log revisions`.
- Workflow group id `log`; default workflow `log_default` (states `pending`, `done`).
- Routes: `log.autocomplete.name`, `log.log_clone_action_form`, `log.log_schedule_action_form`.
- Services: `log.log_route_context` (context provider). Storage: `Drupal\log\LogStorage` (token name-pattern auto-naming).
- Ships actions: `log_clone_action`, `log_mark_as_done_action`, `log_mark_as_pending_action`, `log_reschedule_action`.
- `log_test` under `tests/modules/` is a test-only support module, not a shipped submodule.
