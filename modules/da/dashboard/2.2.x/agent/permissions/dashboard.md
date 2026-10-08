# dashboard — permissions

## Static permission (`dashboard.permissions.yml`)

- `administer dashboard` — full control: view the collection, add/edit/delete/preview
  dashboards, build layouts. It is also the entity type's `admin_permission`.

## Dynamic permissions (`DashboardPermissions::permissions`)

Registered via a `permission_callbacks` entry. One permission is generated **per dashboard**:

- `view <id> dashboard` — grants a role access to view that specific dashboard
  (title: "Access to <label> dashboard"). Each carries a config dependency on its dashboard.

This is the mechanism for **per-role dashboards**: grant a role the `view <id> dashboard`
permission for the dashboard it should see. Reordering by `weight` decides which one is the
default (`/admin/dashboard`) when a user can view more than one.

## Access rules (`DashboardAccessControlHandler`)

- `view` — allowed only if the dashboard is enabled (`status = true`) AND the account has
  `view <id> dashboard`. (User 1 is not specially exempt; they need the permission too.)
- `preview` — allowed if the account has `administer dashboard` OR `view <id> dashboard`.

## Other gates

- The **Manage permissions** form (`/admin/structure/dashboard/{dashboard}/permissions`)
  requires the core `administer permissions` permission.
- Collection / add / edit / delete routes require `administer dashboard`.
