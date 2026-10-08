# Performance Profiler — manual setup guide

**Performance Profiler** (`performance_profiler`) is a small diagnostic tool
that logs how long each page takes to build and how much memory PHP used at its
peak while rendering it. When you are trying to find out which pages on a site
are slow or memory-hungry, those per-page numbers are exactly what you need, and
Drupal does not record them out of the box.

The module also bundles PHP and database benchmarks, so you can compare the raw
performance of different environments (for example, staging versus production,
or two hosting plans) on a like-for-like basis. It was inspired by the older
Memory Profiler module.

Think of it as an investigation aid rather than something you leave running
everywhere. Performance logs accumulate, and verbose logging adds a little
overhead of its own — so it is best enabled while you are chasing a specific
problem and kept quiet the rest of the time. The data it records (timing and
memory) is not sensitive in itself, but timing can act as a mild side-channel,
so keep the logs to operators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. Once enabled it logs page
build time and peak memory; review those entries and the benchmark results, then
disable it again when your investigation is done.

## How to use it

1. Enable the module while you are investigating a performance problem (see
   [Installation](installation/index.md)).
2. Browse the pages you suspect are slow. The module records each page's build
   time and peak memory usage to the log.
3. Review the recorded metrics at **Reports → Recent log messages**
   (`/admin/reports/dblog`) to spot the slow or memory-heavy pages, and run the
   included PHP/database benchmarks when you want to compare environments.
4. When you are finished, disable the module again so it is not logging
   verbosely in production. Keep access to the logs restricted to operators.
