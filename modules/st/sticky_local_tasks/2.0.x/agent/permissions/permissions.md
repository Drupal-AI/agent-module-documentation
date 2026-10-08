# Permissions

## What gates the settings form

The settings route `sticky_local_tasks.admin_settings` requires core's
`_permission: 'administer site configuration'` (see `sticky_local_tasks.routing.yml`). That is the
permission an account actually needs to open `/admin/config/user-interface/sticky-local-tasks` and
change any setting.

## Declared module permission (not enforced)

`sticky_local_tasks.permissions.yml` declares:

| Permission | Machine string | Flags |
|---|---|---|
| Administer sticky local tasks | `administer sticky local tasks` | `restrict access: true` |

Nothing in the module checks this permission — no route, form, block, or access handler references it.
Granting it therefore gives no access to the settings form (that still needs
`administer site configuration`), and it does not affect where or to whom the sticky tabs render.

## Who sees the tabs themselves

The widget only re-displays local tasks that core already produced for the current user:
`StickyLocalTasksBuilder::build()` reads `LocalTaskManagerInterface::getLocalTasks()`, which is already
access-filtered per route and account. The module adds no access logic of its own and never exposes a
tab the user could not otherwise see. The **Sticky primary tabs** block additionally honors core's
standard block visibility (roles, pages, etc.).
