# Entity Queue Scheduler Field — manual setup guide

**Entity Queue Scheduler Field** (`eqsf`) adds a **field** that lets editors
schedule when an entity should join or leave an **Entityqueue**. Instead of
manually adding and removing content from a queue at the right moment, an editor
sets the queue and the dates on the entity, and the module moves it in and out at
the times given — driven by cron.

The classic use is time-boxing featured or promoted content. For example: a node
that must always stay published, but should appear in the "highlight" queue only
tomorrow between 2pm and 4pm. Put those dates and the target queue in the field,
and the content is added to and removed from the queue automatically at those
times.

It depends on the **Entityqueue** module and supports Drupal 10 and 11. Because the
add/remove happens on cron, you need either regular Drupal cron runs or a scheduler
such as Ultimate Cron.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Entityqueue.

There is **no central settings page** for this module. It works by attaching its
**Entity Queue Scheduler** field to an entity type; the schedule is set per entity
while editing content, so all the setup happens on the field and on the content.

## How to use it

1. Create the **entity queue** you want to schedule into (Structure → Entity
   Queues).
2. On the content type (or other entity type) you want to schedule, add an
   **Entity Queue Scheduler** field.
3. When editing an entity, fill in the field: choose the target queue and the dates
   for adding and/or removing the entity.
4. Save. On the next cron run at or after each scheduled time, the entity is added
   to or removed from the queue accordingly — watch it appear in and disappear from
   the queue as the times pass.
