<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `create new menu` permission and menu-create access

Everything the module does, in operational detail. The whole module is two code files plus
`.info.yml`; this page is still shorter than reading them and the relevant core routes.

## Install / enable

- `drush en create_menus_permission -y` (or via `admin/modules`). No configuration step — there is
  no settings form, no config object, no config schema, no install hook.
- Dependency: core **`menu_ui`** only (`create_menus_permission.info.yml`). Core requirement
  `^10 || ^11`. Package *Administration*.
- After enabling, grant the new permission at **`admin/people/permissions`** (see the caveat below —
  you almost always must grant it to any role that currently creates menus).

## What is registered

`create_menus_permission.permissions.yml`:

```yaml
permission_callbacks:
  - \Drupal\create_menus_permission\CreateMenusPermission::CreateMenusPermission
```

`src/CreateMenusPermission.php` → `CreateMenusPermission::CreateMenusPermission()` returns exactly
one permission:

```php
$perms['create new menu'] = ['title' => t('Create new menu')];
```

That is the entire permission definition — a title only. No `description`, and it is **not**
flagged `restrict access: TRUE`.

## The access hook

`create_menus_permission.module` implements `hook_ENTITY_TYPE_create_access()` for the `menu`
config entity as `create_menus_permission_menu_create_access()`:

```php
function create_menus_permission_menu_create_access(AccountInterface $account, array $context, $entity_bundle) {
  if ($account->hasPermission('create new menu')) {
    return AccessResult::allowed();
  }
  return AccessResult::forbidden();
}
```

- Signature is core's `hook_ENTITY_TYPE_create_access($account, $context, $entity_bundle)`; the
  decision uses **only** `$account->hasPermission('create new menu')`. `$context` and
  `$entity_bundle` are ignored — there are no menus, bundles, or request input in the decision, so
  no way to bypass or widen it via input.
- The `.module` file carries several **dead `use` imports** (`Html`, `Element`,
  `FormStateInterface`, `EntityInterface`); only `AccessResult` and `AccountInterface` are used.
  There is no `hook_form_alter`, no menu-link handling, no output — no XSS/CSRF surface.

## Routes and permissions map (verified against core `system.routing.yml`)

| Operation | Route | Core requirement | Effective gate with this module |
|-----------|-------|------------------|---------------------------------|
| Create menu | `entity.menu.add_form` (`/admin/structure/menu/add`) | `_entity_create_access: 'menu'` | **`create new menu`** (via the hook) |
| Edit menu / links | `entity.menu.edit_form` | `_entity_access: 'menu.update'` | still `administer menu` (via `MenuAccessControlHandler`) |
| Delete menu | `entity.menu.delete_form` | `_entity_access: 'menu.delete'` | still `administer menu` |
| Add/edit menu links | menu-link routes on `menu_link_content` | their own access | unaffected — hook never touches links |

The hook governs only the **create** operation, i.e. only `entity.menu.add_form`. A holder of
`create new menu` (without `administer menu`) can open the Add-menu form and create a **new, empty
menu**, and nothing else — they cannot edit or delete any existing menu, cannot add or rearrange
menu links (so cannot place a link on a privileged route), and cannot reach the administration or
main menus. Granting one menu does not leak access to others; there are no per-menu permissions.

## Operational caveat — enabling this changes `administer menu`

`hook_ENTITY_TYPE_create_access()` returns **`AccessResult::forbidden()`** (not `neutral()`) when
the permission is absent. A forbidden create-access result short-circuits core's default
admin-permission check in `EntityAccessControlHandler::createAccess()` (`if (!$return->isForbidden())`).
Consequence: **after enabling this module, `administer menu` alone no longer lets a role create
menus.** Any role that previously created menus via `administer menu` must also be granted
`create new menu`, or it silently loses the create ability. This removes access, never adds it
(user 1 / superuser-bypass accounts are unaffected). Returning `neutral()` on that branch would
have preserved the core admin path; the module does not, so treat the two permissions as needing
to be granted together on any existing menu-admin role.
