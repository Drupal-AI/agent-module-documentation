<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Environment Context (environment_context) — agent index

Exposes the **current runtime environment** (dev/stage/prod, or any arbitrary key) to Drupal as a
**Context**, a **cache context**, a **condition plugin** and a **typed-data plugin**. Detection is
**event-based and pluggable**. Package `Environment`. Core `^10 || ^11 || ^12`. PHP `>=8.1`.
License GPL-2.0-or-later. Version 1.0.x (installed `1.0.0-rc2`, pre-release).

No routes, no permissions, no config entities, no config schema, no settings form, no Drush, no
`.module` hooks. Base module has **no module dependencies**. Two optional submodules (own doc trees):
- `environment_context_config_split` → registers Config Splits as environments.
- `environment_context_environment_indicator` → registers Environment Indicator entities as environments.

- **Services, detection, resolver, registry, events** → [api/services.md](api/services.md)
- **Condition plugin, `environment` typed-data, `environment` cache context** → [plugins/plugins.md](plugins/plugins.md)

## What it actually is (from source)

- **Detection** happens once per request in `ContextProvider\EnvironmentContext::getCurrentEnvironment()`:
  it dispatches `EnvironmentDetectionEvent` (`environment_context.detect`) and caches the result;
  falls back to `EnvironmentRegistryInterface::DEFAULT_ENVIRONMENT_KEY` = `'default'`.
- The bundled subscriber `EventSubscriber\DefaultEnvironmentDetector::onDetectEnvironment()` sets the
  env from **`Settings::get('environment')`** (settings.php) then **`getenv('DRUPAL_ENVIRONMENT')`**.
  It is **server-side config only** — not read from any request header/host/query.
- `EnvironmentContext` implements both `ContextProviderInterface` (tag `context_provider`, publishes
  Context id `environment`) and `EnvironmentResolverInterface` (aliased). Service
  `environment_context.context.environment`.
- `Environment\EnvironmentRegistry` (service `environment_context.registry`) dispatches
  `AvailableEnvironmentsEvent` (`environment_context.available_environments`) to collect the list of
  known environments + metadata (`label`, and any keys subscribers add).
- Plugins: `Plugin\Condition\EnvironmentCondition` (id `environment`), `Plugin\DataType\Environment`
  (id `environment`), `Cache\EnvironmentCacheContext` (cache context id `environment`).
- `environment_context.install` ships one update hook `environment_context_update_10001()` renaming
  legacy `environment_config_split` → `environment_context_config_split` in `core.extension`.
