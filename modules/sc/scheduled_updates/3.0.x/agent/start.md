<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scheduled Updates (scheduled_updates) — agent index

Sets **field values on entities at a future time** — any field, any entity type (nodes, users,
terms, files), not just node publishing. Version **3.0.2**. Depends on core `options` and
**`inline_entity_form`** (`drupal/inline_entity_form:^3`). Core requirement
`^10.4 || ^11.3 || ^12`. Configure at **Configuration → Workflow → Scheduled Updates**
(`scheduled_update.config.overview`, `/admin/config/workflow/scheduled-update-type`).

## Mechanism in one screen

Two entity types work together:

- **`scheduled_update_type`** — a **config entity that is also the bundle** for updates. It targets
  exactly one entity type (`update_entity_type`), holds a **`field_map`** (fields on the update →
  fields on the target), declares `update_types_supported` (`embedded` and/or `independent`), and
  configures one **Update Runner** plugin (`update_runner`). See `entities/`.
- **`scheduled_update`** — a **content entity** of that bundle. Base fields: `update_timestamp`
  (when to fire, and the entity label), `status` (Un-run / In Queue / Re-queued / Successful /
  Un-successful / Inactive), `entity_ids` (targets, for independent updates), `user_id` (creator),
  plus whatever mapped source fields the type added. See `entities/`.

**Runner flow** (`plugins/`): `hook_cron` → `UpdateRunnerUtils::runAllUpdates([], TRUE)`. For each
type, `BaseUpdateRunner::addUpdatesToQueue()` finds ready updates (`update_timestamp <= now`,
`status IN (Un-run, Re-queued)`), queues them; `runUpdatesInQueue()` loads each target,
`transferFieldValues()` copies the mapped values, `$entity->validate()` then `$entity->save()`.
Also runnable manually via the runner form (`/admin/config/workflow/schedule-updates/run`) or
Drush `sup:run_updates` (`sup:run`) / `sup:list_runners` (`sup:list`).

**Two families:**
- **Embedded** (`default_embedded`, `latest_revision`): the update is referenced from an
  entity-reference field placed on the target's own add/edit form via Inline Entity Form. Runner
  scans those reference fields. Attaching an update = editing the target, so it inherits the
  target's edit access.
- **Independent** (`default_independent`): created through its own add form
  (`/admin/content/scheduled-update/add`); the editor selects target entities by autocomplete and
  one update can hit many entities.

**Run-as user** (runner setting `update_user`): `USER_UPDATE_RUNNER`, `USER_OWNER`,
`USER_REVISION_OWNER`, `USER_UPDATE_OWNER`. **Under cron the runner switches to user 1** for the
UpdateRunner/UpdateOwner options (`AccountSwitcher`). The write itself is **not** gated by the
target entity's edit/field access (`plugins/` covers this).

## Key facts / gotchas

- **Cron is the timing constraint.** An update fires when cron runs, not at the configured instant.
  Hourly cron cannot honour a nine-o'clock embargo to the minute; fix cron frequency first.
- **Broader than `scheduler`** (which handles node publish/unpublish only). Use this when the thing
  changing is a price, a flag, a user field, or a term field.
- **`^11.3`** excludes earlier 11.x; **`^12`** reaches into a core major that does not exist yet.
- `latest_revision` runner is for revisionable/forward-revisioned content (e.g. Workbench/Content
  Moderation) and errors on non-revisionable types.
- Deleting a type purges its cloned source-field storage (`ScheduledUpdateType::postDelete`);
  uninstall drops the `scheduled_update` table.

## Permissions (`permissions/`)

Static: `administer scheduled update types`, `administer scheduled updates`,
`view scheduled update entities`. Plus **dynamic per-type** permissions from
`Permissions::scheduledUpdateTypesPermissions` (`permission_callbacks`):
`create/edit own/edit any/delete own/delete any <type_id> scheduled updates`.

## Subdirectories

- `entities/` — the `scheduled_update` and `scheduled_update_type` entities, fields, field map.
- `plugins/` — Update Runner plugin type, the three runners, and every runner setting.
- `permissions/` — full permission model and access-control handlers.
- `config/` — configuring a type, embedded vs independent, Drush, cron.
