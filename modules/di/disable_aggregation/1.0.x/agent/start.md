<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable Aggregation (disable_aggregation) — agent index

Tiny developer/debugging module: disables CSS and JS aggregation at runtime **only for authenticated users**, leaving anonymous traffic on the normal aggregated bundles.

## What it is
- A single `config.factory.override` service, no UI, no routes, no permissions, no config schema, no settings form.
- Enabling the module is the entire configuration. Uninstall to revert — nothing persists.
- Core requirement `^8 || ^9 || ^10 || ^11 || ^12`; `require` is empty (no Composer deps, no Drupal module deps).

## How it works
- `Drupal\disable_aggregation\DisableAggregationConfigOverrides` (src/DisableAggregationConfigOverrides.php), registered in `disable_aggregation.services.yml` as `disable_aggregation.config_overrider` with tag `config.factory.override` (priority 5).
- `loadOverrides()`: when the name list includes `system.performance` and `\Drupal::currentUser()->isAuthenticated()`, it overrides `system.performance` with `css.preprocess = FALSE` and `js.preprocess = FALSE`.
- `getCacheableMetadata()`: adds cache context `user.roles:authenticated`, so anonymous users still get the aggregated variant.
- `createConfigObject()` returns NULL; `getCacheSuffix()` returns `'DisableAggregationConfigOverrider'`.

## Provides
- Entities: none. Plugins: none. Routes: none. Permissions: none. Drush: none. Config schema: none.
- Services: `disable_aggregation.config_overrider` (config override).

## Solution docs
- [Config override behavior & operation](config/override.md)
