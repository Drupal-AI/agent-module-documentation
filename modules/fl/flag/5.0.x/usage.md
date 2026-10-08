Flag lets site builders create custom "flags" — toggleable markers like bookmark, favorite, like, follow, or report — that users set on entities, with per-flag permissions and AJAX links.

---

A flag is a config entity describing a boolean relationship between a user (or the whole site, for global flags) and an entity such as a node, comment, or user. Site builders create flags at Admin → Structure → Flags, choosing the flaggable entity type and bundles, the flag/unflag link text and messages, whether the flag is per-user or global, and which link (action) type to use. Each flagging is stored as its own `flagging` entity, so flags can carry fields of their own. Flag defines two plugin types: **Flag Type** plugins (entity, comment, user) determine what can be flagged, and **Action Link** plugins (AJAX link, confirmation form, reload, field-entry form) determine how the flag/unflag interaction renders. It ships a `flag` service for programmatic flag/unflag operations and lookups, a `flag.count` manager for counts, a link builder, Views integration (relationships, fields, and filters on flaggings), a Twig `flag_count()` function, and events fired on flag/unflag. Per-flag "use" permissions are generated automatically, gated by `administer flags`/`administer flaggings`. Example submodules (flag_bookmark, flag_follower, flag_count) demonstrate common setups.

---

- Add a "Bookmark" link so users can save content to a personal list.
- Build a "Favorite" or "Like" toggle on articles.
- Let users "Follow" other users or content and build activity feeds.
- Create a "Report inappropriate" flag for moderation queues.
- Mark content as "Reviewed" in an editorial workflow.
- Provide a global "Featured" flag toggled by editors, visible to all.
- Show a count of how many users bookmarked a node.
- Build a Views listing of everything the current user flagged.
- Add an AJAX flag link that toggles without a page reload.
- Require a confirmation form before flagging (e.g. reporting).
- Collect extra data on a flagging via fields on the flagging entity.
- Restrict flagging to specific content types or comment bundles.
- Flag users to build a "block list" or "connections" feature.
- Programmatically flag an entity for a user in custom code.
- Count total flaggings of a flag for analytics.
- Unflag everything for a user when their account is cancelled.
- Expose flag state as a Views relationship and filter results by it.
- Display flag counts in a Twig template with `flag_count()`.
- Grant only certain roles permission to use a given flag.
- React to flag/unflag events with an event subscriber.
- Create a "Watch this thread" subscription flag on comments.
- Build a wishlist for a commerce catalogue.
- Add a "Read later" queue for anonymous users via session flags.
- Provide field-entry flags that open a form when flagging.
- Define a custom Flag Type plugin for a bespoke entity relationship.
- Define a custom Action Link plugin for a new interaction style.
