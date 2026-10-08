<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & access control

## Static permissions (`scheduled_updates.permissions.yml`)

- **`administer scheduled update types`** — full control over `scheduled_update_type` config:
  create/edit/delete types, clone fields, and reach the **manual runner form** and settings menu.
  This is the powerful, admin-level permission.
- **`administer scheduled updates`** — admin permission for the `scheduled_update` content entity;
  the access handler grants **all** operations to holders.
- **`view scheduled update entities`** — view the update list and individual updates.

## Dynamic per-type permissions (`permission_callbacks` → `Permissions.php`)

For every `scheduled_update_type`, `Permissions::scheduledUpdateTypesPermissions()` generates:

- `create <type_id> scheduled updates`
- `edit own <type_id> scheduled updates`
- `edit any <type_id> scheduled updates`
- `delete own <type_id> scheduled updates`
- `delete any <type_id> scheduled updates`

This lets different teams own different kinds of update.

## Access handlers

`ScheduledUpdateAccessControlHandler` (for `scheduled_update`):

- `administer scheduled updates` → allow everything.
- `view` → `view scheduled update entities`.
- Other ops: if the current user is the update's owner, allow with
  `edit own`/`edit any` (or `delete own`/`delete any`) OR-combined; otherwise require the `any`
  variant.
- **Create** → `administer scheduled updates` OR `create <bundle> scheduled updates`.

`ScheduledUpdateTypeAccessControlHandler` (for `scheduled_update_type`): `view` needs
`view scheduled update entities`; other ops fall through to the default handler keyed on
`administer scheduled update types`.

## Route access summary

- Update add page / add form — `create <type> scheduled updates`
  (`ScheduledUpdateAddController::addPageAccess` / `addFormAccess`; embedded types are forbidden
  from the independent add form).
- Update view/list — `view scheduled update entities`.
- Update edit/delete — `_entity_access` (handler above).
- **All type management, the manual runner form** (`schedule_updates.runner_form`,
  `/admin/config/workflow/schedule-updates/run`) — `administer scheduled update types`.
- Settings form — `access administration pages`.

## Important behavioral caveat

Creating an update controls **which entities** get changed, but the **field(s) changed are fixed by
the type's `field_map`** (set by a type administrator). At run time the update is applied **without
a per-target entity edit-access or field-access check**, and under cron it runs as **user 1**.
Consequently the `create <type> scheduled updates` permission effectively lets a holder set the
mapped field on **any** entity of the configured type/bundle — including entities they could not
otherwise edit — for **independent** updates (targets chosen by autocomplete). Embedded updates are
gated by target edit access because attaching one means editing the target. Grant
`create <type> scheduled updates` only to roles you trust to change that field on any such entity.
