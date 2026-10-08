<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActivityPub Scheduler — Scheduler integration

## Enable
`drush en activitypub_scheduler` (requires the contrib `scheduler` module). Configure a content type
for both Scheduler (publish/unpublish dates) and ActivityPub (an `activitypub_dynamic_types` type
mapping the node bundle to a `Note`). No settings form of its own.

## How it works (`src/EventSubscriber/SchedulerNodeSubscriber.php`)
`getSubscribedEvents()` registers handlers only when
`class_exists('Drupal\scheduler\Event\SchedulerNodeEvents')`, so the module is inert if Scheduler's
event class is unavailable.

- **On scheduled publish** (`SchedulerNodeEvents::PUBLISH` → `onSchedulerNodePublish($event)`):
  loads the node's outbox activities via
  `ActivityStorage::getActivitiesByCollectionEntityIdEntityTypeIdAndStatus(COLLECTION_OUTBOX, $nid,
  'node')`, then for each: `$activity->setPublished()` and
  `ProcessClient::createQueueItem($activity)` (enqueues delivery to followers). Invalidates cache tag
  `user:<node ownerId>`.
- **On scheduled unpublish** (`SchedulerNodeEvents::UNPUBLISH` → `onSchedulerNodeUnpublish($event)`):
  loads the node's **published** outbox activities (status filter `1`) and
  `$activity->setUnpublished()->save()` so they are no longer delivered. Invalidates `user:<ownerId>`.

## Result
Federation timing follows the node's Scheduler dates: nothing is pushed to the Fediverse until the
scheduled publish moment (when the activity is queued through the normal outbox pipeline), and a
scheduled unpublish withdraws the activities. Actual delivery still runs through the parent module's
outbox queues (cron handler or `drush activitypub:*`).

## Notes
- The `scheduler` ActivityPub type entity ships in `config/install/` so the plugin is available after
  install; there is no submodule-specific config schema (it uses the parent type schema).
