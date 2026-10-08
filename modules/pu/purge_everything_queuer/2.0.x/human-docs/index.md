# Purge Everything Queuer — manual setup guide

**Purge Everything Queuer** (`purge_everything_queuer`) is a small helper for the
Purge framework with two jobs. First, it registers an **"Everything" queuer** — a
Purge queuer plugin that lets you queue a single "invalidate everything" object
instead of thousands of individual tag or URL invalidations. Second, and just as
important on a busy site, it adds a **cron safeguard**: if the purge queue ever
grows past 100,000 items, cron automatically clears it and drops in one
everything-invalidation, so a runaway queue can never halt your purge processing.

There is no settings form and no admin UI — the behavior is automatic once the
module is enabled, plus a service other code can call. The queuer only acts when
you have an active **purger that supports "everything" invalidation**; if none
does, it quietly does nothing rather than erroring.

It depends only on the **Purge** module (`purge`) and runs on Drupal `^9.3 ||
^10`. It pairs naturally with **Purge control**, which uses it to restart a purge
process that was stopped because the queue filled up.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Purge.

There is **no configuration page** for this module — it has no settings form. Its
behavior is automatic (via cron) plus an exposed service, described in "How to
use it" below.

## Where it lives in the admin menu

Purge Everything Queuer adds no admin page of its own. The **Everything queuer**
it provides appears in Purge's own configuration at **Configuration → Development
→ Performance → Purge** (`/admin/config/development/performance/purge`), where you
add and manage queuers. See the
[Purge documentation](https://www.drupal.org/project/purge) for setting up
queuers, queues, and processors.

## How to use it

- **Automatic queue protection.** Once enabled, `hook_cron()` checks the queue on
  each cron run. If it holds 100,000 or more items, the module empties the queue,
  adds a single everything-invalidation, reloads Purge's diagnostics to clear the
  "queue full" error, and (if a cron purge processor exists) triggers it. You do
  not have to configure anything for this.
- **Queue everything from code.** The module exposes a service you can call from
  custom code, ECA, or a Drush script to flush the queue and enqueue one
  everything-invalidation:

  ```php
  \Drupal::service('purge_everything_queuer.everything')->queueEverything();
  ```

  By default this clears all existing items in the queue first. It safely no-ops
  if no active purger supports everything invalidation.

> **Compatibility note:** to work correctly alongside Purge Queues, the module's
> project page notes a patch may need to be applied. Check the
> [project page](https://www.drupal.org/project/purge_everything_queuer) if you
> use non-default queue backends.
