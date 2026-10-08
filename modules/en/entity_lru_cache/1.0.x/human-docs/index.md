# Entity LRU Cache — manual setup guide

**Entity LRU Cache** (`entity_lru_cache`) is a performance and memory-tuning
module that swaps Drupal's entity **memory cache** for an **LRU** (least-recently-
used) cache. The default memory cache holds every entity loaded during a request
for the lifetime of that request, which is fine for a normal page view but can
balloon memory usage in long-running processes that load enormous numbers of
entities — bulk operations, large migrations, and similar batch work. An LRU cache
instead keeps only a bounded number of entities in memory and evicts the
least-recently-used ones as new ones come in, so memory stays under control.

By default the LRU cache is active **only for CLI processes** (Drush, cron-style
batch work), where runaway memory is most likely, and leaves normal web requests
using the standard cache. You can change that behavior — and the cache size —
through container parameters (see below). This is a low-level infrastructure
module: it adds no admin UI and no content of its own.

Entity LRU Cache runs on Drupal 10.3 and 11 and has no dependencies. Note that at
the time of writing it is an **alpha** release and is **not** covered by Drupal's
security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, enable it, and set
   the container parameters that control the cache.

There is **no admin settings form** for this module — it is configured through
container parameters in a services file, described in Installation.

## Where it lives in the admin menu

Entity LRU Cache adds no admin page. It works transparently once enabled, and its
behavior is tuned through container parameters (a `services.yml`) rather than the
UI.

## How to configure it

Set these container parameters to control the cache:

```yaml
parameters:
  lru_memory_cache_slots: 300
  # Valid values are: cli, on, off
  lru_mode: cli
```

- **`lru_memory_cache_slots`** — how many entities the cache keeps in memory before
  it starts evicting the least-recently-used ones (default `300`).
- **`lru_mode`** — where the LRU cache is active: `cli` (default; only in
  command-line processes such as Drush), `on` (everywhere, including web
  requests), or `off` (disabled).

After changing these, rebuild the cache (`drush cr`) so the container picks up the
new values.
