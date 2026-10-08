# Configuration

Menu Item Group Role Access is configured **per menu item**, on the menu-link edit
form. There is no central settings page.

## Set which group roles see a menu item

1. Log in as a user who can edit menu items (and who holds the module's own
   permission — see [Permissions](#permissions) below).
2. Go to **Structure → Menus** (`/admin/structure/menu`) and edit the menu link
   you want to restrict.
3. In the role field this module adds, **select the Group roles** that should be
   allowed to see this menu item. The field lists all available group roles.
4. Save the menu link.

From then on, the link is shown to users whose group role matches your selection,
and hidden from those whose role does not.

## The "overwrite target access" option

The menu-link form also offers an option to **ignore the access check of the menu
target** (described in the project as: *ignore the access check of the menu
target … the user will see the menu item, but only if the user's role is
allowed*).

- **With it off (normal behaviour):** core still hides a link when the user cannot
  access its target, so a role-allowed link may still be hidden if the underlying
  content is not reachable.
- **With it on:** the link is shown to a role-allowed user **even when they cannot
  access the target**. They see the link, but clicking it still returns the
  target's own access result — typically a **403** if they are not allowed in.

Use this deliberately. Because it makes links visible for content the user cannot
open, it can **disclose the existence and title** of restricted content through
the menu. It does **not** grant any access to the target — the target route or
entity always enforces its own access.

## Important: what this controls

This module governs **whether the menu link is displayed, not access to the linked
content.** Menu visibility here is **not a security boundary**:

- Hiding a menu item does **not** protect its target — someone with the URL and
  the right permissions can still reach it.
- Showing a menu item does **not** grant access to its target — the target's own
  access rules still apply.

Treat this as a navigation-tailoring tool. For real protection of the content
itself, rely on the target entity's or route's access controls.

## Permissions

The module provides its own permissions (grant them under **People → Permissions**,
`/admin/people/permissions`) that govern who can set these per-item role
restrictions. Grant them only to trusted editors who manage your menus, and keep
the security notes above in mind — especially before enabling the "overwrite
target access" option on any link that points at restricted content.
