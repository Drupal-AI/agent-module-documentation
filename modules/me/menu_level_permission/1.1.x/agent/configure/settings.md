<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Menu Level Permission

## Install / enable
`drush en menu_level_permission -y`. Requires `menu_link_content` (core). The module does **nothing** until at least one menu is marked restricted.

## Settings form
Route `menu_level_permission.settings` → `/admin/config/user-interface/menu-level-permissions`, requirement `_permission: 'administer site configuration'`. Menu tab link registered in `menu_level_permission.links.menu.yml` under `system.admin_config_ui`.

Form: `src/Form/MenuLevelPermissionSettingsForm.php` (`ConfigFormBase`, form id `menu_level_permission_settings`), using `RedundantEditableConfigNamesTrait` and `ConfigTarget` bindings. Two fields:
- **Menus with restricted levels** (`restricted_menus`) — checkboxes of every menu entity (`entity_type.manager` → `menu` storage, sorted by label).
- **Restricted menu levels** (`restricted_levels`) — select with options 1–5 ("Level 1 Only" … "Levels 1-5").

![Menu Level Permission settings form](../../../../../../../screenshots/menu_level_permission/1.1.x/settings-form.png)

## Config object
`menu_level_permission.settings` (schema `config/schema/menu_level_permission.schema.yml`):
- `restricted_menus`: sequence of strings (checkbox map, menu machine name => enabled). Default `{}`.
- `restricted_levels`: integer depth threshold. Default `1` (only top-level links restricted).

## Permission model
- Permission `administer restricted menu levels` (`menu_level_permission.permissions.yml`) — its own description states it also needs core `administer menu`. Holders bypass the level restriction.
- Without it, a user is **forbidden** from update/delete on any `menu_link_content` link whose level ≤ `restricted_levels` in a restricted menu.

## Level computation
`MenuLevelPermissionAccess::getMenuLinkLevel()` starts at 1 and walks the `menu_link_content` parent chain via `findMenuParent()` (`getParentId()`), incrementing per ancestor. Level 1 = top-level link.

## Enforcement points
- **Route access** — `RouteSubscriber::alterRoutes()` attaches `_custom_access: MenuLevelPermissionAccess::menuItemAccess` to `entity.menu_link_content.canonical`, `.delete_form`, and the four `content_translation_*` routes; and replaces the `entity.menu.collection` controller with `MenuLevelPermissionController::menuOverviewPage`. Subscriber runs at priority -230 (after menu_admin_per_menu at -220).
- **Entity access** — `MenuLevelPermissionHooks::menuLinkContentAccess()` (`#[Hook('menu_link_content_access')]`) routes `update`/`delete` operations through `menuItemAccess()`; returns `AccessResult::neutral()` for other operations.
- **Access decision** — `menuItemAccess()` returns `AccessResult::forbidden()` when `is_numeric($restricted_levels) && $menu_level <= $restricted_levels` on a restricted menu; otherwise `accessFallback()` → menu_admin_per_menu's `allowed_menus` service if enabled, else `allowed()` if the user has core `administer menu`, else `neutral()`.
- **Form UX/validation** — `formNodeFormAlter()` / `formMenuLinkContentFormAlter()` / `formMenuEditFormAlter()` add `_menu_level_permission_form_validate` and `_after_build_*` callbacks that disable or remove menu widgets for restricted links, show a read-only "restricted level" notice, drop the "add child" op, and (when no editable links remain) hide the submit button. `MenuLevelPermissionFormValidator::validate()` errors when a chosen parent is above the restricted level, covering node forms, menu-link-content forms, and the bulk menu-edit form.

## Verify hardening
As a user with only `administer menu` (no `administer restricted menu levels`), request `/admin/structure/menu/item/<id>/delete` for a top-level link in a restricted menu — it must return 403.
