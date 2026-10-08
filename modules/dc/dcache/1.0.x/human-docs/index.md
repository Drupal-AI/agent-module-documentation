# Deterministic Cache API (DCache) — manual setup guide

**Deterministic Cache API** (`dcache`) is a small **developer-facing** API for
chaining several cache backends together so a value is looked up through a fast
tier (for example a static/memory cache) before a slower persistent tier, and
generated only once on a full miss. It's aimed at developers writing modules that
need layered "lookup-or-generate" caching without the coordination headaches that
usually come with it — there is no admin UI, no settings, and nothing user-facing.

The idea is straightforward. You build a `DCache` object from an ordered list of
cache backends (fastest first). When you ask it for a value, it walks the chain:
at each backend it tries the cache id, and on a miss recurses to the next tier;
only when every tier misses does it call your generator's `getData()` — then it
writes the result back up through *every* tier with your cache tags, permanently.
There's a single-item path (`lookupOrGenerate`) and a multi-item path
(`lookupOrGenerateMultiple`) that fetches the ids it finds and only regenerates the
ones still missing. The module ships a ready-made service that chains a memory
cache in front of a database-backed persistent cache, plus a small memory-cache
factory that works around a core issue.

Because it's a service-only API, you "use" it by injecting a chained DCache service
(or building one from the `dcache.factory` service) and implementing the generator
interfaces for your data. It defines no routes, forms, permissions, or external
network activity.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (usually as a dependency of a module that uses it).

There is **no configuration page** for this module — it has no settings form,
routes, or admin UI. It's consumed entirely from code.

## How to use it

DCache is for developers. In short:

- Inject the prebuilt `dcache.bin.default_memory_persistent` service (memory in
  front of a database-backed persistent cache), or build a custom chain with
  `\Drupal::service('dcache.factory')->get($fastBackend, $slowerBackend, …)` —
  backends are tried in the order given.
- Implement `CacheItemGeneratorInterface` for a single value (or
  `CacheItemListGeneratorInterface` for a list) to supply the cache id, cache tags,
  and the generator that produces the data.
- Call `lookupOrGenerate()` / `lookupOrGenerateMultiple()`; generated values are
  stored permanently and invalidated through the cache tags you return.

The full method signatures and a worked example are in the
[`agent/`](../agent/start.md) reference (`agent/api/dcache.md`).
