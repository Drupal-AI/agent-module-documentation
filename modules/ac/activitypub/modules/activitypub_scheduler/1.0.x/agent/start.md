<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActivityPub Scheduler (activitypub_scheduler) — agent index

Submodule of **activitypub**. Sends/withdraws a node's ActivityPub activities in step with the
Scheduler module's scheduled publish/unpublish.

## Dependencies
`scheduler`, `activitypub`.

## What it provides
- Event subscriber `activitypub.scheduler.node`
  (`src/EventSubscriber/SchedulerNodeSubscriber.php`), args `activitypub.process.client`,
  `entity_type.manager`. Subscribes (only if `Drupal\scheduler\Event\SchedulerNodeEvents` exists):
  - `SchedulerNodeEvents::PUBLISH` → `onSchedulerNodePublish()`: for each outbox
    `activitypub_activity` of the node (`getActivitiesByCollectionEntityIdEntityTypeIdAndStatus(OUTBOX,
    nid, 'node')`), `setPublished()` + `ProcessClient::createQueueItem()`; invalidates `user:<ownerId>`.
  - `SchedulerNodeEvents::UNPUBLISH` → `onSchedulerNodeUnpublish()`: `setUnpublished()->save()` on the
    node's published outbox activities; invalidates `user:<ownerId>`.
- `@ActivityPubType` plugin `activitypub_scheduler` (`src/Plugin/activitypub/type/Scheduler.php`).
- Type config entity `config/install/activitypub.activitypub_type.scheduler.yml`.

## Solution doc
- Scheduler event integration: [agent/integration/scheduler.md](integration/scheduler.md)
