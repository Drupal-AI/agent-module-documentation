<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gating mechanism: service, route subscriber, permission checker & Twig

Services are declared in `featureflags_extensions.services.yml`.

## Service — `FeatureFlagsExtensionsService` (`featureflags_extensions.service`)

`src/FeatureFlagsExtensionsService.php`, interface `FeatureFlagsExtensionsServiceInterface`. One method:

```php
getExtension(FeatureFlagInterface $flag, string $extension, bool $create = FALSE): ?ConfigEntityInterface
```

Loads the binding entity of type `$extension` (`featureflags_routes` or `featureflags_permissions`) whose id
equals `$flag->id()`. When `$create` is TRUE and none exists, it creates and saves an empty one. Returns null when
absent and not creating. Injected with `@entity_type.manager`. Used by both the forms and the two gating classes.

## Route gating — `RouteSubscriber` (`featureflags_extensions.route_subscriber`)

`src/Routing/RouteSubscriber.php`, extends `RouteSubscriberBase` (event subscriber, runs during route building).
`alterRoutes(RouteCollection $collection)`:

1. Loads all `featureflag` entities.
2. For each flag whose state is **off** (`!$flag->getState()`), loads its `featureflags_routes` binding via the
   service.
3. Splits the entity's `routes` string on newlines (each line trimmed to a route machine name).
4. For each name present in the collection, sets requirement `_access = 'FALSE'` on that route.

So while a flag is off, its listed routes carry an always-deny access requirement (evaluated together with the
route's own core requirements) and are unreachable; when the flag is on, the subscriber skips it and the routes
keep their normal core access. Injected with `@entity_type.manager` and `@featureflags_extensions.service`. Route
changes take effect on a router rebuild / cache clear after a flag or binding changes.

## Permission gating — `PermissionChecker` (`featureflags_extensions.permission_checker`)

`src/PermissionChecker.php` — a **decorator** of core's `permission_checker` service (`decorates: permission_checker`,
`@.inner` injected, plus `@entity_type.manager`, `@featureflags_extensions.service`, `@access_policy_processor`).

`hasPermission(string $permission, AccountInterface $account): bool`: if `$permission` is in the
"deactivate" list it returns FALSE; otherwise it delegates to the inner core checker. The list is built lazily by
`getPermissionsToDeactivate()`: it iterates all flags, and for each flag that is **off** collects the
`permissions` array from that flag's `featureflags_permissions` binding (the `__` in stored ids is converted back
to `.`). So while a flag is off, the permissions bound to it resolve as not held; when the flag is on they resolve
normally through core.

## Twig extension — `FeatureFlagsTwigExtension` (`featureflags_extensions.twig_extension`)

`src/TwigExtension/FeatureFlagsTwigExtension.php`, extends `AbstractExtension`. Registers one function:

```twig
{% if featureflag_active("demoflag") %} … {% endif %}
```

`featureflag_active($flag_id)` returns `FeatureFlag::isActive($flag_id)` (a boolean flag-state check from the base
module). Use it to render markup conditionally on a flag's state.
