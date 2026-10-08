<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feature Flags Extensions (featureflags_extensions) — agent index

Add-on for the contrib **Feature Flags** (`featureflags`) module. It lets each feature flag gate **routes** and
**permissions**, and exposes a Twig helper to test a flag's state. License GPL-2.0-or-later. Version 2.0.0.
Core `^11`. No settings form of its own (`configure` is null) — bindings are edited on each flag.

## Dependencies

- `drupal:featureflags` — provides the `featureflag` config entity, its edit form/UI and `FeatureFlag::isActive()`.
  Composer `drupal/featureflags:^2.0`.

## What it provides (from source)

- **Two config entity types** that store per-flag bindings, keyed by the flag id, both exported to config:
  - `featureflags_routes` (`src/Entity/FeatureflagsExtensionsRoutes.php`) — a newline-separated `routes` string;
    admin CRUD gated by `administer featureflags_extensions_routes`.
  - `featureflags_permissions` (`src/Entity/FeatureflagsExtensionsPermissions.php`) — a `permissions` array;
    admin CRUD gated by `administer featureflags_extensions_permissions`.
  → [config/entities.md](config/entities.md)
- **Two per-flag forms** (added as tabs/operations on every `featureflag` via `hook_entity_type_alter` /
  `hook_entity_operation` in `featureflags_extensions.module`), both gated by the base module's
  `administer featureflag entities`:
  - `RoutesForm` (`src/Form/RoutesForm.php`) at `/admin/structure/feature-flags/manage/{featureflag}/routes`.
  - `PermissionsForm` (`src/Form/PermissionsForm.php`) at `.../permissions`.
  → [config/entities.md](config/entities.md)
- **Route gating**: `RouteSubscriber` (`src/Routing/RouteSubscriber.php`) — for every flag whose state is OFF,
  marks its bound routes unavailable. → [api/gating.md](api/gating.md)
- **Permission gating**: `PermissionChecker` (`src/PermissionChecker.php`), a decorator of core's
  `permission_checker` service — makes a flag's bound permissions unavailable while the flag is OFF.
  → [api/gating.md](api/gating.md)
- **Service** `featureflags_extensions.service` (`FeatureFlagsExtensionsService`) — loads (optionally creates) the
  extension config entity for a flag. → [api/gating.md](api/gating.md)
- **Twig extension** `FeatureFlagsTwigExtension` — registers `featureflag_active(flag_id)`. → [api/gating.md](api/gating.md)

## What it does NOT provide

No settings form/route, no controllers, no Drush, no blocks, no external HTTP or credentials, no submodules.
Config schema is shipped (`config/schema/featureflags_extensions.schema.yml`) for the two entity types.

## Install / operate

1. `composer require drupal/featureflags_extensions` (pulls `drupal/featureflags`).
2. `drush en featureflags_extensions -y`.
3. Edit a flag under **Configuration → Development → Feature Flags**; use the **Routes** and **Permissions**
   tabs/operations to bind route machine names and permissions to that flag. Bindings export to config.
