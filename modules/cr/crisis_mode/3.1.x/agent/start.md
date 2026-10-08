<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crisis Mode (crisis_mode) — agent index

Adds one configurable, site-wide "crisis" block that an administrator can enable/disable to broadcast an urgent message. Core `^8.8.0 || ^9.0 || ^10 || ^11`. Version dir 3.1.x (installed 3.1.0). License GPL-2.0-or-later.

## What it provides
- **Block plugin** `crisis_mode_block` (`src/Plugin/Block/CrisisModeBlock.php`, admin label "Crisis Mode Block"). Rendered via the `crisis_mode` theme hook (`crisis_mode_theme()` in `crisis_mode.module`) and `templates/crisis-mode.html.twig`; attaches library `crisis_mode/crisis_mode` (CSS only).
- **Settings form** `\Drupal\crisis_mode\Form\CrisisModeSettingsForm` (`getFormId()` = `crisis_mode_settings`), a `ConfigFormBase` editing `crisis_mode.settings`.
- **Config object** `crisis_mode.settings` (default in `config/install/`, schema in `config/schema/crisis_mode.schema.yml`; config-translation enabled via `crisis_mode.config_translation.yml`).
- **Drush command** `crisis-mode` (alias `crisis`) — `src/Commands/CrisisModeCommands.php`, registered as service `crisis_mode.commands` in `crisis_mode.services.yml`.
- **Block instance** `crisismodeblock` created disabled on install (`crisis_mode.install`), deleted on uninstall.

## Route & permission
- Route `crisis_mode.settings` → `/admin/config/system/crisis_mode`, requires permission `administer crisis mode` (`crisis_mode.permissions.yml`, `restrict access: TRUE`). Also a menu link (`links.menu.yml`) and local task (`links.task.yml`).

## Dependencies (implicit — none declared in info.yml)
Uses core `block` (Block entity), `image` (ImageStyle), `path_alias` (AliasManager), `node`, and `file` at runtime. Drush is required for the CLI command.

## Solution docs
- [Settings & config object](config/settings.md) — form fields, `crisis_mode.settings` keys, schema, install/uninstall behaviour.
- [Block plugin & theming](plugins/block.md) — how the block builds content, image/color preprocessing, Twig template, multilingual overrides.
- [Enable/disable API & Drush](api/toggle.md) — how crisis mode is switched on/off (form submit and `drush crisis-mode`).
