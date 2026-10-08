Action Link Entity Links outputs an action link's links automatically in the node or comment entity links area, so you do not have to place them in a render array yourself.

---

This Action Link submodule provides the `entity_links` Action Link Output plugin. When enabled on an action link (on the link's Output tab), the module hooks `hook_node_links_alter()` and `hook_comment_links_alter()` and adds the action link's directional links into the entity's links section — the same row as "Read more", "Add comment", etc. It applies only to action links whose state action targets an entity and declares exactly the single `entity` dynamic parameter, and only for the node and comment entity types (the only core types with an entity-links area). Each link is emitted through a lazy builder with a generated placeholder, so the action links' uncacheable, per-user nature does not spoil the cacheability of the surrounding links; a cache dependency on the action_link config entity list is added so added/edited/deleted action links invalidate correctly.

---

- Show a "Publish / Unpublish" link in a node's links row without editing templates.
- Add a "Flag / Unflag" style toggle to comments in their links area.
- Surface an increment/decrement or options-cycling link on nodes directly in the teaser links.
- Enable per-content-type action links that appear alongside the standard node links.
- Provide moderator toggles in the node links row for boolean fields (featured, sticky).
- Keep action links out of the field region and instead group them with the entity's action links.
- Let a comment's links row carry a subscribe/unsubscribe-style action.
- Turn on entity-links output simply by checking the 'Entity links' option on an action link's Output tab.
- Combine with the AJAX link style so the link in the entity-links row updates in place on click.
- Rely on lazy building so adding action links to teasers does not disable page cache for the rest of the listing.
