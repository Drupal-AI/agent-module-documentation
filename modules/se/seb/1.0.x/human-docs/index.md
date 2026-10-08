# Scheduled Entity Block — manual setup guide

**Scheduled Entity Block** (`seb`) lets you place any content entity — a node,
a media item, and so on — as a block that only appears during a time window you
configure. It adds one block type per content entity type, and each placement can
render the chosen entity in a view mode you pick, showing up only when its
schedule says it should.

The problem it solves is time-limited content placement without custom code.
Want a promotional banner node to run for one week only? A sidebar notice every
Wednesday? A holiday message that appears between two dates? You place a
Scheduled Entity block, point it at the content, and set a schedule — no
visibility PHP required. The schedule can be a daily time window, weekdays only,
weekends only, a between-dates range, or a fully custom per-weekday timetable
with independent start and end times.

The module works through Drupal's normal **Block Layout** UI — there is no
separate settings form to fill in first. It has no module dependencies of its own
and ships no submodules. When the current time falls outside a block's schedule,
the block simply renders nothing. Importantly, visibility still respects access:
a scheduled block only shows if the visitor can actually **view** the target
entity, so unpublished or restricted content stays hidden regardless of the
schedule, and the block inherits the entity's cache tags so it refreshes when the
content changes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no central settings page. Everything happens in **Structure → Block
layout** (`/admin/structure/block`), where you place a **Scheduled Entity block**
into a region and configure it there.

## How to use it

1. Go to **Structure → Block layout** and click **Place block** in the region you
   want.
2. Choose a **Scheduled Entity block** (there is one per content entity type —
   pick the type you want to show).
3. In the block's configuration form, use the **autocomplete** to select the
   specific entity (for example a particular banner node) and choose the **view
   mode** it should render in.
4. Pick a **schedule type** and set its times:
   - **Daily** — visible every day within a start/end time.
   - **Week days** — Monday to Friday.
   - **Weekend days** — Saturday and Sunday.
   - **Between dates** — a single start-to-end date/time range (great for a
     one-week banner).
   - **Custom** — a per-weekday timetable, each day with its own start and end
     time.
5. Save. The block appears only inside its schedule window, and only to visitors
   allowed to view the target entity.

You can place several scheduled blocks in one region for rotating content, or
place the same entity in different regions with different schedules.
