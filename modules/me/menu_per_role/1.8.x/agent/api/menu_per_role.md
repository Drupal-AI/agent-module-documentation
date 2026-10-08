# API / internals — Menu Per Role

The module exposes no `.api.php` hooks and no services meant to be called directly. It
extends behavior through two mechanisms plus base fields you can set programmatically.

## Base fields on `menu_link_content`

Added via `hook_entity_base_field_info()` (only for the `menu_link_content` entity type),
both `entity_reference` → `user_role`, cardinality unlimited, widget `options_buttons`:

- `menu_per_role__show_role` — "Roles able to see the menu link"
- `menu_per_role__hide_role` — "Roles not able to see the menu link"

Set them programmatically on a `MenuLinkContent` entity:

```php
$link = \Drupal\menu_link_content\Entity\MenuLinkContent::create([
  'title' => 'Members area',
  'link' => ['uri' => 'internal:/members'],
  'menu_name' => 'main',
  'menu_per_role__show_role' => [['target_id' => 'member']],
  'menu_per_role__hide_role' => [['target_id' => 'anonymous']],
]);
$link->save();
```

Read: `$link->menu_per_role__show_role->getValue()` → array of `['target_id' => <role_id>]`.

## Access enforcement (decorator)

`menu_per_role.services.yml` decorates the core service `menu.default_tree_manipulators`
with `MenuPerRoleLinkTreeManipulator` (extends `DefaultMenuLinkTreeManipulators`), injecting
`@router.admin_context` (via `setAdminContext`) and `@config.factory` (via `setConfigFactory`).

Its `menuLinkCheckAccess()`:
1. Runs parent access check.
2. If `bypassAccessCheck()` (admin config / bypass permissions — see permissions doc) → return neutral.
3. For `MenuLinkContent` instances, reads the two fields and `andIf(AccessResult::forbidden())`
   when: a "show" set exists and the account shares none of those roles, OR a "hide" role
   intersects the account's roles.

Because access is combined with `andIf`, Menu Per Role can only further restrict a link; it
never grants access the link wouldn't otherwise have.

## Cache

- Access results add cache contexts `user.roles`, `user.is_super_user`, `route.is_admin`.
- The module ships a custom cache context service `cache_context.route.is_admin`
  (`RouteIsAdminCacheContext`, id `route.is_admin`) wrapping `@router.admin_context`, so
  front vs admin filtering caches separately.

## Scope limitation

Only content menu links (`menu_link_content`) are affected. Links defined in configuration
(e.g. Views) or in `*.links.menu.yml` cannot be restricted by this module.
