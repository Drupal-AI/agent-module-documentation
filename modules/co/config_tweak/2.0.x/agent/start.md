<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Tweak (config_tweak) — agent index
**Removes unwanted/circular config dependencies (entity-reference targets, Entity Browser view widgets) so the config updates report stays clean.**

- **version:** 2.0.x (dev checkout; git branch `2.0.x`)
- **core:** ^10.4 || ^11
- **configure:** `config_tweak.settings` → `/admin/config/development/config_tweak` (`administer site configuration`)
- **classes:** `EntityReferenceItemConfigTweak`, `FieldTypePluginManagerConfigTweak`, `EntityBrowserWidgetViewConfigTweak`.
- **opt-in:** add `dependencies_optional: yes` in a field's `handler_settings` or an Entity Browser widget's `settings`.
- **Security:** single admin settings form gated by `administer site configuration`; no runtime/anonymous routes, no external calls, no data mutation.

See [configure/settings.md](configure/settings.md)
