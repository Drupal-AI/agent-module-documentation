<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, cron & Drush

## Prerequisites

Enable `scheduled_updates`, which pulls in core `options` and **`inline_entity_form`**
(`drupal/inline_entity_form:^3`). Clear caches.

## Create a Scheduled Update Type first

Configuration → Workflow → **Scheduled Updates** (`scheduled_update.config.overview`,
`/admin/config/workflow/scheduled-update-type`) → **Scheduled Update Types**.

A type:
- targets **one** entity type (`update_entity_type`);
- is **embedded**, **independent**, or both (`update_types_supported`);
- carries a **field map** — you pick fields from the target entity type to include on the update,
  and each maps to the target field it updates;
- selects one **Update Runner** and its settings (see `plugins/`).

### Embedded shortcut

On the target entity type's **Manage Fields** page, click **Add Update Field** (local action from
`AddUpdateFieldLocalAction` / `FieldClonerForm` / `ScheduledUpdateTypeAddAsFieldForm`). This creates
an entity-reference field to a `scheduled_update` bundle and lets editors schedule the update
inline on the target's add/edit form (via Inline Entity Form).

### Independent updates

Created from **Content → Add Scheduled update** (`/admin/content/scheduled-update/add`). The editor
sets the update time, the mapped field values, and selects the **target entities** by autocomplete
(one update can target many). Only types whose runner supports `independent` appear.

## Running updates

- **Cron** — the normal path. `hook_cron` calls `UpdateRunnerUtils::runAllUpdates([], TRUE)`; every
  ready update (timestamp reached, still Un-run/Re-queued) is queued and applied. Updates fire when
  cron runs, not at the exact configured time — set cron frequency accordingly.
- **Manual form** — `/admin/config/workflow/schedule-updates/run` (`administer scheduled update
  types`): "run all updates where the update time is <= now".
- **Drush** (`drush.services.yml`, `RunUpdatesCommand`):
  - `drush sup:run_updates` (aliases `sup-run`, `sup:run`) — option `--types=machine1,machine2`.
  - `drush sup:list_runners` (aliases `sup-list`, `sup:list`) — option `--unrun`, `--types`.

## Settings form

`/admin/config/workflow/schedule-updates/admin` (`scheduled_updates.settings`) — includes the
per-cron **`timeout`** (seconds spent processing the queue per run; default 15).

## Config schema

`config/schema/scheduled_update_type.schema.yml` defines the type config and the
`update_runner.plugin` settings (with `Choice` constraints for the enum-backed options); the type
config is `FullyValidatable`.

## Lifecycle notes

- Deleting a type deletes its cloned source-field storages and purges data
  (`ScheduledUpdateType::postDelete`).
- Uninstall deletes all types (cleaning up fields) and drops the `scheduled_update` table
  (`scheduled_updates_uninstall`).
