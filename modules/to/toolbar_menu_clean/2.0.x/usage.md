Toolbar Menu Clean hides the core Toolbar's Administration (Manage) tray, the Shortcuts tab, and the contextual Edit button from users who lack purpose-built permissions, so a custom Toolbar Menu can stand alone.

---

Companion to the [Toolbar Menu](https://www.drupal.org/project/toolbar_menu) module. It implements a single `hook_toolbar_alter()` that inspects the current user's permissions and conditionally removes or visually hides three built-in toolbar elements. Users without *Show Administration menu in the toolbar* get the `administration` item wrapped in a `visually-hidden` class (its tray is preserved under a plain `tray` key, and the `admin_toolbar/toolbar.tree` library is re-attached so any surviving child menus still expand). Users without *Show Shortcut menu in the toolbar* have the `shortcuts` item unset entirely. Users who can *access contextual links* but lack *Show Edit button in the toolbar* have the `contextual` (Edit) item unset. There is no configuration form (`configure` is null) and no config schema — behaviour is driven purely by the three permissions it defines. Grant the permissions to the roles that should keep the standard toolbar; leave them off for roles that should see only the Toolbar Menu links. Note this is a UI-visibility cleanup, not an access-control mechanism — the underlying admin routes remain reachable by permission.

---

- Give editors a clean toolbar that shows only a curated Toolbar Menu instead of the full Manage tray.
- Hide the core Administration (Manage) menu from a role while keeping it for administrators.
- Remove the Shortcuts toolbar tab for roles that should not manage shortcuts.
- Strip the contextual-links Edit pencil button from the toolbar for specific roles.
- Present a simplified back-end navigation to client/content roles without touching their actual permissions.
- Keep the admin_toolbar tree behaviour working for any child menu items that remain visible.
- Let a custom Toolbar Menu (from the toolbar_menu module) be the primary navigation by hiding the default admin tray.
- Differentiate toolbar contents per role using three granular permissions.
- Reduce visual clutter for authenticated users who only need a handful of toolbar links.
- Hide the Manage menu but still allow contextual editing where the Edit button permission is granted.
- Show the Shortcuts menu only to power users who have been granted the shortcut permission.
- Roll out a role-specific toolbar experience without writing custom code.
- Combine with Toolbar Menu to build a fully bespoke administrative navigation bar.
- Prevent junior editors from being distracted by the full site-administration menu.
- Selectively re-enable the standard administration menu for a support role via one permission.
- Provide a per-role edit-button toggle so only some roles see contextual editing controls.
- Ensure the toolbar tree JS still loads for visible menu children after the admin item is hidden.
- Use permission assignment (not config) to control which toolbar elements each role sees.
- Tidy the toolbar for multi-role sites where different teams need different toolbar sets.
- Serve as a lightweight, config-free complement to admin_toolbar and toolbar_menu setups.
