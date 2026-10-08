<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# APCu Diagnostics admin page — route, permission, controller

The module's entire behaviour is one admin page that embeds the `krakjoe/apcu` `apc.php` script.
Read this instead of the source; every claim is from the four YAML files, the controller, and the
test.

## Install / enable

1. Add `krakjoe/apcu` to the project (README method — a `package` repository entry pinning version
   `5.1.23` from `github.com/krakjoe/apcu`, then `composer require krakjoe/apcu`). This puts
   `apc.php` under `vendor/krakjoe/apcu/`.
2. Enable the module: `drush en apcu_diagnostics -y`. It has no core-module dependencies.
3. Grant the permission `access apcu diagnostics` to the roles that should see the page.
4. Visit **`/admin/reports/apcu`** (menu: *Administration → Reports → APCu diagnostics report*).

If `apc.php` is not found at `vendor/krakjoe/apcu/apc.php` (or one directory above `DRUPAL_ROOT`),
the page renders only the message: *"The /vendor/krakjoe/apcu/apc.php file is missing. Please refer
to this module's README.md file."*

## Route (`apcu_diagnostics.routing.yml`)

```
apcu_diagnostics.report:
  path: '/admin/reports/apcu'
  defaults:
    _controller: '\Drupal\apcu_diagnostics\Controller\ApcuDiagnosticsController::content'
    _title: 'APCu Diagnostics'
  requirements:
    _permission: 'access apcu diagnostics'
  options:
    no_cache: 'TRUE'
```

- `no_cache: 'TRUE'` — the page is always rebuilt (live APCu numbers), never served from the render
  cache.
- Access is a single `_permission` check. No `_csrf_token`, no `_format`, no method restriction.

## Permission (`apcu_diagnostics.permissions.yml`)

```
access apcu diagnostics:
  title: 'Access APCu diagnostics'
  restrict access: true
```

`restrict access: true` makes core flag it on the *People → Permissions* page as a security-sensitive
permission (like *administer* permissions). The README explicitly calls it "an administrator-level
permission." Grant it only to trusted operators.

## Menu link (`apcu_diagnostics.links.menu.yml`)

`apcu_diagnostics.report` → title *"APCu diagnostics report"*, parent `system.admin_reports`,
route `apcu_diagnostics.report`, weight 10. Puts the entry on the core *Reports* admin listing.

## Controller (`src/Controller/ApcuDiagnosticsController.php`)

`ApcuDiagnosticsController extends ControllerBase`; method `content(): array`:

1. `$php_self = $_SERVER['PHP_SELF']` then `$_SERVER['PHP_SELF'] = '/admin/reports/apcu'` — apc.php
   derives its own link/form targets from `PHP_SELF`, so it is pointed back at the Drupal route.
2. `define("USE_AUTHENTICATION", 0)` — turns off apc.php's own username/password gate; Drupal's route
   permission is the sole access control. `global $MYREQUEST, $MY_SELF_WO_SORT, $MY_SELF,
   $AUTHENTICATED` are declared because apc.php expects those in global scope.
3. `require`s apc.php from `DRUPAL_ROOT . '/vendor/krakjoe/apcu/apc.php'`, falling back to
   `dirname(DRUPAL_ROOT, 1) . '/vendor/krakjoe/apcu/apc.php'` (project-root vs. docroot layouts).
   apc.php echoes the dashboard HTML itself.
4. Restores `$_SERVER['PHP_SELF']` and returns (`[]` on success, or the missing-file `#markup`).

The rendered dashboard (memory stats, hit/miss, fragmentation, per-entry lists, and apc.php's own
refresh/clear controls) is produced entirely by the third-party `apc.php`, not by this module.

## Test (`tests/Functional/AccessTest.php`)

`AccessTest::testRoutePermissions()` creates a user with `access administration pages` +
`access apcu diagnostics` (expects 200 at `/admin/reports/apcu`) and one with only
`access administration pages` (expects 403). Confirms the permission gate.

## What it does NOT provide

No config objects or schema, no services, no Drush commands, no plugins/plugin types, no hooks, no
entities/fields, no submodules, no libraries, and no Drupal-module dependencies. `krakjoe/apcu` is a
Composer (PHP) dependency only.
