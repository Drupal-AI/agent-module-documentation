<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backstop Generator — settings & config objects

## Install / enable
`drush en backstop_generator`. Depends on core `breakpoint`, `node`, `path_alias`. `hook_install()`
(`backstop_generator.install`) calls `backstop_generator.viewport_generator::createViewportsForTheme()`
on the default theme, so viewports for the default theme exist immediately after enable.
`hook_update_10001` normalises legacy integer `debug`/`debugWindow` to booleans in the defaults config.

## Settings form
`Form\SettingsForm` (`getFormId(): backstop_generator_settings`), route
`backstop_generator.settings_form` at `/admin/config/development/backstop-generator`, requirement
`_permission: administer site configuration` (also the module's `configure` link). Editable config:
`backstop_generator.settings`. It builds three sections via the `form_builder` service
(`Services\BackstopFormBuilder`): URL section, Profile Parameters, Scenario Defaults. On submit it maps
form values to config via `$configMap`, saves, then calls `updateProfiles()` which rewrites the
`backstop.json` of every profile whose `useProfileDefaults` is set (via `BackstopProfile::generateBackstopFile()`).

Note: the `backstop_directory` field is rendered `disabled` (fixed at `/tests/backstop`);
`createBackstopDirectory()` only prepares a new dir if the stored value differs.

## Config objects (simple config, not entities)
- `backstop_generator.settings` — active settings. Keys: `backstop_directory` (string, default
  `/tests/backstop`, a path relative to `dirname(DRUPAL_ROOT)` = the project root, one level above the
  docroot), `test_domain`, `reference_domain`, `profile_parameters` (mapping), `scenarioDefaults` (mapping).
- `backstop_generator.settings.defaults` — shipped defaults (`config/install/`), same shape plus
  `profile_parameters.debug` / `debugWindow`.

`profile_parameters` mapping: `onBeforeScript` (bool), `onReadyScript` (bool), `paths` (string, `key|value`
lines), `report` (string, default `browser`), `asyncCaptureLimit` (int, 5), `asyncCompareLimit` (int, 50),
`engine` (`puppeteer`|`playwright`), `engineOptions` (string, default `--no-sandbox`).

`scenarioDefaults` mapping: `delay`, `misMatchThreshold`, `requireSameDimensions`, plus the full BackstopJS
selector/interaction knob set (`hideSelectors`, `removeSelectors`, `cookiePath`, `readyEvent`,
`readySelector`, `readyTimeout`, `keyPressSelectors`, `hoverSelector(s)`, `clickSelector(s)`,
`postInteractionWait`, `scrollToSelector`, `selectors`, `selectorExpansion`, `expect`, `gotoParameters`).

## Schema
`config/schema/backstop_generator.settings.schema.yml` types `backstop_generator.settings` (as
`config_entity`) and `backstop_generator.settings.defaults` (`config_object`). Per-entity schema lives in
`backstop_generator.profile.schema.yml`, `.scenario.schema.yml`, `.viewport.schema.yml`.

## Domains
`BackstopFormBuilder::buildUrlSection()` defaults `test_domain` to the current
`getSchemeAndHttpHost()` and requires both `test_domain` and `reference_domain` (no trailing slash).
These are prepended to every generated scenario URL/referenceUrl by `ScenarioGenerator`.
