# Scheduling — manual setup guide

**Scheduling** (`scheduling`) lets editors control *when* a content entity is
published by attaching a date range to it. Set a start and end date, and the
content goes live and comes down automatically inside that window — ideal for
time-sensitive material like announcements, promotions, or event pages that
should appear and disappear on a schedule without anyone remembering to do it by
hand.

Its standout feature is that it also supports **recurring** schedules. You begin
by picking a date range with Drupal's normal date-range widget (for example
10:00 to 14:00 on a given day), and if that range suits a repeating pattern you
can then choose to repeat it **daily, weekly, monthly, or yearly** — so a piece
of content can, say, be visible every day from 10:00 to 14:00, or on the first of
every month. Whether content is currently "in schedule" is evaluated at runtime,
which means **no cron job is required** and the scheduling is precise to the
second. The access check is query- and cache-aware, so a View that will include
scheduled content in the future can stay fully cached right up until the second
the schedule changes, at which point it is recomputed.

The module works by adding scheduling to content entities and providing the
permissions that govern who may schedule content; it depends on core's **Field**
and **Datetime Range** modules and on the contrib **[Entity](https://www.drupal.org/project/entity)**
API module. It targets Drupal 11.

> **One caveat from the module's own notes:** for Drupal's core *Page Cache* to
> fully respect the cache max-age of scheduled content (or pages that contain it),
> the core patch from issue [#2352009] currently needs to be applied. Without it,
> the runtime scheduling still works, but full-page caching may not expire at the
> exact scheduled second.

This guide is written for a **human** setting things up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm its dependencies.

## How to use it

This module has no central settings page. Once enabled, scheduling becomes
available on content entities: an editor sets a date range on the entity, and
optionally turns that range into a recurring schedule (daily / weekly / monthly /
yearly). The content is then automatically visible only within the scheduled
window. Because the check happens at runtime, there is nothing to run on cron and
no delay — the schedule is honoured to the second. The module also provides
permissions so you can control which roles are allowed to schedule content.
