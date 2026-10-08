# Layout Builder Admin Theme — agent index

Forces **Layout Builder editing screens** to render in the site's **admin theme** instead of
the front-end theme. One boolean setting, one theme negotiator. Depends on core
`layout_builder`. No permissions of its own, no Drush, no plugins, no config schema.

- **The setting, config object/key, the config form route, and how to toggle it (UI / drush /
  php)** → [configure/settings.md](configure/settings.md)
- **How the theme switch actually happens: the negotiator, its priority, which routes/forms
  trigger it, and which theme it returns** → [api/theme-negotiator.md](api/theme-negotiator.md)

Key facts:
- Setting: `layout_builder_admin_theme.config` → `lbat_enable_admin_theme` (bool, **default
  `true`**). `false` disables the whole behaviour.
- Config form: `/admin/config/content/lbat` (route `layout_builder_admin_theme.lbat_config_form`,
  permission `administer site configuration`).
- Negotiator `LBATAdminNegotiator` (tag `theme_negotiator`, **priority `501`**) applies on
  `RevertOverridesForm`, `DiscardLayoutChangesForm`, and any form id ending `.layout_builder`,
  and switches to `system.theme:admin`.
