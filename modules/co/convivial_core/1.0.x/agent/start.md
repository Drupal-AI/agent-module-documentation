<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Convivial Core (convivial_core) — agent index

Tiny base module for the **Convivial CXP** distribution/toolkit (by Morpht). Its entire shipped
function is to create a shared admin landing page for the Convivial stack and one permission to gate it.
Package "Convivial". Version dir **1.0.x** (info.yml `1.0.3`). Core `^9.5 || ^10 || ^11 || ^12`.

## Dependencies
- None outside Drupal core (uses core `system` module's `SystemController`).

## What it provides
- **Route** `convivial_core.admin_convivial` — path `/admin/config/convivial`, title "Convivial CXP",
  controller `\Drupal\system\Controller\SystemController::systemAdminMenuBlockPage` (core). Requires
  permission `access convivial administration pages`. (`convivial_core.routing.yml`)
- **Permission** `access convivial administration pages` (title "Use the convivial administration pages").
  (`convivial_core.permissions.yml`)
- **Menu link** `convivial_core.admin_convivial` under `system.admin_config`, weight `-9`.
  (`convivial_core.links.menu.yml`)

## What it does NOT ship
- No `src/` (no services, controllers, plugins, forms), no `composer.json`, no `*.module`/`*.install`,
  no `config/install` or `config/schema`, no libraries, no Drush commands, no external service calls.
- `tests/modules/convivial_core_test/` is test-only scaffolding (a test route + form), not shipped functionality.

## Solution docs
- [Admin section, route & permission](config/admin-section.md)
