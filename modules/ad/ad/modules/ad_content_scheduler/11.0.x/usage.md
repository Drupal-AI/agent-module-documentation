<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrates advertisement content with the Scheduler module so ads can be published and unpublished automatically on set dates.

---

`ad_content_scheduler` connects the `ad_content` entity to the contributed **Scheduler** module. It
registers a `SchedulerPlugin` for the `ad_content` entity type, plus publish/unpublish action
plugins and the six standard Scheduler events, so ads gain the familiar "Publish on" / "Unpublish
on" date fields on their edit form and are (un)published by Scheduler's cron run. On install (and
via an update hook) it enables scheduled publishing, scheduled unpublishing, and revision-on-schedule
third-party settings for every existing advertisement type. It requires `ad`, `ad_content`, and
`scheduler`. When the optional "Scheduled Advertisements" view is enabled, it also adds a local-task
tab listing scheduled ads.

---

- Schedule an advertisement to go live automatically at a future date/time.
- Schedule an advertisement to be taken down automatically at a future date/time.
- Run a fixed-term ad campaign without manually publishing/unpublishing.
- Get "Publish on" and "Unpublish on" fields on the ad edit form.
- Create a new revision automatically whenever an ad is (un)published on schedule.
- Enable scheduling on all existing ad types in one install step.
- React to ad publish/unpublish with the six `SchedulerAdContentEvents` (pre/post, immediate/cron).
- View a "Scheduled Advertisements" tab listing ads with pending schedule dates.
- Require a scheduling date on certain ad types via Scheduler's per-type settings.
- Coordinate ad go-live with editorial embargoes using Scheduler's shared workflow.
- Bulk-publish selected ads with the "Publish selected advertisements" action.
- Bulk-unpublish selected ads with the "Unpublish selected advertisements" action.
- Let Scheduler's cron drive ad state changes instead of a custom cron job.
- Keep ad publication timing consistent with the rest of a Scheduler-managed site.
- Time seasonal or promotional banners to appear only during a set window.
