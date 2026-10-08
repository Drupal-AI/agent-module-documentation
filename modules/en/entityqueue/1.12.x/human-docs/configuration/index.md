# Configuration

Configuring Entityqueue means **creating queues**, choosing how they behave, and
then **filling and displaying them**.

## Create a queue

1. Log in as a user with permission to administer entity queues.
2. Go to **Structure → Entityqueues** (`/admin/structure/entityqueue`) and click
   **Add entity queue**.
3. Give the queue a label and configure its settings (below), then save.

## Queue settings

- **Handler** — how the queue is structured:
  - **Simple queue** — one fixed list of items. Best for a single "featured items"
    list.
  - **Multiple subqueues** — editors can create many named lists under one queue.
  - **Smartqueue** — (only with the *Entityqueue Smartqueue* submodule) auto-creates
    a subqueue per entity of a chosen type.
- **Target entity settings** — which **entity type** the queue holds, the reference
  method, and any bundle/selection restrictions (e.g. only *Article* nodes).
- **Minimum / maximum size** — enforced by a validation constraint. Set a minimum so
  a slider is never empty, or a maximum for a "Top 10". Set the maximum to **0** for
  unlimited.
- **Act as queue** — when the queue is full, adding a new item drops one from the far
  end (first-in, first-out behavior).
- **Reverse** — add new items to the **top** of the list instead of the bottom.

## Add and order items

Each queue holds one or more **subqueues** (content entities that are revisionable
and translatable). Open a subqueue to edit its items:

- Items are shown in a **drag-and-drop table** — drag rows to set the exact order.
- Widget options can **link items to the entity** or its edit form, and can **show a
  publication-status marker** for unpublished (or all) items so editors can see at a
  glance what's live.

## Display queued items with Views

Queues are most useful when rendered in their curated order through Views:

1. Create or edit a View of the same entity type the queue holds.
2. Add the **Entityqueue** relationship (you can now limit one relationship to
   several queues at once).
3. Add a **sort on the Entityqueue position** so items appear in the manual order.
4. Optionally add an **Entityqueue filter** to show only (or exclude) entities that
   are in a given queue.
5. Place the view as a block or page — for example, a homepage "Featured" block.

## Permissions

Entityqueue provides global permissions plus **dynamic per-queue permissions**, so
you can grant a specific role the ability to update just one queue (and, for
Multiple-subqueue queues, create or delete subqueues). Set these on **People →
Permissions** (`/admin/people/permissions`).

## Deploying queues

Queue **definitions** are exportable configuration (`entity_queue.*`) and deploy
between environments with configuration sync. The subqueue **contents** (the actual
ordered items) are content entities, not configuration, so they are managed per
environment rather than exported.
