# Tab Toolbar — agent index

Moves page local task tabs (primary/secondary) into a "Page Actions" tray in Drupal's admin
toolbar via `hook_toolbar()`. Depends on core `toolbar`. One config flag; no permissions of its
own, no services, no plugins, no Drush.

- **The single setting, config key, default hide-on-admin-theme behavior, and template override** →
  [configure/settings.md](configure/settings.md)

Key facts:
- `configure` route: `tab_toolbar.settings_form` at `/admin/config/tab_toolbar/settings`
  (permission `administer site configuration`).
- Config object `tab_toolbar.settings`, key `admin.enabled` (bool, default `FALSE`).
- Toolbar item id `primary_tasks`; tabs pulled from `plugin.manager.menu.local_task` for the
  current route (levels 0 and 1). Cache contexts `user.permissions`, `url.path`, `theme`.
- Theme hook `tab_toolbar` (`primary`, `secondary` vars) → `templates/tab-toolbar.html.twig`.
- When core `contextual` is NOT enabled, attaches library `tab_toolbar/tab_toolbar` for icon CSS.
- By default tabs are suppressed when the active theme equals the configured admin theme unless
  `admin.enabled` is TRUE.
