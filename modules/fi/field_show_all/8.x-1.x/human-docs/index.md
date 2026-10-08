# Field Show All — manual setup guide

**Field Show All** (`field_show_all`) is a **field formatter** that keeps long
multi‑value fields tidy. Instead of printing every value at once, it displays only
the first **N** items and adds a **"show all"** link; click it and the rest appear,
with a **"show less"** link to collapse them again. It's a text‑link take on the
[Field Load More](https://www.drupal.org/project/field_load_more) module — the same
idea, but using plain text links rather than a button.

It's a pure display formatter with no content or access role of its own, and it
works on any multi‑value field. You configure it per display, so the same field can
show all its values in one view mode and collapse to a few in another.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** for this module. You choose the
formatter and set the item limit on a field's display, described in "How to use
it" below.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage display** (or the
   Manage display screen of any fieldable entity).
2. Find a **multi‑value** field and, in its **Format** column, choose the
   **Field Show All** formatter.
3. Open the formatter's settings (the gear icon) and set how many items to show
   before the "show all" link appears.
4. Click **Update**, then **Save**.

On the rendered page the field now shows just the first N values with a **show
all** link; expanding reveals the rest, and a **show less** link collapses them
back.
