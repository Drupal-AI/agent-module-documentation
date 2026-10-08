# Code benchmarker — manual setup guide

**Code benchmarker** (`code_benchmarker`) is a **developer-only dashboard** for
comparing the runtime cost of two or more implementations of the same operation —
legacy versus optimised, version A versus version B, before and after a refactor.
Other modules contribute "scenarios" by registering tagged services, and the
dashboard discovers them all, runs each one many times, and shows a timing table
so you can see which approach is actually faster before committing to it.

The most important thing to know is that **this is not for production**. The
dashboard exposes an admin route that runs the work hundreds of times against the
live database. Enable it in development or staging, measure, and disable it again
— it is a profiling tool, not a site feature.

It requires no contributed modules — only core's **Help** and **User** modules
(User is used by the bundled example scenario) — and runs on Drupal 10.3+ or
Drupal 11. Scenarios are defined in code, so getting value from it means either
using the bundled example or writing your own scenario classes in a custom
module. There is no settings form; access to the dashboard is controlled by the
core **Administer site configuration** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (in a non-production environment).

There is **no settings form**. You grant a permission and open the dashboard, as
described in "How to use it" below.

## Where it lives in the admin menu

The dashboard sits at **Configuration → Development → Code benchmarker**
(`/admin/config/development/code-benchmarker`), reachable by users with the
**Administer site configuration** permission.

## How to use it

1. Grant **Administer site configuration** to the roles that should reach the
   dashboard (they usually have it already).
2. Open **Configuration → Development → Code benchmarker**. The index page lists
   every registered scenario and **runs nothing** — it is cheap to load.
3. Click a scenario title to run its iterations and see the per-implementation
   timing table plus a speed-up summary. This is the page that does the work
   against the database.
4. **Tune the iteration count** with a `?iter=N` query parameter on either URL
   (clamped to 10–1000, default 10). Quick-pick `iter=10/100/500/1000` links
   appear next to each scenario and on the results page so you can re-run without
   typing. Re-run with a higher count (e.g. `?iter=500`) when the average and
   median diverge, which signals noisy samples.

## Adding your own scenario

A scenario is a PHP class implementing the module's
`BenchmarkScenarioInterface`, registered as a service tagged
`code_benchmarker.scenario` — no plugin manager, no config, no UI registration.
You implement `id()`, `label()`, `description()`, `prepare()`, `reset()`, and
`implementations()` (a map of label → callable, baseline first), then rebuild
caches (`drush cr`) and reload the dashboard. See the bundled example and the
project's README for a full, copy-pasteable scenario class and guidance on what
belongs in `reset()` so that iteration 1 reflects a real cold-cache request.
