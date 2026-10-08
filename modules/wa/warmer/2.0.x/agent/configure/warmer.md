<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Warmer

## Config object

All warmers share **one** config object: **`warmer.settings`**. It has a single top-level
key `warmers`, a sequence keyed by plugin id:

```yaml
warmers:
  entity:
    id: entity
    frequency: 900      # seconds between automatic re-enqueues on cron
    batchSize: 25       # items enqueued/processed per batch
    entity_types: { 'node:article': 'node:article' }
    published_only: true
  cdn:
    id: cdn
    frequency: 600
    batchSize: 50
    urls: { 0: 'https://example.com/', 1: '/about' }
    headers: {  }
    verify: true
    maxConcurrentRequests: 10
```

Install default is empty: `warmers: []`. Every warmer plugin contributes `id`, `frequency`
(default `300`) and `batchSize` (default `50`); submodules add their own keys (documented in
each submodule's `configure` doc). Each plugin's mapping is validated by the config schema
`warmer.settings.warmer_plugin.<id>`.

### Read / set with Drush

```bash
drush cget warmer.settings warmers                      # show all configured warmers
drush cget warmer.settings warmers.entity.frequency     # one value
drush cset warmer.settings warmers.entity.frequency 3600 -y
drush cset warmer.settings warmers.entity.batchSize 100 -y
```

The admin settings form always writes **every** warmer's full mapping at once; setting a
single leaf with `drush cset` (or `config.factory` in `php:eval`) is fine for scripted
configuration and is read back the same way by the plugins.

## Admin UI

| Route | Path | Purpose |
|---|---|---|
| `warmer.settings` | `/admin/config/development/warmer/settings` | Configure each warmer (frequency, batch size, plugin-specific fields). This is the module's `configure` route. |
| `warmer.enqueue` | `/admin/config/development/warmer` | "Warm caches" form — manually enqueue selected warmers now. |

Menu link "Cache warming" lives under *Configuration › Development*. Both routes require the
core permission **`administer site configuration`** — Warmer defines no permissions of its
own.

## Automatic warming (cron)

`warmer_cron()` calls `HookImplementations::enqueueWarmers()` on every cron run. A warmer is
only re-enqueued when `isActive()` is true — i.e. when more than `frequency` seconds have
passed since its last enqueue (tracked in state key
`previous_enqueue_time:<id>`). So `frequency` is an effective *minimum interval*; the actual
cadence is bounded by how often cron runs. Enqueued batches sit in the `warmer` queue and
are drained by the queue worker on subsequent cron runs (or immediately via
`drush warmer:enqueue <id> --run-queue`).
