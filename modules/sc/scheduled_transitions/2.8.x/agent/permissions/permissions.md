<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

## Global (static, `scheduled_transitions.permissions.yml`)

- **`view all scheduled transitions`** — view every scheduled transition (also the entity's
  `admin_permission`; gates the `/admin/content/scheduled-transitions` collection).
- **`administer scheduled transitions`** (`restrict access: TRUE`) — the settings form.

## Dynamic per entity-type/bundle (`ScheduledTransitionsPermissions::permissions`)

Generated for every moderated + enabled bundle (three per bundle). Machine-name patterns:

- **`view scheduled transitions <entity_type> <bundle>`** — e.g. `view scheduled transitions node article`.
- **`add scheduled transitions <entity_type> <bundle>`** — e.g. `add scheduled transitions node article`.
- **`reschedule scheduled transitions <entity_type> <bundle>`** — e.g. `reschedule scheduled transitions node article`.

Helper methods build the exact strings:
`ScheduledTransitionsPermissions::viewScheduledTransitionsPermission($entityTypeId, $bundle)`,
`::addScheduledTransitionsPermission(...)`, `::rescheduleScheduledTransitionsPermission(...)`.

Note: `mirror_operations` in settings can defer these checks to another entity operation (by
default `update`), so a user who can edit the entity effectively gains the matching
view/add/reschedule capability. Grant with e.g.
`drush role:perm:add editor 'add scheduled transitions node article'`.
