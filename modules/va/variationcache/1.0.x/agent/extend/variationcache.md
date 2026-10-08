<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extend — VariationCache

## Class-alias compatibility layer (important)

This module ships two copies of every class:

- `Drupal\variationcache\Cache\*` — thin alias stubs (`VariationCache`, `VariationCacheFactory`,
  `CacheRedirect`, plus the two interfaces).
- `Drupal\variationcache\Old\Cache\*` — the real bundled implementation.

At load time, `variationcache.module` and each stub file call `@class_alias(...)`:

- If `\Drupal\Core\Cache\VariationCache` **exists** (Drupal 10.2+), the public
  `Drupal\variationcache\Cache\*` names alias to the **core** classes.
- Otherwise (older core), they alias to the bundled `Old\Cache\*` implementation.

The per-class stub files exist as an extra precaution because the `variation_cache_factory`
service can be instantiated during container build (e.g. in an event subscriber) before the
`.module` file is loaded. Always reference the public `Drupal\variationcache\Cache\*`
namespace (or, on 10.2+, `Drupal\Core\Cache\*`) — never `Old\Cache\*` directly.

The `.services.yml` registers:

```yaml
services:
  variation_cache_factory:
    class: Drupal\variationcache\Cache\VariationCacheFactory
    arguments: ['@request_stack', '@cache_factory', '@cache_contexts_manager']
```

On core 10.2+ this service is already defined by core, so the module effectively just keeps
the old class names resolvable.

## Decorating the factory

Register a decorator to change how variation bins are produced:

```yaml
services:
  my_module.variation_cache_factory:
    class: Drupal\my_module\MyVariationCacheFactory
    decorates: variation_cache_factory
    arguments: ['@my_module.variation_cache_factory.inner', '@request_stack', '@cache_factory', '@cache_contexts_manager']
```

Implement `Drupal\variationcache\Cache\VariationCacheFactoryInterface` (single method
`get($bin): VariationCacheInterface`). Return your own `VariationCacheInterface` to add
logging, metrics, or an alternate redirect strategy around `get`/`set`/`delete`/`invalidate`.

## Subclassing the cache

To customize per-bin behavior, subclass `Drupal\variationcache\Cache\VariationCacheFactory`
and override `get()` so it returns your `VariationCacheInterface` implementation (constructed
from `@request_stack`, the wrapped `CacheBackendInterface`, and `@cache_contexts_manager`).
Keep the `LogicException` contract (folded contexts must be a superset of initial contexts)
and the "skip max-age 0" behavior so callers behave identically to core.

## Migrating off the module

On Drupal 10.2+: uninstall `variationcache`, then rewrite imports/type-hints from
`Drupal\variationcache\Cache\{VariationCache, VariationCacheFactory, VariationCacheInterface,
VariationCacheFactoryInterface, CacheRedirect}` to the matching `Drupal\Core\Cache\*` classes.
Detect eligibility programmatically with `class_exists('\Drupal\Core\Cache\VariationCache')`.
