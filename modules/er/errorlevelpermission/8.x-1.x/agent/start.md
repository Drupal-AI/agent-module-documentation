<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Error Level Permission (errorlevelpermission) — agent index

Overrides Drupal's on-screen error-display level (`system.logging:error_level`) **per user, by permission**
instead of one site-wide value. Depends only on Drupal core. No settings form, no config objects, no
plugin types, no Drush. Core `^8.7.7 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 8.x-1.4.

- **The config override, the three permissions, the level mapping, caching, and how to operate it** →
  [config/override.md](config/override.md)

## What it actually is (from source)

- One service, `errorlevelpermission.config_override` (`errorlevelpermission.services.yml`), tagged
  `config.factory.override`, class `Drupal\errorlevelpermission\ErrorLevelConfigOverride`
  (`src/ErrorLevelConfigOverride.php`, implements `ConfigFactoryOverrideInterface`).
- `loadOverrides()` overrides only `system.logging` → sets `error_level` to `errorLevel()`.
- `errorLevel()` reads `\Drupal::currentUser()` and returns, in priority order:
  `ERROR_REPORTING_DISPLAY_VERBOSE` (perm `errorlevelpermission display verbose`),
  `ERROR_REPORTING_DISPLAY_ALL` (`errorlevelpermission display all`),
  `ERROR_REPORTING_DISPLAY_SOME` (`errorlevelpermission display some`),
  else `ERROR_REPORTING_HIDE` (no permission → errors hidden). This fully takes over the core value.
- `getCacheableMetadata('system.logging')` adds the `user.permissions` cache context; `getCacheSuffix()`
  returns `errorlevelpermission`; `createConfigObject()` returns NULL (override-only, creates nothing).

## Permissions (`errorlevelpermission.permissions.yml`)

Three, **all `restrict access: TRUE`**:
- `errorlevelpermission display some` — Show errors and warnings.
- `errorlevelpermission display all` — Show errors, warnings and notices.
- `errorlevelpermission display verbose` — Show errors, warnings and notices, with backtrace information.

## Other code

- `errorlevelpermission.module`: `hook_form_system_logging_settings_alter()` replaces the core
  "Error messages to display" radios with an `item` linking to the permissions page (fragment
  `#module-errorlevelpermission`). Cosmetic only — the value now comes from the override.
- `tests/src/Functional/AdminPageTest.php`: one smoke test (admin `/admin` returns 200).
