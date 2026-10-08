# Configuration — create, fill, and display a queue

Setting up a queue is a three-part job: **create** the queue (deciding what it holds and
how many items), **fill** it by adding entities and dragging them into order, and
**display** it with a View so the queue order drives the output. This page walks through
all three.

## 1. Create a queue

1. Go to **Structure → Entityqueues** (`/admin/structure/entityqueue`).

   ![The Entityqueues list with the Add entity queue button](../images/list.png)

2. Click **+ Add entity queue**. The add form opens.
3. Enter a human-readable **Label** — for example `Featured articles`. Drupal derives a
   machine name from it automatically.
4. Choose the **queue type** (handler):
   - **Simple queue** — the queue holds exactly one list. Pick this for a single
     "Featured articles" or "Homepage carousel" list. This is the common choice.
   - **Multiple subqueues** — one queue can hold many named subqueues, so editors can
     run several independent curated lists from one queue definition.

   (If you enabled the **Entityqueue Smartqueue** submodule, a third type appears that
   auto-creates one subqueue per entity of a chosen type.)
5. Choose the **target entity type** — the kind of thing the queue will hold. For a
   list of articles this is **Content**; it could also be Media, Users, Taxonomy term,
   and so on.
6. Under the target settings, restrict the **allowed bundles** — for example limit a
   Content queue to just the **Article** content type — so editors can only add the
   right things.
7. Set the **minimum** and **maximum** number of items if you want to enforce a size.
   For a "Top 10" set the maximum to `10`; set a minimum so a slider is never empty.
   Leave the maximum at `0` for an unlimited queue.
8. Click **Save**. The new queue now appears in the **Enabled** table on the
   Entityqueues list.

## 2. Add entities and put them in order

1. Back on the Entityqueues list (`/admin/structure/entityqueue`), find your queue and
   click the **Edit items** operation (for a multiple-subqueue queue, first pick or add
   the subqueue you want to edit).
2. Use the **Add item** autocomplete to find and add an entity (for a Content queue,
   start typing an article title). Repeat for each item you want in the list.
3. Each item shows as a row in a drag-and-drop table. Grab the **cross-arrows drag
   handle** on the left of a row and drag rows up or down until they are in the exact
   order you want — the top row is first. If you set a maximum size, the form stops you
   from adding more than that many items.
4. Click **Save**. The queue now stores your entities in the manual order you set.

## 3. Display the queue with Views

A queue holds order, but it does not display anything on its own — you render it with a
**View**, using Entityqueue's Views integration so the queue position drives the output
order.

1. Go to **Structure → Views** (`/admin/structure/views`) and click **Add view**.
2. Set the view to show the same entity type your queue targets (for a Content queue,
   **Content**). Create a **block** or **page** display as you prefer, then click **Add
   view and edit**.
3. In the view editor, under **Advanced → Relationships**, click **Add** and add the
   **Entityqueue** relationship for your queue. This joins each result to its position
   in the subqueue. Configure the relationship to point at your queue (and require it,
   so only queued items appear).
4. Under **Sort criteria**, click **Add** and add the Entityqueue **position** sort,
   set to **ascending**. This is what makes the view output items in the manual order
   the editor set rather than by date or title.
5. Optionally add the Entityqueue **"in queue"** filter to restrict the view to only
   (or exclude) entities that are in the queue, or add the position **field** to show an
   item's number.
6. Save the view. Place the resulting block (or visit the page) and you will see your
   queued entities rendered in exactly the order you dragged them into.

That is the full loop: create a queue, drag its items into order, and let a View turn
that order into what visitors see. To reorder later, just return to the queue's **Edit
items** screen, drag, and save — the display updates to match.
