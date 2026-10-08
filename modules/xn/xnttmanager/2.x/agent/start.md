<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Entities Manager (xnttmanager) — agent index

Admin UI that **imports and synchronizes External Entities data into local Drupal content** and helps
you inspect/repair external-entity field mappings. For a chosen `external_entity_type` (only those
whose required fields are mapped are offered), it can auto-create a matching local **node** bundle
(or target an existing content type), clone the external type's fields onto it, add two hidden string
fields (`xnttid`, `xntttype`) used as the sync key, then create/update/delete local nodes to mirror
the external source. Synchronization runs **on demand** (Batch API) or **on a schedule** via
`xnttsync` config entities that `xnttmanager_cron()` checks each cron run against their `frequency`.
It also provides a field-mapping **inspector**, a **batch loader** (load/save/annotate all entities
of a type), a field-config **integrity** checker/fixer, and an experimental per-type **config
export/import** (download/upload a type's definition + field + display config as YAML).

Everything lives under `/admin/structure/external-entity-types/*` (tabs on the External Entity Types
page + a "Tools" menu entry). Entry points: `xnttmanager.management` (manage/inspect/batch/config),
`xnttmanager.sync` (synchronize now or create a cron), `entity.xnttsync.list` (list of sync crons),
`xnttmanager.inspect` (field-mapping table for one entity), `xnttmanager.integrity` (field integrity).

- Depends on: `external_entities:external_entities (>=3.0.0-beta2)`. Built for the xntt family (works
  well with the Multiple Storage plugin `xnttmulti`).
- Core: `^9 || ^10 || ^11`. Package: `External Entities`.
- **No dedicated settings / `configure` route** — the admin UI is a set of admin-structure routes.
- **Provides no permissions of its own**: every route is gated by external_entities' permission
  **`administer external entity types`** (the `xnttsync` config entity's `admin_permission` too).
- No drush commands. No plugin types. No config schema shipped (the `xnttsync` config entity ships
  without a `config/schema` file). Implements `hook_cron`. Ships one CSS library `xnttmanager/xnttmanager`.
- Provides one config entity type: **`xnttsync`** (a per-external-entity-type synchronization cron).

## What you'd do → where

- **Synchronize an external entity type into local nodes (on demand or on a schedule), auto-create the
  target bundle, understand the `xnttsync` cron config and `hook_cron`** →
  [configure/synchronization.md](configure/synchronization.md)
- **Inspect a type's field mapping, batch-load/save/annotate all its entities, or export/import a
  type's config as YAML** → [forms/management.md](forms/management.md)
- **Check and auto-fix broken field-config dependencies on external entity types** →
  [forms/management.md](forms/management.md)
- **Call the helper functions, understand the batch callbacks, the auto-created `xnttid`/`xntttype`
  fields, and the logger channel** → [api/internals.md](api/internals.md)

## Key facts (real machine names)

- Routes: `xnttmanager.management` (`/admin/structure/external-entity-types/manage`),
  `xnttmanager.sync` (`…/sync`), `xnttmanager.inspect` (`…/inspect/{xntt_type}/{xntt_id}`),
  `xnttmanager.integrity` (`…/integrity`), `entity.xnttsync.list` (`…/sync/list`),
  `entity.xnttsync.add_form` (`…/sync/add`), `entity.xnttsync.edit_form` (`…/sync/manage/{xnttsync}`),
  `entity.xnttsync.delete_form` (`…/sync/manage/{xnttsync}/delete`). All require `administer external
  entity types`.
- Config entity type: **`xnttsync`** — `Drupal\xnttmanager\Entity\XnttSync` (extends
  `ConfigEntityBase`); id key is `xnttType`; list builder `Controller\SyncListBuilder`.
- Config keys (`config_export`): `xnttType`, `uuid`, `label`, `contentTarget`, `syncAddMissing`,
  `syncUpdateExisting`, `syncRemoveOrphans`, `frequency`, `weight`. Runtime-only (not exported):
  `lastRunTime`, `inUse`.
- Forms: `ManagementForm` (form id `xnttmanager_management_form`), `IntegrityForm`
  (`xnttmanager_field_integrity_form`), `SyncFormBase` → `SyncForm` (op `xnttsync.sync`),
  `SyncAddForm` (`xnttsync.add`), `SyncEditForm` (`xnttsync.edit`), `SyncDeleteForm` (`xnttsync.delete`).
- Controller: `Controller\XnttInspector::inspect()`.
- Service: `logger.channel.xnttmanager` (a logger channel; no other services).
- Module functions: `xnttmanager_cron()`, `xnttmanager_bulk_process()`, `xnttmanager_bulk_finished()`,
  `xnttmanager_get_external_entity_type_list()`, `xnttmanager_get_synchronized_external_entity_list()`,
  `xnttmanager_get_content_entity_type_list()`.
- Auto-created target-bundle fields: `xnttid` (string), `xntttype` (string) — hidden sync keys.
- Library: `xnttmanager/xnttmanager` (CSS `css/xnttmanager.css`). Menu link (Tools):
  `xnttmanager.menu`. Local tasks/actions declared in `xnttmanager.links.task.yml` /
  `xnttmanager.links.action.yml` (tabs on `entity.external_entity_type.collection`).
