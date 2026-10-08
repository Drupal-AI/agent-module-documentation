<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auto Entityqueue automatically adds newly created entities to an Entityqueue subqueue when the entity's type and bundle match a queue that has auto-add enabled — no manual queueing needed.

---

The module extends the Entityqueue module. Via `hook_form_alter()` on the entity queue add/edit forms it injects an **"Auto Entityqueue"** fieldset with two checkboxes stored inside the queue's `entity_settings.handler_settings.auto_entityqueue`: **`auto_add`** ("Automatically add entities to queue") and **`insert_front`** ("Insert entities at front of queue"). Then `hook_entity_insert()` fires for every new entity: `auto_entityqueue_get_queues_by_type_and_bundle()` loads all enabled queues whose target entity type matches, whose `target_bundles` include the entity's bundle, and whose `auto_add` is on, and `auto_entityqueue_add_entity_to_queue()` appends (or, with `insert_front`, prepends) the entity's id to every subqueue of each matching queue. It respects the queue's `max_size`: when the subqueue is full it pops the item from the opposite end before inserting (FIFO/LIFO windowing). If the queue's reference handler is a **view**, the code also derives target bundles from the view's `node.type.*` config dependencies. Only inserts are handled (it acts on entity creation, not update). There is no config UI of its own, no permissions, no Drush — the toggles live on each Entityqueue.

---

- Automatically add every new Article to a "Latest articles" entityqueue.
- Keep a "Featured content" queue populated as editors create qualifying content.
- Prepend new items to the front of a queue so the newest appears first (`insert_front`).
- Append new items to the back of a queue (default) for chronological order.
- Maintain a fixed-size "Top 10 recent" queue that drops the oldest as new items arrive (`max_size`).
- Auto-populate a homepage carousel queue from newly published nodes of selected bundles.
- Restrict auto-add to specific bundles via the queue's `target_bundles`.
- Enable auto-add only on selected queues while leaving others manual.
- Build a "recently added" block backed by an auto-maintained subqueue.
- Curate a queue driven by a view handler, deriving bundles from the view's content-type dependencies.
- Auto-queue new media items into a media entityqueue.
- Auto-queue new users or taxonomy terms (any entity type the queue targets).
- Seed a launch queue automatically during a content import (entities inserted get queued).
- Keep an editorial "needs review" queue filling itself as content is created.
- Combine with Entityqueue's ordering UI: auto-add seeds the queue, editors reorder manually.
- Ensure new promoted content always lands at the top of a highlights queue.
- Provide a set-and-forget queue that never needs manual adds for standard content flows.
- Window a rolling "last 5 events" list using a max_size queue with front insertion.
- Auto-queue new products into a "new arrivals" list.
- Add new blog posts to multiple matching queues at once (all enabled auto-add queues fire).
- Reduce editor workload by removing the manual "add to queue" step for routine content.
