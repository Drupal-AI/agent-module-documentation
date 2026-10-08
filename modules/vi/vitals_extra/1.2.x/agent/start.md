<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vitals extras (vitals_extra) — agent index

Adds four read-only site-status checks to the **Vitals** health-check framework (`drupal/vitals`,
2.2+). It defines **no** plugin type of its own — instead it supplies four plugins of Vitals' own
`VitalsCheck` type (annotation `@VitalsCheck`, discovery dir `src/Plugin/VitalsCheck/`, manager
`plugin.manager.vitals_check`). Each plugin's `getData()` reads core/config/state values and returns
a small associative array. The checks are turned on individually on the **Vitals** settings page
(`/admin/config/services/vitals`, config key `vitals.settings:vitals_enabled_plugins`) and their
results are emitted by Vitals' own token-protected JSON endpoint `/vitals/{token}`, keyed by plugin
id — vitals_extra has no routes, services, permissions, config schema, hooks, or drush of its own.

- Depends on: `vitals:vitals` (composer `drupal/vitals: ^2.2`). The individual checks also *soft*-read
  other modules when present (`symfony_mailer`, `environment_indicator`, `devel`, `stage_file_proxy`,
  `shield`, `reroute_email`/`symfony_mailer_reroute`, `mailsystem`, `swiftmailer`, `smtp`,
  `phpmailer_smtp`) via `moduleHandler->moduleExists()` — none are hard dependencies.
- Core: `^8.9 || ^9 || ^10 || ^11`. Package: `Security`.
- No settings page / `configure` route of its own (configuration lives on the parent Vitals form).
  No permissions, no config schema, no drush, no plugin types defined here.
- Base class: `Drupal\vitals_extra\VitalsExtraPlugin` (extends Vitals' `VitalsCheckPluginBase`,
  implements `ContainerFactoryPluginInterface`; injects `config.factory` + `module_handler`).

## What you'd do → where

- **Enable/read the four checks, know exactly which config each reads and the JSON shape it returns** →
  [plugins/vitals-checks.md](plugins/vitals-checks.md)
- **Write another Vitals check** → same file; the pattern is: extend `VitalsExtraPlugin`, add a
  `@VitalsCheck` annotation, implement `getData()`.

## Key facts (real machine names)

- Plugin type consumed (defined by `vitals`, NOT here): `VitalsCheck` — annotation
  `Drupal\vitals\Annotation\VitalsCheck`, interface `Drupal\vitals\VitalsCheckInterface`, manager
  service `plugin.manager.vitals_check`, discovery dir `Plugin/VitalsCheck`, alter hook
  `vitals_check_info`.
- Plugin ids provided here (files under `src/Plugin/VitalsCheck/`):
  - `update_status` (`UpdateStatus.php`) → `{interval, emails_list, emails_status}`.
  - `environment_indicator` (`EnvironmentIndicator.php`) → `{name, release}`.
  - `dev_modules` (`DevModules.php`) → `{devel, stage_file_proxy, shield, reroute_email}` (bools).
  - `mail` (`Mail.php`) → `{provider, transport}`.
- Base class: `Drupal\vitals_extra\VitalsExtraPlugin`. Note `EnvironmentIndicator` does **not** extend
  it — it extends `VitalsCheckPluginBase` directly and additionally injects the `state` service.
- Turned on/off via parent Vitals config: route `vitals_settings` (`/admin/config/services/vitals`,
  permission `administer vitals`), config `vitals.settings:vitals_enabled_plugins` (a sequence where a
  check is enabled when its key maps to its own id).
- Output exposed via parent route `vitals.content` (`/vitals/{token}`,
  `Drupal\vitals\Controller\VitalsController::output`) as a `JsonResponse`; the collector is
  `Drupal\vitals\Vitals::getStatus()`, which calls each enabled plugin's `getData()`.
