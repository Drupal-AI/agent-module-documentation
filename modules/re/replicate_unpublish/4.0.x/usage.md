Automatically sets a cloned node (and all its translations) to *unpublished* when it is duplicated with the [Replicate](https://www.drupal.org/project/replicate) module, so copies never go live by accident.

---

A zero-configuration glue module: it registers one event subscriber
(`ReplicateUnpublishNode`) on Replicate's `ReplicatorEvents::REPLICATE_ALTER` event. When
Replicate (via Replicate UI's "Clone" action) builds the cloned entity, this subscriber checks
whether the clone is a `node`; if so it iterates every enabled site language, and for each
translation the node has, sets `status` to `Node::NOT_PUBLISHED`. The result is that the freshly
replicated node is saved unpublished across all its translations, avoiding duplicate live content
and preventing node-published side effects (e.g. notifications, search indexing, feeds) from
firing on the clone. It only touches nodes — other entity types replicated by Replicate are left
as-is. There is no admin UI, no settings, no permissions, and no Drush; installing and enabling
it is the entire setup. Depends on both `replicate` and `replicate_ui`.

---

- Keep cloned nodes out of public view until an editor reviews and republishes them.
- Prevent duplicate live content appearing the moment an editor clicks "Clone".
- Stop node-published hooks/events (notifications, feeds, webhooks) firing on a replicated copy.
- Avoid duplicate entries in search indexes or sitemaps created by clones.
- Use "Replicate" as a safe starting point for drafting a new node from an existing one.
- Ensure every translation of a cloned multilingual node starts unpublished, not just the default language.
- Give content teams a "duplicate then edit privately" workflow without extra clicks.
- Prevent accidental publication of near-identical pages that could harm SEO.
- Seed a new campaign/landing page from a template node while keeping it hidden.
- Batch-clone content for a redesign without exposing half-finished copies.
- Reduce editorial mistakes where a clone is published before its content is changed.
- Pair with Replicate UI's clone button so cloning is inherently draft-first.
- Keep moderation state clean by having clones enter as unpublished nodes.
- Let authors experiment with variations of a node privately before going live.
- Avoid triggering time-sensitive published-node integrations on throwaway copies.
