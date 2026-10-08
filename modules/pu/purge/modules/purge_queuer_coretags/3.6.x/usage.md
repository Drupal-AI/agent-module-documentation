Core tags queuer captures every cache tag Drupal invalidates internally and adds it to the Purge queue, so external caches are cleared for exactly the content that changed.

---

This is the standard **queuer** for Purge: it listens to Drupal's internal cache-tag invalidation and, for each invalidated tag, adds a corresponding tag invalidation to the Purge queue (`CacheTagsQueuer` + the `CoreTagsQueuer` queuer plugin). That means whenever a node, term, block, menu, or any other cacheable object is changed and Drupal invalidates its tags, the same tags get scheduled for external invalidation on your reverse proxy or CDN. It ships a small configuration form and schema exposing a **blacklist** of tag prefixes that should not be queued (`purge_queuer_coretags.settings:blacklist`), useful for excluding noisy or irrelevant tags. It is almost always the queuer you want for tag-based cache clearing, paired with a processor (cron or late runtime) and a purger. It has no permissions of its own and depends only on the Purge core framework.

---

- Automatically queue every cache tag Drupal invalidates.
- Keep external caches in sync with content changes by tag.
- Clear a CDN entry when its underlying node changes.
- Invalidate menu/block caches externally when they change.
- Blacklist noisy tag prefixes you don't want to purge.
- Exclude specific cache-tag prefixes from external clearing.
- Feed a Varnish or Fastly purger with precise tag invalidations.
- Avoid over-purging by targeting only changed tags.
- Pair with the cron processor for background clearing.
- Pair with the late-runtime processor for instant clearing.
- Provide the default queuing strategy for a Purge install.
- Handle taxonomy term updates propagating to listing pages.
- Invalidate cached views when their result tags change.
- Reduce stale content behind an edge cache automatically.
- Configure which tags to skip via the settings form.
- Support tag-based invalidation on decoupled front ends.
- Queue user or comment tag invalidations as they change.
- Keep queue contents aligned with Drupal's own cache metadata.
