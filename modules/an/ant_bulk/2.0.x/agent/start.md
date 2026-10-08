<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Node Translate Bulk (ant_bulk) — agent index

Bulk companion to **Auto Node Translate**. Translates every existing node of the selected
content type(s) into the selected language(s) using the machine-translation provider that
`auto_node_translate` is already configured with. Runs as a Batch process (one node per
step). Two entry points: an admin form and a Drush command.

- Depends on `auto_node_translate` (composer `drupal/auto_node_translate:^3.0`); core `^10.2 || ^11`.
- Optional integration with `content_moderation` (pick the moderation state of new translations).
- Configure route: `ant_bulk.settings` → `/admin/config/regional/ant-bulk-settings`.
- Defines 1 permission, 1 Drush command, 1 service, 1 alter hook. No plugin types; no config schema.

Solutions:
- **Run a bulk translation from the UI** → [configure/translate.md](configure/translate.md)
- **Restrict runs to published nodes** → [configure/settings.md](configure/settings.md)
- **Run a bulk translation from the CLI** → [drush/commands.md](drush/commands.md)
- **Who may run bulk translation** → [permissions/permissions.md](permissions/permissions.md)
- **Translate programmatically via the service** → [api/services.md](api/services.md)
- **Exclude specific nodes from a run** → [hooks/alter.md](hooks/alter.md)

Key facts:
- Service: `ant_bulk.manager` → `Drupal\ant_bulk\TranslationManager`.
- Reuses `auto_node_translate.translator` — calls `Translator::translateNode($node, $translations)`.
- Routes: `ant_bulk.translate` (`/ant-bulk/translate`, form `TranslateForm`), `ant_bulk.settings` (`/admin/config/regional/ant-bulk-settings`, form `SettingsForm`).
- Permission: `use bulk auto translate` (gates the translate form; `restrict access: true`).
- Config object: `ant_bulk.settings`, single key `status` (bool). No config/schema shipped.
- Drush: `ant_bulk:translate` (alias `anttrans`).
- Alter hook: `hook_ant_bulk_translation_items_alter(array &$nodes)` (UI path only).
- Menu links: both routes appear under `system.admin_config_regional`.
