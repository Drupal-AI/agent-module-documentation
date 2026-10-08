<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & access logic

`domain_menus.permissions.yml` defines two permissions:

- **`edit assigned domain menus`** — edit the domain menus of the domains the user is assigned.
- **`edit active domain menus`** — like the above, but further limited to the **currently active
  domain**'s menus.

Plus core's **`administer menu`** ("Administer menus and menu options"), which can edit *any* menu
(including domain menus) and freely change a menu's domain assignment on the menu edit form.
The settings form itself is gated by **`administer domains`** (Domain module).

## How access is decided (`domain_menus_menu_access` in `domain_menus.module`)

For a menu operation other than `delete`:
1. Load the menu's `domain_menus.domains` third-party setting.
2. Compute the intersection of that with the user's Domain Access values (requires `domain_access`;
   `domain_access.manager` `getAccessValues()` / `getAllValue()`).
3. If the user has **`edit assigned domain menus`** and the intersection is non-empty (or the user
   has "all domains") → **allowed**.
4. Else if the user has **`edit active domain menus`** and the intersection is non-empty and the
   menu is assigned to the active domain → **allowed**.
5. Otherwise neutral (falls back to core access).

Menu-link create/edit access (`domain_menus_menu_link_content_create_access` /
`_access`) simply defers to the parent menu's `edit` access, so the same rules apply to adding and
editing links inside a domain menu.

The management page `/admin/structure/domain-menus` (route `domain_menus.menus`, requires
`administer menu` **or** either domain-menus permission) lists the domain menus the current user can
edit.

> Note: the "assigned"/"active" checks only have real effect when the **domain_access** module is
> enabled (that is what assigns domains to users). Without it, `getAccessValues()` returns empty and
> these permissions grant nothing beyond what `administer menu` already allows.
