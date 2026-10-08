<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Locale: Config import — agent index

Controls whether interface (locale) translations are overwritten when configuration is imported. Works
by swapping core's `locale.config_subscriber` / `locale.config_manager` services for its own. Depends
on core `language`, `locale`, `config`. One config object, one permission, no plugins, no Drush.

- **The three settings, the context option, the config object, permission & the service swap** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config route `config_import_locale.settings` → `/admin/config/regional/translate/config-import-settings`
  (tab under Translate interface), permission `administer config import locale`.
- Config object `config_import_locale.settings`: `overwrite_interface_translation`
  (`default` | `no_overwrite` | `nothing`) and `overwrite_context` (`cli` | `ui` | empty = everywhere).
- `src/ConfigImportLocaleServiceProvider.php` repoints `locale.config_subscriber` →
  `ConfigImportLocaleSubscriber` and `locale.config_manager` → `ConfigImportLocaleConfigManager`.
- `ConfigImportLocaleSubscriber::saveCustomizedTranslation()` branches on the setting; `no_overwrite`
  only writes when there is no existing (non-empty) translation.
