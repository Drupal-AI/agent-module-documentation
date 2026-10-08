<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# APCu Diagnostics (apcu_diagnostics) — agent index

A one-controller bridge that renders the `krakjoe/apcu` package's bundled `apc.php` monitoring
dashboard as a Drupal admin report at **`/admin/reports/apcu`**. No config, no services, no schema,
no submodules, no Drush. Core requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0.

- **The route, permission, controller mechanism, and the apc.php dependency** →
  [config/admin-page.md](config/admin-page.md)

## What it actually is

- One route: `apcu_diagnostics.report` (`apcu_diagnostics.routing.yml`) →
  path `/admin/reports/apcu`, `_controller`
  `\Drupal\apcu_diagnostics\Controller\ApcuDiagnosticsController::content`,
  requirement `_permission: 'access apcu diagnostics'`, option `no_cache: 'TRUE'`.
- One permission: **`access apcu diagnostics`** (`apcu_diagnostics.permissions.yml`), title
  *"Access APCu diagnostics"*, `restrict access: true` — an admin-level permission.
- One menu link: `apcu_diagnostics.report` (`apcu_diagnostics.links.menu.yml`) under
  `system.admin_reports` (*Administration → Reports*), weight 10.
- One controller: `ApcuDiagnosticsController` extends core `ControllerBase`; single method
  `content(): array` in `src/Controller/ApcuDiagnosticsController.php`.
- One test: `tests/Functional/AccessTest.php` (`AccessTest::testRoutePermissions`) — asserts 403
  without the permission, 200 with it.
- **No** `.module`/`.install` file, **no** `composer.json`, **no** `config/`, **no** `*.services.yml`,
  **no** plugins, hooks, entities, or fields.

## Mechanism (from source)

`ApcuDiagnosticsController::content()`:
- Saves `$_SERVER['PHP_SELF']`, overrides it to `/admin/reports/apcu` (apc.php uses PHP_SELF to build
  its own links), then restores it before returning.
- `define("USE_AUTHENTICATION", 0)` — disables apc.php's built-in login page; Drupal's route
  permission is the access gate instead. Declares `global $MYREQUEST, $MY_SELF_WO_SORT, $MY_SELF,
  $AUTHENTICATED` for apc.php.
- Locates apc.php at `DRUPAL_ROOT . '/vendor/krakjoe/apcu/apc.php'` or one level up
  (`dirname(DRUPAL_ROOT, 1) . '/vendor/...'`) and `require`s it; the script echoes the dashboard
  directly. If neither path exists, returns `#markup` telling the operator the file is missing.

## Dependency & operation

- **`krakjoe/apcu`** must be Composer-installed (README documents adding it as a `package`
  repository, version 5.1.23, then `composer require krakjoe/apcu`). It is NOT a Drupal module
  dependency and NOT declared in any composer.json here.
- Enable the module, grant `access apcu diagnostics`, browse *Reports → APCu diagnostics report*.
