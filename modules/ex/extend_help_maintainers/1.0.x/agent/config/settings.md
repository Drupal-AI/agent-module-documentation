<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings form

## Install / enable
`drush en extend_help_maintainers -y`. No dependencies, no install hooks. Once enabled, every module's Help page (`/admin/help/<module>`) that yields maintainers gains the block automatically — no per-module setup beyond declaring maintainers (see api/extending.md).

## Settings route
- Route id `extend_help_maintainers.settings` → `/admin/config/system/extend-help-maintainers` (`extend_help_maintainers.routing.yml`).
- Handler: `_form: \Drupal\extend_help_maintainers\Form\ExtendHelpMaintainersSettingsForm`, title "Extend Help Maintainers Settings".
- Access: `_permission: 'administer site configuration'` (core permission; the module defines no permissions of its own).
- Linked from `.info.yml` `configure:` key.

## Config object
`extend_help_maintainers.settings` (schema `config/schema/extend_help_maintainers.schema.yml`, type `config_object`):
- `selected_plugins` — sequence of enabled fetcher plugin IDs (strings). Consumed by `MaintainersService::buildMaintainersBlock()`: a plugin only runs if its ID is in this list (`in_array($plugin_id, $selected_plugins, TRUE)`). No `config/install/` default ships, so `selected_plugins` is unset until saved — meaning the block shows nothing until an admin visits the form and saves (the form defaults the checkboxes to all discovered plugins via `array_keys($options)`).
- `plugin_priorities` — mapping of `plugin_id => integer`. Overrides the annotation `priority` used both for run/sort order and for merge precedence.

## Form behaviour (`ExtendHelpMaintainersSettingsForm`, extends `ConfigFormBase`)
- `getFormId()` → `extend_help_maintainers_settings_form`; `getEditableConfigNames()` → `['extend_help_maintainers.settings']`.
- Injects `extend_help_maintainers.maintainers_fetcher_manager` via `create()`.
- `buildForm()`:
  - `selected_plugins` — `checkboxes`, options = every discovered fetcher (`getSortedDefinitions()`), each labelled by its annotation `label`. Default = saved value or, if none, all plugins.
  - `priorities` — a `#tree => TRUE` fieldset of one `number` field per plugin (`#min => 0`, `#step => 1`). The field shows the current override only if it differs from the annotation default; otherwise it is left blank and the description reads "Default: <n>. <description>".
- `submitForm()`:
  - `selected` = `array_filter($form_state->getValue('selected_plugins'))` (drops unchecked boxes).
  - `plugin_priorities` = only fields where the value is non-empty and non-null, cast to `(int)`; blank fields fall back to the annotation default at read time.
  - Saves `selected_plugins` and `plugin_priorities`, then `parent::submitForm()`.

## Operating notes
- Priority resolution at render time (`MaintainersService`): `custom_priorities[$plugin_id] ?? $definition['priority'] ?? 0`.
- Plugins are attempted in descending priority (`MaintainersFetcherManager::getSortedDefinitions()`); a thrown fetcher is logged to `logger.channel.extend_help_maintainers` and skipped, so one failing source never breaks the page.
- Uninstalling removes only `extend_help_maintainers.settings`; no other config is touched.
