# Toastify — agent index

Renders Drupal messages as toast pop-ups (toastify-js). Configured entirely through one
config object `toastify.settings` and gated by the `show toastify messages` permission.
No plugin types, no Drush.

- **Settings keys, the config form, "Enable for" toggles, defaults** →
  [configure/settings.md](configure/settings.md)
- **How messages become toasts (element override, `Drupal.theme.message`, JS API) and permissions** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Config form route: `toastify.settings_form` → `/admin/config/user-interface/toastify`.
- Config object: `toastify.settings` with per-type maps `status`, `warning`, `error`
  (`duration`, `gravity`, `position`, `offsetX`, `offsetY`, `close`, `color`, `color2`,
  `colorProgressBar`, `direction`) plus `enable_for.admin_theme` / `enable_for.frontend_theme`.
- Toasts only render for users with `show toastify messages`; otherwise standard Drupal messages show.
