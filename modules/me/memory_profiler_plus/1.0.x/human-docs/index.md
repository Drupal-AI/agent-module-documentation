# Memory Profiler Plus — manual setup guide

**Memory Profiler Plus** (`memory_profiler_plus`) is a developer tool for
profiling memory usage that records its data in a **database table** rather than
just the log. For each path it captures the number of requests plus the minimum,
maximum, and last-seen memory values — so you can see, at a glance, which pages
and operations are the memory-heavy ones over time. It is based on the original
[Memory Profiler](https://www.drupal.org/project/memory_profiler) module by Drew
Webber (mcdruid), and it also keeps that module's habit of adding the request's
memory usage to the response header.

The problem it solves is reporting. The original module logs profiling data to
DBLog or syslog, which is limiting if you rely on DBLog: you are stuck reading
individual entries, DBLog may be capped to a low number of rows, and profiling
entries clutter your real log. Memory Profiler Plus instead writes to its own
table and ships a **View** for examining the collected data, so you get a proper
per-path report.

This is a **diagnostic tool, not a feature module** — it adds no content-access
role. Because it records profiling data on *every* request into the database, it
adds overhead and grows data over time, so treat it the way you would any
profiler: run it on development/staging, or briefly in production for a specific
investigation, and clean up the recorded data afterward rather than leaving it
running permanently.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   while you profile.

There is no separate configuration chapter — the module's small settings form is
described under "How to use it" below.

## How to use it

Once installed, the module has two admin pages:

1. **Enable, disable, or reset profiling** — go to **Configuration →
   Development → Memory Profiler Plus**
   (`/admin/config/development`). From this settings dialog you can turn
   profiling on or off, and **truncate** (clear out) the profiling data that has
   accumulated. Turn profiling on when you start an investigation.
2. **View the results** — go to **Reports → Memory Profiler Plus**
   (`/admin/reports`) to see the profiled requests: which paths were hit, how
   often, and their minimum/maximum/last memory usage.

When you have finished, disable profiling from the settings dialog and truncate
the collected data to keep the table from growing.
