<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Updater (entity_updater) — agent index

**Mass-updates entities by enqueuing a plain re-save per entity, run from code or Drush.**

- **Version:** 1.0.x  •  core: `^8 || ^9 || ^10 || ^11`  •  package: Queues
- **API class:** `Drupal\entity_updater\EntityUpdater` — `enqueueAll($type,$bundle)`, `enqueueUpdate($entity)`, `enqueueUpdateById($type,$id)`.
- **Queue worker:** `entity_updater` (`EntityUpdaterQueueWorker`, cron time = 30s); loads entity, skips if deleted/changed since enqueue, disables new revision, calls `save()`, resets cache.
- **Drush:** `entity-updater:enqueue <entity_type> [bundle]` (aliases `entity_updater:enqueue`, `euq`); run `drush queue-run entity_updater` to process.
- **Routes/permissions/config:** none.

**Security:** no web routes, forms, permissions or config — CLI/code-only surface. `enqueueAll()` runs its entity query with `accessCheck()` enabled. No mutating HTTP endpoint; a non-admin cannot trigger updates over the web.

See [api/entity-updater.md](api/entity-updater.md)
