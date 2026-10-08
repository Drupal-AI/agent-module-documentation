# Toolbar Menu Clean — agent index

Hides three core Toolbar elements (Administration/Manage tray, Shortcuts tab, contextual Edit
button) from users who lack matching permissions. Pure `hook_toolbar_alter()`; no config UI
(`configure` null), no config schema, no services. Depends on `toolbar_menu`. It is a
visibility cleanup, not access control — the admin routes themselves stay permission-gated by core.

- **The three permissions, what each hides, and the exact alter behaviour** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- One hook in `toolbar_menu_clean.module`: `toolbar_menu_clean_toolbar_alter(&$items)`.
- Missing `show administration menu in the toolbar` → `administration` item gets a
  `visually-hidden` wrapper class; its tray is copied to `$items['tray']` and
  `admin_toolbar/toolbar.tree` is re-attached.
- Missing `show shortcut menu in the toolbar` → `shortcuts` item is unset.
- Has `access contextual links` but missing `show edit button in the toolbar` → `contextual`
  item is unset.
