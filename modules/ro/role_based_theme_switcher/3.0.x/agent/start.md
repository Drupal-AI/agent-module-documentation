# Role Based Theme Switcher — agent index

Assigns a front-end theme per user role via a theme negotiator (priority 10). Highest-weight matching
role wins for multi-role users. Config UI at `/admin/config/system/role_based_theme_switcher/settings`
(`configure` = `role_based_theme_switcher.settings`, permission `administer site configuration`).
No own permissions, no Drush, no config schema (untyped config).

- **The settings form, config structure, weight/priority resolution, admin-route behavior, and code
  entry points** → [configure/settings.md](configure/settings.md)

Key facts:
- Service `theme.negotiator.role_based_theme_switcher` (`src/Theme/RoleNegotiator.php`), tag
  `theme_negotiator` priority 10.
- Config: `role_based_theme_switcher.RoleBasedThemeSwitchConfig` → key `roletheme` = map
  `role_id => { id: <theme_machine_name>, weight: <int> }`.
- On admin routes, if the user has `view the administration theme`, the negotiator does NOT apply
  (admin theme wins); elsewhere the role theme applies.
- Saving the form runs `drupal_flush_all_caches()`. Built-in defaults use legacy `seven`/`bartik`
  names — pick real installed themes.
