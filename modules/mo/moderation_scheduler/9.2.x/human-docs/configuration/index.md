# Configuration

Moderation Scheduler has three moving parts you configure: the **permissions**
that decide who can schedule and who can administer, the **settings form**, and
the **cron** that actually publishes content. The manual **bulk-publish form** is
a handy fourth piece for pushing due items through by hand.

## Set the permissions

Go to **People → Permissions** (`/admin/people/permissions`) and grant, per role:

- **Edit moderation scheduler field** — lets a role set the scheduled time on the
  node form and use the manual publish form. Give this to your content editors.
- **Administer moderation_scheduler module** — access to the settings form below.
  This permission is marked **restricted**, so grant it only to trusted
  administrators.

## Open the settings form

1. Log in as a user with the **Administer moderation_scheduler module**
   permission.
2. Go to **Configuration → Content authoring → Moderation Scheduler**, or
   navigate directly to `/admin/moderation-scheduler`.

This form (the `ModerationScheduleForm`) is where you review and adjust the
module's behavior. Save your changes with **Save configuration**.

## Schedule content on the node form

Once the *edit moderation scheduler field* permission is in place, editors set a
publish time simply by filling in the **Scheduled time** datetime field that the
module added to the node edit form. Save the node as usual — the module takes it
from there on the next cron run.

## How publishing happens (cron)

Publishing is driven by cron, not by an immediate action:

- On each cron run, `moderation_scheduler_cron()` calls the module's service to
  find nodes whose **Scheduled time** has passed.
- Each due node is transitioned into the **published** moderation state, and a
  **new revision** is created to record the change.

Because of this, the precision of your timed releases depends on how frequently
cron runs. If content must go live close to an exact minute, schedule cron to run
often (for example every minute via a system cron job) rather than relying on
Drupal's default automated cron.

## Manual bulk publish

If you need to push due items through without waiting for cron — or to review what
is pending — use the manual publish form at
`/admin/content/scheduled/publish` (the `ModerationSchedulePublishForm`). It
requires the **edit moderation scheduler field** permission. A provided Views
listing (`moderation_scheduler_content`) also shows content awaiting
publication so you can audit the queue.

## Extending it (for developers)

The module dispatches a `ModerationSchedulerEvent` around its processing. Other
modules can subscribe to it (via the event dispatcher) to run custom logic when
content is scheduled or published — for example notifying a channel or updating a
related record. This is optional and requires custom code.
