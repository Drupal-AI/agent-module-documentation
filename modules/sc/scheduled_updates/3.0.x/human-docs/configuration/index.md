# Configuration

Before you can schedule anything, you must create at least one **Scheduled Update
Type**. Everything else follows from that.

## Create a Scheduled Update Type

1. Go to **Configuration → Workflow → Scheduled Updates → Scheduled Update Types**
   (route `scheduled_update.config.overview`).
2. Add a new type. A Scheduled Update Type:
   - can target **only one entity type** to update (for example nodes, users, or
     taxonomy terms);
   - is either **embedded** or **independent** (see below).
3. After creating the type, you are prompted to **choose which fields** from the
   target entity type to include in the update. Those are the fields the scheduled
   update will be able to change.

A quick shortcut for embedded updates: on the **Manage fields** page of the entity
type you want to update, click **Add Update Field** to create an embedded update
type in one step.

## Embedded vs independent updates

- **Embedded updates** appear directly on the add/edit form of the entity they
  will change. Use them when the schedule belongs to a single piece of content —
  for example setting publish and/or unpublish dates on a node form, or setting a
  user to inactive on the user edit form.
- **Independent updates** are created on their own forms, where you select the
  entities to update. A single independent update can target **multiple entities
  at once** — for example a group of nodes to be promoted and published on a
  certain date, or a set of users to be granted a Manager role at the start of next
  month.

Each update is itself an entity, so you can list, revise and review your scheduled
updates before they fire.

## Permissions

The module provides several permissions, including **Administer scheduled update
types**, **Administer scheduled updates** and **View scheduled update entities**.
In addition, it generates **per‑type permissions**, so different teams can be given
control over different kinds of update. Grant these on the **People → Permissions**
page according to who should manage each type.

## The cron caveat — plan for it

Scheduled updates are applied when **cron runs**, not at the exact instant you
configure. If cron runs hourly, a nine‑o'clock embargo cannot be honoured to the
minute. When timing matters — a press release, a regulated disclosure — make cron
frequency your first concern, and confirm what happens to an update whose scheduled
moment passed while cron was not running (it should apply on the next run, but test
this on your site so there are no surprises).
