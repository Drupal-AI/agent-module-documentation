<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config override & permissions — Error Level Permission

How the module makes on-screen error verbosity a per-user, permission-driven decision.

## Install / enable

- `composer require drupal/errorlevelpermission` then enable `errorlevelpermission`. Core-only; no
  contrib deps, no libraries, no composer `require` beyond Drupal.
- No configuration to save. Behaviour starts on enable; you only assign permissions
  (People → Permissions, `/admin/people/permissions`, section `#module-errorlevelpermission`).

## The override (`src/ErrorLevelConfigOverride.php`)

Registered in `errorlevelpermission.services.yml` as service `errorlevelpermission.config_override`,
class `ErrorLevelConfigOverride`, tag `config.factory.override`. It implements
`ConfigFactoryOverrideInterface`, so its value is applied every time the config factory loads
`system.logging` — including the value core uses to decide whether to print PHP errors to the page.

- `loadOverrides($names)`: if `system.logging` is among `$names`, sets
  `$overrides['system.logging']['error_level'] = $this->errorLevel()`. No other config is touched.
- `errorLevel()` (protected): reads `\Drupal::currentUser()` and returns the first match:

  | Permission held (checked in this order) | Returned constant | Effect |
  | --- | --- | --- |
  | `errorlevelpermission display verbose` | `ERROR_REPORTING_DISPLAY_VERBOSE` | errors + warnings + notices + backtrace |
  | `errorlevelpermission display all` | `ERROR_REPORTING_DISPLAY_ALL` | errors + warnings + notices |
  | `errorlevelpermission display some` | `ERROR_REPORTING_DISPLAY_SOME` | errors + warnings |
  | none of the above | `ERROR_REPORTING_HIDE` | on-screen errors hidden |

  These constants are defined by Drupal core (`core/includes/bootstrap.inc`). The override is
  unconditional: whatever value an admin set under Configuration → Development → Logging and errors is
  replaced by the permission-derived value for the acting user. A user with no matching permission gets
  `ERROR_REPORTING_HIDE` regardless of the site-wide setting.

- `getCacheableMetadata($name)`: for `system.logging`, adds cache context `user.permissions`, so any
  render/config caching varies by the user's permissions (correct per-user output).
- `getCacheSuffix()`: returns `'errorlevelpermission'` (distinguishes the override in the config cache).
- `createConfigObject($name, $collection)`: returns `NULL` — the override never creates config objects,
  it only rewrites the `error_level` key of an existing one.

## Permissions (`errorlevelpermission.permissions.yml`)

Three static permissions, each `restrict access: TRUE`:

- `errorlevelpermission display some` — "Show errors and warnings".
- `errorlevelpermission display all` — "Show errors, warnings and notices".
- `errorlevelpermission display verbose` — "Show errors, warnings and notices, with backtrace information".

Grant the smallest sufficient one to a trusted role; leave all three off for anonymous, authenticated and
editor roles so those users fall through to `ERROR_REPORTING_HIDE`.

## Logging-settings form tweak (`errorlevelpermission.module`)

`errorlevelpermission_form_system_logging_settings_alter()` replaces the core `error_level` radios on
`/admin/config/development/logging` with a read-only `#type => 'item'` whose description links to the
permissions page (route `user.admin_permissions`, fragment `module-errorlevelpermission`). This is purely
informational — it signals that the value is now controlled by permissions; it does not change behaviour.

## Operating notes

- Nothing to configure: assign a permission and it works. To disable the behaviour, uninstall the module;
  core's `system.logging:error_level` value then applies normally again.
- Priority is highest-verbosity-wins per the `if/elseif` chain, so a role with `display verbose` sees
  backtraces even if it also has the lower permissions.
- Because it overrides for the *current* user on every request, CLI/cron contexts resolve against that
  session's user (typically none → hidden).
