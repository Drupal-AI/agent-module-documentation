<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ad_content_scheduler — Scheduler integration

## Install / enable

`drush en ad_content_scheduler` (pulls in `scheduler`). `hook_install($is_syncing)` — unless
installing via config sync — loads every `ad_content_type` and sets the Scheduler third-party
settings `publish_enable`, `publish_revision`, `unpublish_enable`, `unpublish_revision` to TRUE, so
scheduling + revisioning are on for all existing ad types. `ad_content_scheduler_update_11001()`
re-applies the same for updates. New ad types get the standard Scheduler per-type settings UI.

## Scheduler plugin

`src/Plugin/Scheduler/AdContentScheduler.php`:

```
@SchedulerPlugin(
  id = "ad_content_scheduler",
  entityType = "ad_content",
  dependency = "ad_content",
  schedulerEventClass = "\Drupal\ad_content_scheduler\Event\SchedulerAdContentEvents",
  publishAction = "ad_content_scheduler_publish_ad_content",
  unpublishAction = "ad_content_scheduler_unpublish_ad_content"
)
```

The class body is empty — all behavior comes from `scheduler`'s `SchedulerPluginBase`. This tells
Scheduler to add its "Publish on" / "Unpublish on" fields to the ad edit form and to process ad
content in its cron run.

## Action plugins (`src/Plugin/Action/`)

- `PublishAdContent` (`@Action id="ad_content_scheduler_publish_ad_content" type="ad_content"`):
  `execute()` → `$entity->setPublished(TRUE)->save()`. `access()` requires `update` access AND
  `edit` access on the `status` field.
- `UnpublishAdContent` (`…_unpublish_ad_content`): the mirror image (sets unpublished).

These double as bulk actions ("Publish/Unpublish selected advertisements") and as the actions
Scheduler invokes on cron.

## Events (`src/Event/SchedulerAdContentEvents.php`)

Six constants dispatched around ad (un)publishing, each receiving an `EntityInterface`:
`PRE_PUBLISH_IMMEDIATELY`, `PUBLISH_IMMEDIATELY`, `PRE_PUBLISH`, `PUBLISH`, `PRE_UNPUBLISH`,
`UNPUBLISH` (event names like `scheduler.ad_content_scheduler_publish`). Subscribe to these to react
to scheduled ad state changes.

## Scheduled-ads local tasks

`DynamicLocalTasks` (deriver referenced from `ad_content_scheduler.links.task.yml`) adds "Overview"
and "Scheduled Advertisements" tabs under `entity.ad_content.collection` — but only if the optional
view `ad_content_scheduler_scheduled_ad_content` exists, is enabled, and has an `overview` display
(guarding against a missing-route exception when the view is disabled). Enable that view (shipped in
`config/optional/`) to get the tab.

## Config schema

`config/schema/ad_content_scheduler.schema.yml` types the
`ad_content.ad_content_type.*.third_party.scheduler` mapping (publish/unpublish enable, required,
revision, past-date handling, display mode, etc.) — the standard Scheduler per-type third-party
settings applied to advertisement types.
