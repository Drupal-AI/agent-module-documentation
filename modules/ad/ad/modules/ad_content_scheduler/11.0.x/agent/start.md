<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advertisement Content scheduler (ad_content_scheduler) — agent index

Integrates the `ad_content` entity with the contributed **Scheduler** module for automatic
timed publish/unpublish. Package `Advertisement`. Core `^11`. Depends on **`ad`, `ad_content`,
`scheduler`**. License GPL-2.0-or-later. Release 11.0.0-alpha12.

- **Plugin, actions, events, install behavior & the scheduled-ads view** →
  [config/scheduling.md](config/scheduling.md)

## What it provides (from source)

- **Scheduler plugin** `AdContentScheduler` (`src/Plugin/Scheduler/AdContentScheduler.php`,
  `@SchedulerPlugin(id="ad_content_scheduler", entityType="ad_content", …)`) — a thin subclass of
  `scheduler`'s `SchedulerPluginBase` naming the publish/unpublish actions and event class.
- **Action plugins**: `PublishAdContent` (`ad_content_scheduler_publish_ad_content`) and
  `UnpublishAdContent` (`ad_content_scheduler_unpublish_ad_content`) — set published state + save,
  gated by `update` + `status` field access (`src/Plugin/Action/`).
- **Events** `SchedulerAdContentEvents` (`src/Event/`) — the six Scheduler event constants
  (pre/post publish & unpublish, immediate & cron).
- **Install** (`ad_content_scheduler.install`): `hook_install` and `update_11001` set the
  `scheduler` third-party settings (`publish_enable`, `publish_revision`, `unpublish_enable`,
  `unpublish_revision` = TRUE) on every existing `ad_content_type`.
- **Local tasks** derivative `DynamicLocalTasks` (`src/Plugin/Derivative/`) — adds "Overview" +
  "Scheduled Advertisements" tabs under the ad collection **only when** the optional view
  `ad_content_scheduler_scheduled_ad_content` is enabled (avoids a missing-route exception).
- **Config**: schema `config/schema/ad_content_scheduler.schema.yml` (the ad-type third-party
  Scheduler settings) + optional view `config/optional/views.view.ad_content_scheduler_scheduled_ad_content.yml`.
- No routes, services, permissions, or hooks of its own beyond the above.
