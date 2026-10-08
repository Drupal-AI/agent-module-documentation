Views Custom Cache Tag adds a Views cache plugin (`custom_tag`) that lets you attach your own cache tags to a view's query and rendered output, so the cache persists until those exact tags are invalidated.

---

The module ships a single Views cache plugin, `Custom Tag based` (id `custom_tag`, class `Drupal\views_custom_cache_tag\Plugin\views\cache\CustomTag`, extending core's `Tag` plugin). You select it per display under a view's **Advanced → Caching** settings and enter one or more cache tags — one per line — in the "Custom tag list" textarea. Those tags are merged onto the view's own cache tags, so the cached results and rendered HTML live until any of the listed tags is invalidated with `Cache::invalidateTags()`. Unlike the core Tag plugin, it also *removes* the entity-type list cache tags (e.g. `node_list`) that Views would otherwise add, so the view is no longer flushed on every entity save of that type — invalidation becomes deliberate, driven only by your custom tags. Because caching is now manual, you clear it from your own code (a hook, an event subscriber, a queue worker) by invalidating the matching tag. The plugin supports Twig token replacement in the tag list, so contextual filter (argument) values can be expanded into per-argument tags such as `node:type:{{ raw_arguments.type }}`, letting one view keep independent caches per argument value. A "Rendered output" lifespan select adds an optional TTL on top of tag-based invalidation (Unlimited/tag-only, preset intervals from 1 minute to 6 days, or a `custom` `strtotime()` expression). The project bundles a `views_custom_cache_tag_demo` submodule that installs example content types and views to demonstrate the plugin — it is a demo only, not a feature module, so it is not documented separately here.

---

- Cache a view of promoted nodes until a single `my_module:promoted` tag is invalidated.
- Keep a "latest articles" block cached but flush it only when an editor publishes, not on every node save.
- Attach a per-taxonomy-term tag so a term-listing view refreshes only when that term's content changes.
- Use `node:type:{{ raw_arguments.type }}` to give one contextual view a separate cache per content type argument.
- Stop a heavy view from being invalidated by the broad `node_list` tag on unrelated content edits.
- Tag a view of external/imported data and clear it from a cron or queue worker after a re-import.
- Cache a REST export display and invalidate it programmatically when the underlying dataset updates.
- Give a dashboard view a fixed 1-hour rendered-output lifespan while still honoring tag invalidation.
- Set a `custom` `strtotime()` expiry (e.g. "tomorrow 6am") so a view rebuilds at a business-relevant time.
- Share one cache tag across several related views so a single invalidation clears them all at once.
- Cache a menu/footer-style view that changes rarely and flush it only on a deliberate content release.
- Invalidate a view's cache from a `hook_ENTITY_TYPE_update()` implementation for precise control.
- Tag search-result-style views so they persist between deploys until you explicitly bust the tag.
- Reduce database load from an expensive aggregate view by caching it long-term with manual busting.
- Keep a pricing or inventory view cached and clear it from your commerce sync code.
- Cache a calendar/event view and invalidate only when an event in range is saved.
- Expose per-user or per-role tags (built in your own code) and clear them on profile changes.
- Cache a multi-argument view with a Twig-expanded tag list that yields one tag per argument.
- Give staging vs production the same view but different manual invalidation triggers.
- Combine tag-based caching with a short TTL as a safety net against missed invalidations.
- Cache a view feeding a decoupled front end and bust it from an API write path.
- Hold a report view for a fixed 6-hour window using a preset rendered-output lifespan.
- Prevent a slow related-content view from recomputing on every page unless its tag fires.
- Drive cache invalidation of a view from Rules/ECA by invalidating the configured tag.
- Debug which views execute (cache misses) by toggling the `views_custom_cache_tag.execute_debug` state flag.
