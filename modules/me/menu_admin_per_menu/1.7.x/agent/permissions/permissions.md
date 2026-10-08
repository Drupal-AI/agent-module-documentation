# Permissions

Permissions are **dynamic**, generated per existing menu by
`MenuAdminPerMenuPermissions::permissions()` (registered via
`permission_callbacks` in `menu_admin_per_menu.permissions.yml`).

For every menu on the site you get:
- **`administer <menu_id> menu items`** — title "Administer *<Menu label>* menu
  items". Grants managing links in that specific menu (add/edit/delete links,
  reach the menu's link overview, use it as a parent), **without** core
  `administer menu`.

Assign these on **People → Permissions** (`/admin/people/permissions`). A new
permission appears automatically whenever a new menu is created.

## What per-menu access does NOT include
Users without the global core `administer menu` still cannot:
- Create, rename, delete menus, or edit menu metadata (id/label/description/
  langcode) — those fields are hidden on the menu edit form.
- Manage menus they have no matching per-menu permission for; those are filtered
  out of parent-menu dropdowns on menu-link and node forms.

Core `administer menu` continues to grant full control over all menus and
bypasses these checks.
