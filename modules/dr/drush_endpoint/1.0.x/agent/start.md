<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush Endpoint (drush_endpoint) — agent index

A **testing-only** HTTP endpoint that runs a fixed allowlist of Drush commands over `POST /api/drush/{command}`.
Meant for automated test suites (e.g. Cypress/CI) that cannot call Drush directly. Package `Testing`.
Version dir **1.0.x** documents the pre-release **1.0.0-rc1**. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later.
Requires the Composer package `drush/drush` `^12 || ^13`. No module dependencies, no admin UI, no permissions,
no config, no Drush commands of its own.

The endpoint is **off by default** — it does nothing until you opt in via settings flags
(`$settings['drush_endpoint_enabled']`, and `$settings['drush_endpoint_allow_uli']` for the `uli` command).
The maintainer's documentation states it is for isolated dev/CI environments only and must never be enabled
on production.

## What it provides

- **Route** `drush_endpoint.execute`: `POST /api/drush/{command}` → `DrushController::executeCommand`
  (`drush_endpoint.routing.yml`). `_custom_access: 'drush_endpoint.access_checker:access'`;
  route option `_auth: ['basic_auth']`.
- **Access checker** service `drush_endpoint.access_checker`
  (`src/Access/DrushEndpointAccessChecker.php`) — gates the route on the settings flags and the
  command allowlist.
- **Controller** `DrushController` (`src/Controller/DrushController.php`) — thin wrapper that calls the
  executor and returns a `JsonResponse`.
- **Executor** service `drush_endpoint.executor`
  (`src/Service/DrushExecutor.php`) — runs `drush <command>` via Symfony Process and returns the result.
- **Hook** `DrushEndpointHooks::help()` (`src/Hook/DrushEndpointHooks.php`, OO `#[Hook('help')]`) —
  a one-line help text on the module's help page.
- **Command allowlist**: `cr`, `cron`, `uli`, `mim`, `mr`, `sapi-i`, `sapi-r`.

## Solution docs

- **The route + how the endpoint is gated (access checker, settings flags, allowlist)** →
  [api/endpoint-and-access.md](api/endpoint-and-access.md)
- **The request → command → Drush execution flow (controller + executor)** →
  [api/controller-and-executor.md](api/controller-and-executor.md)
- **The `hook_help()` implementation** → [api/hook.md](api/hook.md)
