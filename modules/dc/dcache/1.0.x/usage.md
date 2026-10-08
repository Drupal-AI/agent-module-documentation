<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Deterministic Cache API (DCache) is a small developer-facing API for chaining several cache backends together so a value is looked up through a fast tier (e.g. static/memory) before a slower persistent tier, and generated only once on a full miss.

---

A `DCache` object is built from an ordered list of `CacheBackendInterface` instances via `DCacheFactory::get(...)`. Its `lookupOrGenerate(CacheItemGeneratorInterface $generator)` walks the chain: at each backend it tries the generator's cache id, and on a miss recurses to the next backend, finally calling the generator's `getData()` and writing the result back up every tier with the generator's cache tags (permanent). A `lookupOrGenerateMultiple()` variant does the same for lists of ids (`CacheItemListGeneratorInterface` / `CacheItemList`), fetching found items and only regenerating the still-missing ids down the chain. The module registers a ready-made `dcache.bin.default_memory_persistent` service that chains a memory cache with a database-backed persistent cache, plus a `MemoryCacheFactory` workaround service for core issue 2973286.

DCache is aimed at developers writing modules that need layered caching with minimal coordination — it defines no routes, forms, permissions, or user-facing UI. You consume it by injecting a chained DCache service (or building one from the factory) and implementing the generator interfaces for your data. There is no configuration surface and no external network activity.

---

- Chain a memory cache in front of a persistent cache backend.
- Look up a value and generate it only once on a full miss.
- Use the prebuilt `dcache.bin.default_memory_persistent` service.
- Build a custom chain with `DCacheFactory::get(...backends)`.
- Implement `CacheItemGeneratorInterface` for a single cached value.
- Write generated values back up every tier automatically.
- Attach cache tags to generated items for invalidation.
- Look up many ids at once with `lookupOrGenerateMultiple()`.
- Regenerate only the still-missing ids down the chain.
- Merge fetched and regenerated items into a `CacheItemList`.
- Avoid cache-stampede coordination between tiers.
- Inject a chained DCache service into your own module.
- Reduce database cache hits by fronting with a memory tier.
- Store values permanently and rely on tags for invalidation.
- Work around core issue 2973286 via the bundled memory-cache factory.
- Add layered caching without any configuration UI.