<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration — agent index

Sign-ups for "host" entities. You add a **Registration field** (`registration` field type) to a
bundle; that ties the host to a **`registration_type`** config entity (which names a Workflow +
hold-expiration). Each host then exposes register / manage / settings routes, and holds a
per-host **`registration_settings`** content entity (capacity, open/close, spaces, reminders).
Each sign-up is a **`registration`** content entity with a workflow `state` and a spaces `count`.

Core model (read these first):

- **Registration types, workflow states & global settings (`registration.settings`)** →
  [configure/registration-types.md](configure/registration-types.md)
- **Enabling registration on an entity: the `registration` field + per-host `registration_settings` + register routes** →
  [configure/host-settings.md](configure/host-settings.md)
- **Programmatic API: `HostEntity`, `RegistrationManager`, `RegistrationValidator`, the `registration` entity** →
  [api/services.md](api/services.md)
- **Plugin surface: `RegistrationConstraint` host-validation plugins, the `registration` WorkflowType, actions & the status block** →
  [plugins/constraints.md](plugins/constraints.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:

- Configure route: **`registration.admin_settings`** → `/admin/structure/registration-settings`
  (global `registration.settings` config object). Registration types collection:
  `/admin/structure/registration/type` (entity `registration_type`).
- Register/manage/settings routes are added **dynamically per host entity type** by
  `RouteSubscriber`: `entity.<host_type>.registration.register`,
  `entity.<host_type>.registration.manage_registrations`,
  `entity.<host_type>.registration.registration_settings` (e.g. `entity.node.registration.register`).
- Cron: `ExpireHeldRegistrations` and `SendReminders`. Drush: integrates with `sql:sanitize`.
- Nine submodules nest under `modules/` beside this version dir (admin_overrides, cancel_by,
  change_host, confirmation, inline_entity_form, purger, scheduled_action, waitlist, workflow).
