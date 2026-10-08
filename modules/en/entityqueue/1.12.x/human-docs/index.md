# Entityqueue — manual setup guide

**Entityqueue** (`entityqueue`) lets editors collect any entities — nodes, media,
users, taxonomy terms, and more — into **arbitrarily ordered, drag-and-drop lists**
called queues. It's the modern Drupal successor to the classic Nodequeue module, and
it's the standard tool for hand-curated, manually ordered content: a "Featured
articles" strip, a homepage carousel, a "Staff picks" block, or a custom-ordered
navigation list.

A **queue** targets a specific entity type and is driven by a **handler** plugin.
The **Simple** handler gives a queue exactly one list of items (ideal for a single
"featured items" list), while the **Multiple subqueues** handler lets editors create
many named lists under one queue. Editors reorder items with a drag-and-drop table,
and you can enforce a minimum and/or maximum size so, for example, a slider is never
empty or a "Top 10" never exceeds ten items. The lists themselves (subqueues) are
revisionable and translatable content entities.

Entityqueue's real power shows through its deep **Views integration**: add an
Entityqueue relationship and a position sort to a view and you can build blocks or
pages that display queued items in their exact manual order. It also offers granular
per-queue permissions, plus Actions, Rules, and ECA integration for
adding/removing/clearing/reversing/shuffling items. It has **no external module
dependencies**. The bundled **Entityqueue Smartqueue** submodule auto-creates a
subqueue per entity of a chosen type — for example a related-content queue per
taxonomy term.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add the Smartqueue submodule if you need it.
2. [Configuration](configuration/index.md) — create a queue, choose its handler and
   size limits, and add items.

## Where it lives in the admin menu

Queues are managed at **Structure → Entityqueues**
(`/admin/structure/entityqueue`, route `entity.entity_queue.collection`). Access is
controlled by Entityqueue's permissions, including dynamic per-queue permissions so
you can let a role manage just one specific queue.

## How to use it

1. **Create a queue** at *Structure → Entityqueues*, choosing which entity type it
   holds and whether it uses the Simple or Multiple handler.
2. **Add and order items** — open the queue's subqueue and drag items into the order
   you want (respecting any min/max size you set).
3. **Display the queue** with Views — add an *Entityqueue* relationship to a view
   and sort by the *Entityqueue position* to render items in their curated order,
   then place that view as a block or page.
