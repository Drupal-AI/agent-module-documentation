<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Localized Configuration (localized_config) — agent index

**Developer framework for plugin-based configuration stored globally and/or per language on top of Drupal config.**

- **Version:** 8.x-2.x (info.yml `8.x-2.0-alpha14`)
- **Core:** ^9 || ^10 || ^11 · **PHP:** 8.1
- **Depends on:** `language`, `user`, `file`
- **Configuration:** `localized_config.settings` → `/admin/config/localized/settings`
- **Editing route:** `/admin/config/localized/{language}` (`LocalizedConfigForm`).
- **Services:** `plugin.manager.localized_config`, `localized_config.helper`, `localized_config.language_helper`, Twig extension `localized_config.twig_functions`, and a decorator on `language.config_factory_override`.
- **Permissions:** `access localized config`, `enable localized config plugins`, `access localized config settings`, plus one generated permission per plugin.
- **Security:** route uses `_localized_config_access: 'TRUE'` but that is a **custom access check** (`Access\LocalizedConfigAccess`, tagged `access_check`) requiring the `access localized config` permission and language-membership checks — properly gated, not an open route.

See [plugins/plugin.md](plugins/plugin.md)
