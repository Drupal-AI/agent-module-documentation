<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission: `access people list`

Defined in `user_list_permission.permissions.yml`:

```yaml
access people list:
  title: View People List
  description: Grant to view lists of users.
  restrict access: true
```

`restrict access: true` flags it in the permissions UI as security-sensitive, because the People
list discloses account data. This is the module's only permission and its entire feature surface —
there is no configuration form, config schema, Drush command, or plugin.

## Grant it
Assign on `/admin/people/permissions` (Administration » People » Permissions), or via Drush:

```bash
drush role:perm:add <role> 'access people list'
```

A role with this permission can open `/admin/people`. A role without it (and without
`administer users`) gets a 403 there.

## What happens at install (`hook_install`)
`user_list_permission_install()` runs only when config is **not** syncing, and does two things:

1. **Rewrites the People view access, conditionally.** It reads
   `views.view.user_admin_people`. Only if the default display still uses the core default
   (`access.type === 'perm'` and `access.options.perm === 'administer users'`) does it set that
   perm to `access people list`. A view whose access was already customised is deliberately left
   alone, so the module never overrides a site's own access choice.
2. **Grants the new permission to existing admins.** It loads all roles and, for each role that
   already has `administer users`, grants `access people list` and saves the role. This keeps
   current administrators able to view the list without any manual step.

Uninstalling does not automatically revert the view-access rewrite or revoke the granted
permission — there is no `hook_uninstall`. If you uninstall, re-check
`views.view.user_admin_people`'s access if you need the core default back.

## How `/admin/people` is actually re-gated (Views vs. non-Views)

**Standard install (Views enabled):** `/admin/people` is served by the `user_admin_people` Views
display. Core Views (`PathPluginBase::alterRoutes`) replaces the `entity.user.collection` route
with the view's route, copying the view's access requirement onto it. Because `hook_install`
rewrote the view's access to `access people list`, the route ends up requiring `access people list`
too. Verified on a running site: both `entity.user.collection` and `view.user_admin_people.page_1`
require `access people list`, and the view's access config is
`{"type":"perm","options":{"perm":"access people list"}}`. **The route subscriber is not what does
this** — the rewritten view access is.

**Route subscriber caveat (`src/Routing/UserListPermissionRouteSubscriber.php`):**

```php
if ($route = $collection->get('entity.user.collection')) {
  if ($route->getRequirement('_permission') === 'administer account settings') {
    $route->setRequirement('_permission', 'access people list');
  }
}
```

The guard only rewrites the route when its current requirement equals `administer account
settings`. The core `entity.user.collection` route requirement is **`administer users`**
(`core/modules/user/user.routing.yml`), which does not match — so on core 11.1+ this subscriber is
a **no-op**. It only ever matters on a **Views-disabled** site, where `/admin/people` falls back to
the core entity-list route: there the subscriber still will not fire (string mismatch), so a role
holding only `access people list` would get a 403 — the permission simply does not function without
Views. This fails **closed** (access stays on `administer users`); it is a functionality gap, not
an access opening. In practice Views ships in core and hosts `/admin/people`, so the feature works
as intended on a normal site.

## What the viewer can and cannot do
- **Can:** open `/admin/people` and read the list — usernames, status, roles, member-for,
  last-access, and email if the site's view includes a mail column; use the exposed name/email
  search filter.
- **Cannot (without `administer users`):** edit, block, cancel, or change roles of accounts. The
  operations links (edit/cancel) point to routes with their own access checks, and the bulk-action
  form (`user_bulk_form`) is access-checked per selected user by core
  (`BulkForm::viewsFormSubmit` calls each action plugin's `access()`; the user Block/Cancel/Role
  actions require entity `update`/`delete` access, i.e. `administer users`). A viewer who submits a
  bulk action on accounts they cannot manage gets a "No access" error and nothing changes.

## Verify (read-only)
```bash
# Effective route + view access
drush php:eval '$r=\Drupal::service("router.route_provider")->getRouteByName("entity.user.collection"); echo $r->getRequirement("_permission");'
drush config:get views.view.user_admin_people display.default.display_options.access
# Who can view the list
drush php:eval 'foreach (\Drupal\user\Entity\Role::loadMultiple() as $id=>$r){ if ($r->hasPermission("access people list")) echo "$id\n"; }'
```
