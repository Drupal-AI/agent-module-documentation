<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Trailless Menu lets you pick menus that should have no active trail - active and parent items receive no active HTML classes and children aren't auto-expanded.

---

Trailless Menu decorates the core `menu.active_trail` service (`TraillessMenuActiveTrail`) and, for menus selected on its settings form (`/admin/config/user-interface/trailless-menu`, permission `administer trailless menu`), returns an empty active trail. The selection is stored in `trailless_menu.settings` as a map of menu-id => TRUE. Saving the form invalidates the affected `config:system.menu.*` cache tags. This is useful for menus rendered as flat link lists (footers, utility menus, mega-menu blocks) where the `is-active`/`menu-item--active-trail` classes and auto-expansion are unwanted.

---

- Disable the active trail for a chosen menu.
- Stop parent menu items getting the active-trail class.
- Stop the active item getting the is-active class.
- Prevent children of the active item from auto-expanding.
- Render footer menus without active-state styling.
- Keep utility/mega menus visually neutral.
- Select multiple menus via checkboxes.
- Store the selection in trailless_menu.settings.
- Invalidate menu config cache tags on save.
- Decorate the core menu.active_trail service.
- Avoid custom preprocess code to strip active classes.
- Gate configuration behind 'administer trailless menu'.
- Leave other menus' active trail untouched.
- Support Drupal 8 through 11.
- Apply per-menu, not site-wide.
