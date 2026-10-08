Entityqueue lets editors collect any entities (nodes, media, users, terms, etc.) into arbitrarily ordered, drag-and-drop lists called queues, which can then be displayed with Views. It is the Drupal 8+ successor to Nodequeue.

---

A "queue" (`entity_queue` config entity) targets a specific entity type and is driven by a handler plugin; each queue holds one or more "subqueues" (`entity_subqueue` content entities) whose items are an ordered entity-reference list. The Simple handler gives a queue exactly one subqueue (ideal for a single "featured items" list), while the Multiple handler lets editors create many named subqueues under one queue. Editors reorder items with a drag-and-drop table widget and can enforce minimum/maximum sizes via a queue-size validation constraint. Queues integrate deeply with Views through custom relationship, filter, sort, and field plugins, so you can build blocks or pages that show queued items in their exact manual order. The module provides granular per-queue permissions, Actions plus Rules and ECA integration for adding/removing/clearing/reversing/shuffling items, and Drupal 7 migration sources for upgrading legacy Nodequeue/Entityqueue data. Developers can define new behaviors by implementing the `EntityQueueHandler` plugin type, and manipulate subqueues programmatically with `addItem()`, `removeItem()`, `clearItems()`, `reverseItems()`, and `shuffleItems()`. The bundled Entityqueue Smartqueue submodule auto-creates a subqueue per entity of a chosen type (e.g. a related-content queue per taxonomy term). Overall it is the standard tool for hand-curated, ordered content lists in modern Drupal.

---

- Build a hand-curated "Featured articles" list shown on the homepage.
- Let editors drag-and-drop nodes into a specific display order.
- Create a "Top 10" list with an enforced maximum of 10 items.
- Enforce a minimum number of items so a slider never looks empty.
- Curate a homepage carousel/slider of promoted content.
- Order related links or "See also" blocks manually per page.
- Maintain an editor-picked "Staff picks" or "Editor's choice" queue.
- Queue media items into a manually ordered gallery.
- Curate a list of featured users or team members in a chosen order.
- Order taxonomy terms into a custom (non-alphabetical) navigation list.
- Use Multiple subqueues to run several independent curated lists from one queue.
- Build a Views block that renders queued items in their exact manual order.
- Add a Views relationship/sort to blend queue position into an existing listing.
- Filter a View to show only (or exclude) entities that are in a given queue.
- Grant a specific role permission to update just one queue.
- Add an entity to a subqueue from a bulk Action on the content admin page.
- Add/remove items from a queue as a Rules or ECA reaction to content events.
- Programmatically add a node to a queue from custom code with `addItem()`.
- Reverse or shuffle a subqueue's order via Rules/ECA actions.
- Clear all items from a subqueue in one action before a re-population.
- Auto-generate a related-content subqueue per taxonomy term (Smartqueue).
- Give each product a dedicated "cross-sell" subqueue via Smartqueue.
- Migrate Drupal 7 Nodequeue/Entityqueue data into Drupal 10/11.
- Define a custom queue behavior by writing an `EntityQueueHandler` plugin.
- Restrict which entity types/bundles a queue can hold via handler settings.
- Provide a translation-aware ordered list on a multilingual site.
