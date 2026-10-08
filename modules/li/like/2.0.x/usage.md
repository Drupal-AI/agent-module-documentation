Like! adds a configurable like button to any content entity type, for both logged-in and anonymous visitors.

---

Enabling the module lets an administrator pick which content entity types (nodes, comments, media, users, etc.) get a like button. For each chosen type Like! adds a computed `likes` base field whose value is the current like count, and a `like_default` field formatter that you place on the entity's Manage display page. The formatter renders an AJAX toggle — a Font Awesome heart, a like/liked label pair you can customise per display, and the running total. Clicking the heart creates or removes a lightweight, non-fieldable `like` content entity that stores the target entity type, id, the user's uid, a value and a timestamp; authenticated users are deduplicated in the database (one like per user per entity), while anonymous visitors are tracked with the `Drupal.visitor.like` cookie. A GET endpoint returns the count as cacheable JSON so numbers stay fresh under page caching, in either an entity-invalidation cache mode or a time-based mode for high-volume sites. An admin Likes listing (a `like` entity collection view at /admin/content/like) lets you browse and delete recorded likes, and a Views argument-default plugin ("Like: owner by user or cookie") lets you build "content I liked" views. The module deliberately omits any dislike feature and integrates automatically with Antibot when that module is present.

---

- Add a like/favorite button to article and page nodes.
- Let anonymous visitors like content without logging in, tracked via cookie.
- Show a running like count next to a heart icon on teasers and full nodes.
- Enable likes on comments so readers can endorse individual replies.
- Enable likes on media entities to surface popular images or videos.
- Let users like other user profiles as a lightweight follow/endorse signal.
- Customise the button labels per display (e.g. "Like" / "You liked this").
- Build a "Most liked content" view by sorting on the computed likes field.
- Build a "Content I liked" view for the current user using the Like argument-default plugin.
- Track engagement/popularity for editorial curation of trending content.
- Add a reactions widget to a blog without installing a full Voting API stack.
- Deduplicate authenticated likes automatically (one like per user per entity).
- Keep displayed counts accurate under Drupal page caching via the JSON count endpoint.
- Choose time-based cache expiry for the count on very high-traffic sites.
- Deter automated like spam by also installing Antibot (auto-detected).
- Use Font Awesome for the heart icon, via the Font Awesome module or your own integration.
- Browse and moderate all recorded likes from the admin Likes overview at /admin/content/like.
- Bulk-delete recorded likes for an entity from the admin collection view.
- Expose the likes count as a Views field for reporting dashboards.
- Restrict who may administer the feature with the "Administer like configuration" permission.
- Set the anonymous like cookie lifetime (in seconds) to tune how long a visitor is remembered.
- Add social-style engagement to landing pages assembled with Layout Builder or blocks.
