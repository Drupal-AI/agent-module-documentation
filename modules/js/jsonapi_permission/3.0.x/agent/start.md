<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Permission (jsonapi_permission) — agent index

Adds one permission, **`access jsonapi`**, and requires it on every core JSON:API route so the API
can be allowed or denied per role. Version **3.0.0**. Core `^10.1 || ^11`. Depends only on core
**`jsonapi`**. License GPL-2.0-or-later. Package: none.

- **The whole mechanism, install/enable, the permission, coverage and how to operate it** →
  [access/route-subscriber.md](access/route-subscriber.md)

## What it actually is

- **One permission:** `access jsonapi` (title *"Access JSON:API"*), declared in
  `jsonapi_permission.permissions.yml`. Not marked `restrict access`.
- **One service:** `jsonapi_permission.route_subscriber` → `Drupal\jsonapi_permission\Routing\RouteSubscriber`
  (`jsonapi_permission.services.yml`), tagged `event_subscriber`. Extends core `RouteSubscriberBase`.
- **No routes, no controllers, no entities, no plugins, no config, no schema, no hooks, no Drush,
  no install file.** The `.info.yml`, a permissions YAML, a services YAML and one PHP class are the
  entire module.

## Mechanism (from source)

- `RouteSubscriber::alterRoutes(RouteCollection $collection)` runs at route-rebuild time. For each
  route it skips any whose **route name does not begin with `jsonapi`** (`stripos($key, 'jsonapi') !== 0`).
- On matching routes it reads the existing `_permission` requirement; if non-empty it appends
  `,access jsonapi` (comma = **AND** in core's `PermissionAccessCheck`), otherwise it sets
  `_permission` to `access jsonapi`. It only ever **adds** a required permission — it never removes
  a requirement or grants access.
- Net effect: a user must hold `access jsonapi` **in addition to** whatever the route already
  required, and JSON:API's per-entity access still applies on top. The permission is a coarse gate
  in front of the API, not a replacement for entity access.

## Coverage / caveats

- Only routes whose **name** starts with `jsonapi` are gated (core names all JSON:API routes
  `jsonapi.*`). A custom module that exposes JSON:API-style routes under a different route-name
  prefix would not be covered.
- Granting `access jsonapi` to *Anonymous* restores the pre-module behaviour (API reachable by
  anyone). Denying it to the role your decoupled front end authenticates as breaks that front end.
  Test both the front end and an anonymous browser after changing the grant.
