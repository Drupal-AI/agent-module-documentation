<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Kit (decoupled_kit) — agent index

Umbrella kit for decoupled/headless Drupal. The base module resolves a front-end URL path to a
Drupal object and exposes it as a JSON:API resource. Package **Decoupled Kit**. Version **2.0.7**
(doc dir `2.x`). Core `^10 || ^11 || ^12`. License GPL-2.0-or-later.

- **Dependency:** `jsonapi_resources` (hard). No PHP libs, no Composer requires beyond core.
- **Submodules** (own doc trees): `decoupled_kit_block`
  ([modules/decoupled_kit_block/2.x](../../modules/decoupled_kit_block/2.x/agent/start.md)),
  `decoupled_kit_redirect`
  ([modules/decoupled_kit_redirect/2.x](../../modules/decoupled_kit_redirect/2.x/agent/start.md)).

## What it provides (base module)

- **Service** `decoupled_kit` → `Drupal\decoupled_kit\DecoupledKit` (`DecoupledKitInterface`):
  path helpers used by every resource. Methods: `canonicalPath()`, `checkPath(Request)`,
  `getEntityFromPath()`, `getRouteMatchFromPath()`. See
  [api/service.md](api/service.md).
- **JSON:API resource** `Drupal\decoupled_kit\Resource\Router` on route `decoupled_kit.router`
  at `%jsonapi%/decoupled_kit/route` (GET, `_access: TRUE`). Input: `?current_path=`. Output: the
  individual JSON:API document for the routed entity, or 404 with empty data. See
  [api/router.md](api/router.md).
- **Admin form** `Drupal\decoupled_kit\Form\DashboardForm` on route `decoupled_kit.dashboard`
  at `/admin/config/services/decoupled-kit/dashboard` (permission `administer site configuration`,
  menu under Configuration → Web services). Config object `decoupled_kit.config`
  (`current_path`, default `/`). See [config/dashboard.md](config/dashboard.md).
- **Hook** `help` via `Drupal\decoupled_kit\Hook\DecoupledKitHooks` (attribute + `#[LegacyHook]`
  wrapper in `decoupled_kit.module`).
- No permissions of its own, no Drush, no plugin types. Config schema: `decoupled_kit.config`.

## Solution docs

- [api/service.md](api/service.md) — the `decoupled_kit` path-resolution service and its methods.
- [api/router.md](api/router.md) — the Router JSON:API resource: request contract, response, caching.
- [config/dashboard.md](config/dashboard.md) — the Dashboard form, config object, routes & permission.
