# Moderation Scheduler — manual setup guide

**Moderation Scheduler** (`moderation_scheduler`) lets content editors pick a
future date and time for a node to go live, then publishes it automatically when
that moment arrives — no one has to remember to click "publish." It is built for
editorial teams who prepare content ahead of time and want timed releases,
including overnight campaign launches and coordinated multilingual publishing.

When you enable the module it adds a datetime field, `field_scheduled_time`, to
**every node type** on your site. Editors with the right permission fill that
field on the node form, and on each cron run the module finds nodes whose
scheduled time has passed and transitions them into the published moderation
state (creating a new revision as it does). A distinctive strength is its
multilingual focus: it can schedule the publish status per language revision of a
translated node, which is why it exists alongside other schedulers like Scheduler
or Scheduled Publish.

The module depends only on core (**Datetime, Field, Node, and Views**). It ships
a Views listing (`moderation_scheduler_content`) so you can review pending
content, a manual bulk-publish form, and a `ModerationSchedulerEvent` that other
modules can subscribe to. Both of its routes are permission-gated and all
publishing happens server-side on cron — there is no anonymous or unauthenticated
endpoint.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Heads up — release status:** this branch is marked **Unsupported / Obsolete**
> on drupal.org and is **not covered by Drupal's security advisory policy**. It
> is kept alive mainly to work around a specific issue in other schedulers.
> Evaluate whether a maintained alternative fits your needs before adopting it on
> a new site.
>
> **Heads up — it alters every node type:** enabling the module adds
> `field_scheduled_time` to *all* node types. That is expected behavior, but be
> aware of it before installing on a site with many content types.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the scheduled-time field was added.
2. [Configuration](configuration/index.md) — the settings form, the scheduling
   permissions, the bulk-publish form, and how cron drives publishing.

## Where it lives in the admin menu

- **Settings form:** **Configuration → Content authoring → Moderation
  Scheduler** (`/admin/moderation-scheduler`) — requires the *administer
  moderation_scheduler module* permission (marked restricted).
- **Manual bulk publish:** `/admin/content/scheduled/publish` — requires the
  *edit moderation scheduler field* permission.
- **Scheduled-content listing:** a Views view named
  `moderation_scheduler_content` lists content awaiting publication.

## How to use it

1. Give the editors who should schedule content the **edit moderation scheduler
   field** permission.
2. When creating or editing a node, fill in the **Scheduled time** datetime
   field with the future moment the content should go live.
3. Ensure **cron runs regularly** — publishing happens on cron, so the accuracy
   of your timed releases depends on how often cron fires.
4. Review or force-publish pending items from the bulk-publish form at
   `/admin/content/scheduled/publish`, or watch the provided Views listing.
