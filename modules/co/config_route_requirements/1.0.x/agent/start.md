<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Route Requirements (config_route_requirements) — agent index

**info.yml name:** Config Route Requirements — **version:** 1.0.0-alpha1 (version-dir 1.0.x) — **package:** Menu — **core:** ^10 || ^11

**Provides a new `_config` route requirement that removes a route at route-build time when the referenced configuration value(s) evaluate to false.**

## Mechanism
- Single class: `src/EventSubscriber/ConfigRouteSubscriber.php`, a `RouteSubscriberBase` registered as an `event_subscriber` (`config_route_requirements.services.yml`, injected `@config.factory`).
- `alterRoutes()` iterates the `RouteCollection`; for every route that `hasRequirement('_config')` it evaluates the requirement string and, when the result is FALSE, calls `$collection->remove($name)`. A removed route does not exist → 404. It **never adds, weakens, or grants access** — it only removes routes.
- This runs at route rebuild (`drush cr` / cache clear), not per request. It is a feature-flag / toggle primitive, not a runtime access check.

## Requirement syntax (dot-delimited — NOT colon)
Value of `_config` is a full config path: `{config_object_name}.{key}`, e.g. `my_module.settings.feature_enabled`. Internally `explode('.', $req, 3)` → object `my_module.settings`, key `feature_enabled`. Nested keys work via Config dot-notation, e.g. `my_module.settings.group.subkey` → object `my_module.settings`, key `group.subkey`.

Operators (borrowed from core `ModuleRouteSubscriber`):
- `,` = OR — the group is true if any member is true.
- `+` = AND — the whole is true only if every `+`-separated group is true.
- Precedence: split on `+` first, then each group on `,`. So `a,b+c` means `(a OR b) AND c`.
- Each referenced value is cast to boolean; a missing config object/key casts to FALSE (route removed = fail-closed).

Example routing.yml:
```yaml
my_module.debug:
  path: '/my-module/debug'
  defaults:
    _controller: '\Drupal\my_module\Controller\DebugController::report'
  requirements:
    _config: 'my_module.settings.debug_enabled'
    _permission: 'access my module debug'
```

## Facts
- No routes, permissions, services, hooks, forms, config, or UI of its own. `config/` is empty; the config schema in the repo belongs to the bundled **test** submodule only.
- Apply changes with `drush cr` after editing the backing config value.
- **Security:** build-time route removal (404 when the flag is false), not a runtime access grant. `_config` is orthogonal to access — the route author still declares the normal `_permission`/`_access`/`_role` requirements for who may reach the route when it exists.

## Sibling docs
- `../usage.md` — task-oriented one-liners.
- `../human-docs/` — human setup guide + installation.
