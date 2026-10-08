# Entity Updater — manual setup guide

**Entity Updater** (`entity_updater`) mass‑updates entities by queuing a plain
re‑save (`$entity->save()`) for each one and processing the queue on cron or via
Drush. It solves a common maintenance need: forcing every entity of a type or
bundle back through its normal save path — so computed fields recalculate, newly
added field defaults populate, and presave/insert hooks (search index, Pathauto,
cache tags) fire — without writing a throwaway script and without running out of
memory on a large site.

It is deliberately a **command‑line and code tool**: there is **no web route, form,
permission, or settings page**. You drive it either from the Drush command it
provides or by calling its small helper class from custom code. Enqueued items land
in a reliable `entity_updater` queue, and the queue worker (with a 30‑second cron
time budget) loads each entity, skips it if it was deleted or changed since it was
enqueued, disables new‑revision creation so revision history isn't bloated, calls
`save()`, and resets the storage cache to free memory. Because the worker makes no
field changes, it is safe to re‑run.

The module works on enable — there's nothing to configure. It has no dependencies
beyond core, and its `enqueueAll()` runs its entity query with access checking
enabled. The optional **Queue UI** (`queue_ui`) module is handy for watching queue
depth while it drains.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it is driven entirely from
Drush or PHP code, as described in *How to use it* below.

## How to use it

There are no admin screens. Enqueue work, then let the queue drain:

- **Enqueue every entity of a bundle:** `drush entity-updater:enqueue node page`
  (alias `euq`).
- **Enqueue all entities of a type (no bundle filter):**
  `drush entity-updater:enqueue taxonomy_term` — or `drush entity-updater:enqueue user`.
- **Drain the queue immediately:** `drush queue-run entity_updater` — or let cron
  process it gradually (about 30 seconds of work per run).

From custom code, use the `Drupal\entity_updater\EntityUpdater` helper:

- `EntityUpdater::create()->enqueueAll('node', 'article');` — enqueue a whole bundle.
- `EntityUpdater::create()->enqueueUpdate($entity);` — enqueue a loaded entity.
- `EntityUpdater::create()->enqueueUpdateById('node', 42);` — enqueue by type and ID.

Re‑running is safe: entities changed after they were enqueued are skipped, and the
worker never creates new revisions. Install **Queue UI** if you'd like to watch the
queue depth in the browser.
