# Configure per-menu-link role visibility

## Where the setting appears

Enabling the module adds two base fields to every `menu_link_content` entity, shown on the
menu link **add/edit** form (Menus → edit a link, e.g. `/admin/structure/menu/item/{id}/edit`):

| Field | Type | Widget | Purpose |
|---|---|---|---|
| `menu_item_roles` | entity_reference → `user_role`, unlimited | checkboxes (`options_buttons`) | Roles allowed to see this link |
| `menu_item_override_children` | boolean, cardinality 1 | checkbox | Make children inherit this link's roles |

The `menu_item_override_children` checkbox is only shown when the `inherit_parent_access`
setting (below) is on. Fields are declared in
`menu_item_role_access_entity_base_field_info()` in `menu_item_role_access.module`.

Select one or more roles on a link to restrict it; **leave it empty to show the link to
everyone**. When roles are set, a user sees the link only if they hold at least one of the
selected roles.

## How visibility is enforced

The module's `services.yml` **overrides the core `menu.default_tree_manipulators` service**
with `MenuItemRoleAccessLinkTreeManipulator`, which extends core
`DefaultMenuLinkTreeManipulators`. Its `menuLinkCheckAccess()` runs the normal core check,
then, for the link's `menu_link_content` entity, reads `menu_item_roles` and returns
`AccessResult::forbidden()` unless the current user has a matching role (cache context
`user.roles`). Notes:

- A user with the core **`link to any page`** permission bypasses the role check entirely.
- Empty `menu_item_roles` → no restriction added.

## Visibility, NOT security (important caveat)

This module only controls whether a menu **link is displayed**. It does not protect the
destination page — route/page access is still governed by Drupal's normal permissions. Two
consequences (from the README troubleshooting):

- A role allowed here will still **not** see the link if it lacks permission to view the
  target route (core access check wins) — unless you enable the overwrite option below.
- Granting visibility here does **not** grant access to a page the role otherwise can't reach.

## Behavior settings — `menu_item_role_access.config`

Form at `/admin/config/menu-item-role-access` (route `menu_item_role_access.config`, form
`\Drupal\menu_item_role_access\Form\ConfigForm`). Config object `menu_item_role_access.config`,
schema in `config/schema/`. Both default `false`:

| Key | Default | Meaning |
|---|---|---|
| `overwrite_internal_link_target_access` | `false` | Ignore the target route's own access check and let the role setting alone decide visibility. Turn on so a role sees the link even without access to the target node. |
| `inherit_parent_access` | `false` | Allow a parent link (with "Override children" checked) to impose its roles on descendant links; a child can re-override. |

Set via drush, e.g. `drush cset menu_item_role_access.config overwrite_internal_link_target_access true`.
Special route names `<nolink>`, `<none>`, `<front>` and external links are always evaluated
for the role check regardless of the overwrite setting.

## Permissions (`menu_item_role_access.permissions.yml`)

| Permission | Gates |
|---|---|
| `edit menu_item_role_access` | Editing the `menu_item_roles` field on the menu link form (enforced via `hook_entity_field_access`; without it the field is forbidden) |
| `administer menu_item_role_access` | The behavior settings form / config route |
