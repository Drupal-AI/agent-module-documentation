Menu Admin per Menu lets you grant roles administration rights over specific menus individually, instead of the all-or-nothing core "Administer menus and menu links" permission.

---

Core Drupal only offers a single `administer menu` permission that hands a role full control over every menu on the site. This module breaks that down: for each menu that exists it dynamically generates an `administer <menu> menu items` permission, so you can, for example, let editors manage the "Main navigation" while leaving other menus untouched. It works by hooking form alters and entity access: it filters the parent-menu options shown on menu link and node forms to only the menus a user is allowed to touch, hides menu metadata fields (id, label, description, langcode) from users lacking full `administer menu`, controls access to `menu_link_content` entities, and re-adds the "List links"/"Add link" operations on the menus overview for delegated users. A route subscriber relaxes core's access checks on the menu UI routes so per-menu admins can reach them. Permissions are computed per user by the `menu_admin_per_menu.allowed_menus` service, and the resulting list can be adjusted with `hook_menu_admin_per_menu_get_permissions_alter()`. It also provides an EntityReferenceSelection handler so menu reference fields respect the same per-menu permissions. There is no configuration UI — you simply assign the generated permissions on the People → Permissions page. Requires core's Menu UI and Menu Link Content modules.

---

- Let content editors manage only the Main navigation menu.
- Give a "Footer editor" role rights to the Footer menu alone.
- Delegate a department's sub-menu to that department's staff.
- Allow adding/editing links in one menu without exposing others.
- Prevent non-admins from renaming or deleting menus while still editing links.
- Restrict the parent-menu dropdown on node forms to permitted menus.
- Hide menus a user can't manage from the menu link parent selector.
- Keep the core `administer menu` permission reserved for true site admins.
- Grant per-menu access to multiple roles with different menu scopes.
- Show the "Add link" / "List links" operations only for a user's own menus.
- Let a microsite team manage its own navigation menu in a shared install.
- Control access to menu reference fields based on per-menu permissions.
- Programmatically grant extra menu permissions via the alter hook.
- Integrate custom menu access logic through the `allowed_menus` service.
- Build editorial workflows where menu structure is delegated but locked.
- Avoid handing out full menu administration to junior editors.
- Support multilingual sites by delegating language-specific menus per team.
- Limit agency clients to editing only their own site menus.
- Enforce least-privilege access to navigation across many roles.
- Hide third-party menu settings from delegated menu editors.
