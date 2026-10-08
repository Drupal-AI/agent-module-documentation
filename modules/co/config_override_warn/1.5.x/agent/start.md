<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Override Warn — agent index

Adds a **warning message** to any configuration form whose config is currently overridden
(`settings.php` `$config[…]`, or a module tagged `config.factory.override`). No routes, no
permissions, no plugins, no Drush, **no settings form** (`configure: null`).

- **The one setting (`show_values`) and how to change it without a UI** →
  [configure/settings.md](configure/settings.md)
- **The `config_override_warn.form_overrides` service, how detection works, and the theme
  hook** → [api/overrides-service.md](api/overrides-service.md)

Key facts:

- Config object: `config_override_warn.settings`, single key `show_values` (boolean, default `true`).
- Service id: `config_override_warn.form_overrides` (class `Drupal\config_override_warn\FormOverrides`).
- Theme hook: `config_override_warn_overrides`, template `templates/config-override-warn-overrides.html.twig`.
- It only inspects forms that either extend `ConfigFormBase` (reflects the protected
  `getEditableConfigNames()`) or are an `EntityForm` for a **saved** config entity.
