<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# access jsonapi permission + route subscriber

Everything this module does. Source: `jsonapi_permission.permissions.yml`,
`jsonapi_permission.services.yml`, `src/Routing/RouteSubscriber.php`.

## Install / enable

- `composer require drupal/jsonapi_permission` then `drush en jsonapi_permission -y`.
- Requires core `jsonapi` (a dependency in `.info.yml`); core `^10.1 || ^11`. No other libraries,
  no install step, no configuration form.
- After enabling, the router is rebuilt and every JSON:API route gains the `access jsonapi`
  requirement automatically. If you enable it manually without a cache rebuild, run `drush cr`.

## The permission

- Defined in `jsonapi_permission.permissions.yml`:

  ```yaml
  access jsonapi:
    title: 'Access JSON:API'
  ```

- Machine name **`access jsonapi`**, title *"Access JSON:API"*. It is **not** flagged
  `restrict access`, so it appears as an ordinary permission on `/admin/people/permissions`.
- No role holds it by default (a fresh permission is granted to no role until you assign it). That
  means once the module is enabled, JSON:API is effectively **denied to everyone** — including the
  decoupled front end and anonymous — until you grant `access jsonapi` to the appropriate role(s).

## The route subscriber

- Service `jsonapi_permission.route_subscriber` (class
  `Drupal\jsonapi_permission\Routing\RouteSubscriber`, tagged `event_subscriber`) extends core
  `RouteSubscriberBase`, so `alterRoutes()` fires during route collection/rebuild.
- Logic in `alterRoutes(RouteCollection $collection)`:
  1. Iterate every route. `if (stripos($key, 'jsonapi') !== 0) continue;` — process **only** routes
     whose **route name** starts with `jsonapi` (case-insensitive, position 0). Core JSON:API routes
     are all named `jsonapi.*`, so this targets them.
  2. Read `$route->getRequirement('_permission')`. If non-empty, append `,access jsonapi`; else set
     it to `access jsonapi`.
  3. `$route->setRequirement('_permission', $permission)`.

## How the AND works (why this is restrictive)

- Core's `Drupal\Core\Access\PermissionAccessCheck` parses `_permission` as: split on `,` → every
  comma-group must be satisfied (**AND**); split each group on `+` → any one satisfies (**OR**).
- Appending `,access jsonapi` therefore ANDs the new permission with whatever the route already
  required. The subscriber never deletes a requirement and never sets `_access: TRUE` — it can only
  make a route **harder** to reach, never easier. JSON:API's own per-entity access checks continue
  to run for anyone who passes the gate.

## Operating it

- Grant `access jsonapi` to the role your headless/decoupled front end (or API service account)
  authenticates as. Leave it off *Anonymous* and *Authenticated* unless you intend browser-reachable
  API access for those roles.
- Verify with an authenticated request that holds the permission (expect 200) and one that does not
  (expect 403), plus an anonymous request to `/jsonapi` (expect 403 unless anonymous was granted).
- Kernel test `tests/src/Kernel/RouteSubscriberTest.php` asserts every `jsonapi*`-named route ends
  up with `access jsonapi` in its `_permission` requirement.

## Limits

- Coverage is by **route name prefix `jsonapi`**, not by handler — routes for JSON:API-style data
  exposed under a different route-name prefix are not gated by this module.
- The permission is coarse (whole-API on/off per role). For finer control (per resource type, per
  method) you still rely on JSON:API's entity access and any complementary access modules.
