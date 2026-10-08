<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toastify (toastify) — agent index

Renders Drupal messages as toast pop-ups (bundled toastify-js v1.12.0). Configured entirely
through one config object `toastify.settings` and gated by the `show toastify messages`
permission. No entities, no plugin types, no services, no Drush.

- **Settings keys, the config form, "Enable for" toggles, defaults, drush/PHP** →
  [configure/settings.md](configure/settings.md)
- **How messages become toasts (element override, `Drupal.theme.message`, JS API) and permissions** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Config form route: `toastify.settings_form` → `/admin/config/user-interface/toastify`
  (`Drupal\toastify\Form\SettingsForm`, permission `administer toastify configuration`).
  Menu link `toastify.settings` under Configuration › User interface.
- Config object: `toastify.settings` with per-type maps `status`, `warning`, `error`
  (`duration`, `gravity`, `position`, `offsetX`, `offsetY`, `close`, `color`, `color2`,
  `colorProgressBar`, `direction`) plus `enable_for.admin_theme` / `enable_for.frontend_theme`.
- Element override: `hook_element_plugin_alter()` replaces core `status_messages` with
  `Drupal\toastify\Element\ToastifyStatusMessages`.
- Libraries (`toastify.libraries.yml`): `toastify/library` (toastify-js + CSS), `toastify/toastify`
  (attach), `toastify/toastify.messages` (client Message API override), `toastify/gin`.
- Toasts only render for users with `show toastify messages` and never on AJAX/XHR responses;
  otherwise standard Drupal messages show.
- Update hooks in `toastify.install`: `toastify_update_8001`–`8003` (position/offset/enable_for migrations).
