Entityqueue Smartqueue is an Entityqueue submodule that adds a "Smart queue" handler which automatically maintains one subqueue for every entity of a chosen entity type (and optional bundles).

---

Where the core Entityqueue "Multiple" handler requires editors to create subqueues by hand, Smartqueue creates and destroys subqueues automatically as entities of a target type come and go. You pick a target entity type (e.g. taxonomy term, node, user) and optionally limit it to specific bundles; the handler then provisions a subqueue keyed to each of those entities (subqueue id like `<queue>__<entity_id>`). It hooks `hook_entity_insert`/`hook_entity_update`/`hook_entity_delete` to keep the set of subqueues in sync, and uses a batch process when a queue is first configured to backfill subqueues for existing entities. It also adds a base field so each target entity effectively "owns" its subqueue, and provides a Views argument (`EntityQueueSmartQueueArgument`) to fetch the right subqueue contextually. This is the classic pattern for per-term or per-entity curated lists — for example a manually ordered "related articles" list attached to each taxonomy term. It depends on the main `entityqueue` module and stores its `entity_type`/`bundles` settings in the queue's handler configuration.

---

- Maintain a manually ordered "related content" list per taxonomy term.
- Give every category page its own curated list of featured items.
- Provide a per-user "favorites" ordered list that appears automatically for new users.
- Auto-create a cross-sell/upsell subqueue for each product.
- Keep a hand-ranked list of child items per parent entity.
- Backfill subqueues for all existing terms via a batch when first configuring.
- Automatically add a new subqueue whenever a new term/node is created.
- Automatically remove a subqueue when its owning entity is deleted.
- Limit automated subqueues to specific bundles of an entity type.
- Drive a contextual Views block that shows the current term's queued items.
- Curate per-landing-page promoted content without manual subqueue creation.
- Attach an editorial "top picks" list to each author profile.
- Build per-region ordered content lists keyed to a region entity.
- Keep related-content queues in sync as content is added and removed.
- Provide per-node "you might also like" ordered recommendations.
- Use the smartqueue Views argument to render the right subqueue by context.
