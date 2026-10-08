<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Leave Confirm (leave_confirm) — agent index

Warns a user who tries to leave a page with **unsaved form changes**, via the browser's
`beforeunload` prompt. Which forms are guarded is controlled by **`leave_confirm_point` config
entities** managed at `/admin/config/user-interface/leave-confirm-points` (route
`leave_confirm_point.list`, which is the module's `configure` route). Version **1.1.9**, core
`^10 || ^11`.

**Mechanism.** `leave_confirm_form_alter()` (in `leave_confirm.module`) runs on every form. For the
current `form_id` (and its base form id, if any) it entity-queries `leave_confirm_point` for entities
whose **`label` equals that form id and whose `status` is 1 (enabled)** — note it matches on the
entity *label*, not the machine id. If a match is found it attaches the library
`leave_confirm/confirmation_popup` (`js/leave-confirm.js`) and sets
`drupalSettings.leave_confirm.formId` to a comma-joined list of CSS selectors built from those form
ids (each stripped to `[A-Za-z0-9_-]`, `_`→`-`, prefixed with `.`, e.g. `node_page_form` →
`.node-page-form`). The JS behaviour `Drupal.behaviors.confirmLeave` binds `formUpdated` on
`.form-item` elements inside those selectors, and on the first change sets `window.onbeforeunload` to
a **fixed English string** (`"You have unsaved changes on this page…"`) which the browser replaces
with its own uncustomisable wording; the handler is cleared on form `submit`. It also triggers
`formUpdated` for media-library widgets and tabledrag row drops. **Points ship disabled** — the four
installed points and any node/webform points seeded at install all have `status: false`, so out of
the box nothing fires until an admin enables a point.

- Depends on: nothing (no `dependencies` in info.yml). `node` and `webform` are **optional** — only
  used by `hook_install` to seed extra (disabled) points if present.
- Core: `^10 || ^11`. Package: `Leave Confirm`.
- Settings page / `configure` route: **yes** — `leave_confirm_point.list`
  (`/admin/config/user-interface/leave-confirm-points`).
- Permissions: **one** — `administer leave confirm settings` (gates every admin route; also the
  config entity `admin_permission`). No drush commands. No plugin types.
- Config: defines the `leave_confirm_point` config entity type. Ships four disabled install points.
  **No `config/schema/`** is provided.

## What you'd do → where

- **Enable/add/disable a guarded form, the form-ID naming rules, the config-entity API, routes and
  permission, and why a popup does/doesn't fire** → [configure/points.md](configure/points.md)

## Key facts (real machine names)

- Config entity type: `leave_confirm_point` (`Entity\LeaveConfirmPoint`, `ConfigEntityBase`),
  `config_prefix` `leave_confirm_point`, `admin_permission` `administer leave confirm settings`,
  `entity_keys` id=`formId`, label=`label`, status=`status`; `config_export`: `formId`, `label`,
  `uuid`. Interface `LeaveConfirmPointInterface` (`getFormId`/`setFormId`/`getLabel`/`setLabel`).
- Routes (all require `administer leave confirm settings`, except enable/disable which use
  `_entity_access: leave_confirm_point.update` → same admin permission for config entities):
  `leave_confirm_point.list` (`/admin/config/user-interface/leave-confirm-points`, entity list),
  `leave_confirm_point.add` (`…/add`), `entity.leave_confirm_point.edit_form` (`…/{leave_confirm_point}`),
  `entity.leave_confirm_point.disable` (`…/{…}/disable`), `entity.leave_confirm_point.enable`
  (`…/{…}/enable`), `entity.leave_confirm_point.delete_form` (`…/{…}/delete`).
- Forms: `LeaveConfirmPointForm` (add/edit), `LeaveConfirmPointEnableForm`,
  `LeaveConfirmPointDisableForm`, `LeaveConfirmPointDeleteForm` (all under `src/Form/`).
  List builder: `Entity\Controller\LeaveConfirmPointListBuilder`.
- Permission: `administer leave confirm settings`.
- Library: `leave_confirm/confirmation_popup` → `js/leave-confirm.js` (deps `core/drupal`,
  `core/jquery`, `core/drupalSettings`). drupalSettings key: `leave_confirm.formId`.
  JS behaviour: `Drupal.behaviors.confirmLeave`.
- Hooks: `hook_help` (help.page.leave_confirm), `hook_form_alter`, `hook_install`. Procedural helpers
  in `.module`: `leave_confirm_get_leave_confirm_form_ids($form_id)`, `leave_confirm_point_load($id)`.
- Menu/action links: `leave_confirm.settings` (menu, under `system.admin_config_ui`),
  `leave_confirm_point.add` (action on the list page).
- Install-seeded points (all `status: false`): `user_login_form`, `user_pass`, `user_register_form`,
  `contact_message_personal_form` (config/install); plus `node_<type>_form` /
  `node_<type>_edit_form` per node type, and per-webform points, when those modules exist.
