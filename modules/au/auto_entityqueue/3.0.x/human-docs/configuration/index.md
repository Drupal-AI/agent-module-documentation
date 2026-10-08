# Configuration

Auto Entityqueue has **no settings page of its own**. You turn auto-add on
**per Entityqueue**, and the choice is saved on that queue.

## Turn on auto-add for a queue

1. Go to **Structure → Entityqueues** and **Edit** (or Add) a queue.
2. Set the queue's reference **target type** (for example *Content*) and, on the
   reference handler, the allowed **bundles** (for example *Article*). This is
   what decides which new entities qualify.
3. In the **Auto Entityqueue** section, set the two options:
   - **Automatically add entities to queue** — when ticked, every new entity of
     the queue's target type and bundles is added to the queue automatically.
   - **Insert entities at front of queue** — appears once auto-add is on. When
     ticked, new items are placed at the **front**; leave it unticked to append
     them at the **back** (the default).
4. Save the queue.

That is the whole configuration. From now on, creating a qualifying entity adds
it to the queue with no further action.

## How insert order and maximum size behave

- The module acts on entity **creation only** — editing an existing entity does
  not re-queue it.
- It only fires for **enabled** queues whose target bundles include the new
  entity's bundle.
- A matching entity is added to **every subqueue** of the queue.
- **Front vs. back:** with *Insert entities at front* on, the item is prepended;
  otherwise it is appended.
- **Maximum size:** if the queue has a maximum size set and a subqueue is already
  full, the module first removes an item from the *opposite* end before adding
  the new one — so the queue stays at its size limit as a rolling window (the
  oldest item drops off as the newest arrives).

## A note on view-driven queues

If a queue uses a **view** as its reference handler rather than a fixed bundle
list, the module also works out the eligible content types from the view's
content-type configuration dependencies, so auto-add still targets the right
bundles.

## Multiple queues

Auto-add is independent per queue, and all matching queues fire on creation. So a
single new Article can be added to several auto-add queues at once (say "Latest
articles" and "Featured"), while other queues stay fully manual.
