<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OG Menu (og_menu) — agent index

Per-**Organic Group** menus. Each group gets its own menu, stored as a content entity attached to
the group, so a group can carry navigation without touching Drupal's global site menus.
Version **2.0.0-alpha4**, core `^10 || ^11`. Requires `menu_ui` and **`og`** (Composer:
`drupal/og:^1.0 || ^2.0`). GPL-2.0-or-later.

## The mechanism (read this first)

Two entity types:

- **`ogmenu`** — a *config* entity, `ConfigEntityBundleBase`, the "menu template". Admins create one
  at `admin/structure/menu/ogmenu/add`. On first save it calls `Og::createField()` to attach OG's
  audience field to `ogmenu_instance`, wiring the bundle to a group type. It is the *bundle* of
  `ogmenu_instance`.
- **`ogmenu_instance`** — a *content* entity, one per group per `ogmenu`. Its bundle is the `ogmenu`
  id; it references its group through OG's `OgGroupAudienceHelperInterface::DEFAULT_FIELD`. Each
  instance backs a real Drupal menu named **`ogmenu-{instance_id}`**; its links are ordinary
  `menu_link_content` entities. `preDelete()` deletes all links in that menu.

The instance edit form (`OgMenuInstanceForm`) is a near-copy of core's menu overview table:
add/reorder/enable/disable/delete links reuse core `menu_ui` and `menu_link_content`.

Two **blocks** are derived per `ogmenu` (`OgMenuBlock` + deriver), context-aware on the active group
via `OgContext` / the `og` context. If no instance exists for the current group, the block offers an
"Add menu" action linking to the create route.

`hook_entity_insert` auto-creates an instance for a new group when `og_menu.settings:autocreate` is
on. `hook_entity_delete` removes a group's instances (unless OG's own `delete_orphans` handles it).
A service provider swaps `menu.parent_form_selector` for `OgMenuParentFormSelector` so the parent
dropdown lists OG menus for `ogmenu-*` parents.

## Access model — DO NOT trust its shape

Routes use `_entity_access` / `_permission`, which *looks* OG-aware, but it is not, for most
operations:

- `OgMenuInstanceAccessControlHandler::checkAccess()` resolves **view / update / delete** against
  **global** site-wide permissions (`view|edit|delete og menu instance entities`) via
  `allowedIfHasPermission()`. It performs **no** check of *which* group the instance belongs to and
  **no** OG membership check. A global grant applies to every group's menu site-wide.
- `checkCreateAccess()` → global `add og menu instance entities`. The create route
  (`/admin/structure/ogmenu_instance/{ogmenu}/{og_group_entity_type}/{og_group}`) carries a `@todo`
  admitting it does not validate the user's access to the target group nor that the target is a
  group.
- Only the **add-link** operation (`OgMenuInstanceController::addLinkAccess`) actually consults OG:
  global permission OR the group membership's `add new links to og menu instance entities`
  permission. The `OgMenuEventSubscriber` registers exactly one OG group permission — that same
  add-link one.
- `administer og menu` (`restrict access: true`) governs the `ogmenu` bundle CRUD, the settings form
  and the overview.

The module's own kernel test (`tests/src/Kernel/OgMenuAccessTest.php`) confirms this: a group admin
and group member get `FALSE` for view/update/delete — group membership grants nothing there.

This is an **alpha**, feature-incomplete, with several `@todo`s in the access code. Because
view/update/delete resolve against the global `view|edit|delete og menu instance entities`
permissions (not the instance's group), grant those permissions deliberately: a role that holds
them can manage every group's menu, so scope them to trusted editors.

## Files / structure

- `src/Entity/OgMenu.php`, `src/Entity/OgMenuInstance.php` — the two entities.
- `src/OgMenuInstanceAccessControlHandler.php` — the access handler (global-permission based).
- `src/Controller/OgMenuInstanceController.php` — create + add-link + add-link access.
- `src/Form/OgMenuInstanceForm.php` — the menu-overview edit form.
- `src/Plugin/Block/OgMenuBlock.php` + `src/Plugin/Derivative/OgMenuBlock.php` — per-menu blocks.
- `src/EventSubscriber/OgMenuEventSubscriber.php` — the one OG group permission.
- `og_menu.module` — autocreate/cleanup hooks, form_alter, breadcrumb.
- Routes `og_menu.routing.yml`; permissions `og_menu.permissions.yml`; settings
  `admin/config/group/og_menu`.

## Solution-type docs

- `agent/entities/` — the `ogmenu` / `ogmenu_instance` model and the `ogmenu-{id}` menu backing.
- `agent/blocks/` — the derived, group-context-aware menu blocks.
- `agent/permissions/` — the permission set and how access actually resolves.
