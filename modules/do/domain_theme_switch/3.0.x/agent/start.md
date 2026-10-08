<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Theme Switch (domain_theme_switch) — agent index

Per-domain site + admin theme for Domain Access sites. One form, no config of its own in 3.x, no
permissions, no config schema, no Drush. Requires `domain` and **`domain_config`**.

- **The form, where the values actually live, and how to set them from Drush** →
  [configure/per-domain-theme.md](configure/per-domain-theme.md)

Key facts:
- Route `domain_theme_switch.settings` — `/admin/config/domain/domain_theme_switch/config`,
  permission **`administer domains`** (Domain Access's, not this module's). `configure` in
  info.yml points here.
- **3.x stores nothing in `domain_theme_switch.settings`.** Values are written as per-domain
  overrides of core's `system.theme` through `domain.config_factory_override`:
  `getOverrideEditable($domain_id, 'system.theme')->set('default', …)->set('admin', …)->save()`.
  Unchecking the override calls `getOverride($domain_id, 'system.theme')->delete()`.
- **The override row's existence is the on/off switch**, not its contents. `domain_config` 3.x
  writes diff-based overrides, so choosing a theme equal to the baseline stores an empty row
  (`{}`) that is still "enabled". Both `buildForm()` and `submitForm()` use
  `StorageInterface::exists()` for that signal — replicate this if you script the config.
- Theme application is done entirely by `domain_config`'s config override service. There is **no
  theme negotiator** in this module (2.x had one), and `domain_config_ui` is not required.
- Select options come from `theme_handler->listInfo()` — **installed** themes only. Site defaults
  are read from `config.storage` (`system.theme`), with `admin` treated as optional (`?? ''`).
- With zero domain entities the form renders only a "Zero domain records found" message and no
  submit button.
- Updates: `update_10001()` migrates 2.x keys `{domain}_site` / `{domain}_admin` from
  `domain_theme_switch.settings` into overrides, then deletes that config object;
  `update_10002()` revokes the obsolete `domain administration theme` permission from all roles.
  `#[Hook('update_requirements')]` hard-fails updates if `domain_config` is not enabled.
- Hooks live in OO classes (`src/Hook/`) registered as services, with `#[LegacyHook]` /
  `#[LegacyRequirementsHook]` bridges in the `.module`/`.install` for Drupal < 11.3.
