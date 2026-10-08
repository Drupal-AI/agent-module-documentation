# Memory Profiler — manual setup guide

**Memory Profiler** (`memory_profiler`) is a very lightweight developer tool that
logs the peak PHP memory a request uses to Drupal's log (watchdog). When a site
throws memory-exhaustion errors, it helps you pinpoint *which* pages are hitting
the ceiling and *how much* memory they consume — the kind of insight the Devel
module offers, but without having to enable Devel on a production environment.

The same functionality exists in Devel, but Memory Profiler is deliberately tiny
and safe enough to run briefly in production to catch a real-world memory
problem. Later releases also add optional **memcache profiling**: logging the
size of the objects Drupal sends to memcache on a `cache_set`, which is useful
for tracking down errors like *"object too large for cache."* (You do not need to
enable the Memory Profiler module itself to use the memcache profiling — see the
project's `README_memcache_profiler.txt` for details.)

This is a **diagnostic tool, not a feature module**: it adds no content, no
permissions, and no access role, and it does add a small amount of profiling
overhead to each request. Enable it while you are investigating a memory
problem, read the log entries, and then disable it again — it is best kept to
development/staging or a short, deliberate window on production, not left on
permanently. It has no settings form to configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   while you profile.

There is **no configuration page** for this module — it has no settings form.
Once enabled, it simply starts logging peak memory usage. Read the results in
the log: **Reports → Recent log messages** (`/admin/reports/dblog`), or via
syslog if your site is configured to log there.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Reproduce the pages or operations you suspect of high memory use.
3. Open **Reports → Recent log messages** and look at the peak-memory entries to
   see which paths are the heaviest.
4. When you are done investigating, disable the module again to remove the
   profiling overhead.
