Cache Tools sanitizes overly generic cache tags/contexts on blocks and views, and adds precise `entitytype_entitybundle_pub` (and field-value) cache tags that are invalidated automatically on entity operations.

---

Cache Tools is a developer-oriented performance module that refines Drupal's default cacheability metadata. It replaces the core block view builder with a "cache-wise" one that strips configured cache contexts (default: `route`, `url`, `url.query_args`) and cache tags (default: `node_list`, `taxonomy_term_list`) from named blocks, with per-block include/exclude overrides. It also ships two ViewsCache plugins that place precise published-entity tags — `node_article_pub`, `node_recipe_pub`, and optionally `node_article_pub:field_name:value` — instead of the broad `node_list`, and it auto-invalidates those tags via `hook_entity_insert/update/delete`. All behavior is configured through the `cache_tools` service-container parameter (overridden in your site's `services.yml`), not an admin form; there are no routes, permissions, or Drush commands.

---

- Stop a block from varying by URL/query args by stripping the `url` and `url.query_args` contexts from its cacheable metadata.
- Prevent a menu/footer block from busting the page cache on every `node_list` change by stripping `node_list` and `taxonomy_term_list` tags.
- Give a views listing block a precise `node_article_pub` tag so it only rebuilds when a published article is added/changed, not on every node save.
- Keep an "articles by author" view cached until a published article for that specific author changes, using `node_article_pub:field_author:123`.
- Invalidate a taxonomy-filtered listing including all ancestor terms by appending the `parents` strategy (`article:field_topics:parents`).
- Replace a view's cache plugin with "Sanitized cache tag" so its tags are both precise and sanitized out-of-the-box.
- Use "Sanitized cache field tag" to add a field-value tag to a view whose argument supplies the field value.
- Keep a search-page exposed-form block cached across query args by excluding `url.query_args` for just that block.
- Preserve `route.menu_active_trails:footer` on a footer block while stripping the default contexts (per-block include list).
- Reduce cache fragmentation on high-traffic blocks that would otherwise vary per-route.
- Ensure author/user listing pages invalidate both the previous and the new author page when a node's author reference changes.
- Only invalidate precise tags when an entity actually transitions to published, avoiding churn from unpublished edits.
- Invalidate field-based tags on delete of a published entity so stale listings clear.
- Add published-entity cache tags to a view without writing custom code, relying on filter/argument handler auto-detection.
- Override the module's default entity/bundle invalidation map by declaring a custom `cache_tools` parameter in a site or install-profile `services.yml`.
- Configure which entity types and bundles participate in published-tag invalidation (e.g. `node: [article, page]`, `taxonomy_term: [topics]`).
- Sanitize cache metadata during block pre-render as well as build, so views blocks cannot re-add undesired metadata late.
- Call `CacheSanitizer::sanitizeCacheableContexts()` / `sanitizeCacheableTags()` from custom code to apply the same sanitizing rules to your own render arrays.
- Generate a published-entity tag programmatically via `CacheInvalidator::getPublishedEntityCacheTag($entity)` for use in custom render arrays.
- Trigger field-based invalidation manually from custom code via `CacheInvalidator::invalidatePublishedEntityFields($entity)`.
- Support taxonomy-term reference fields where invalidating parent terms is required for hierarchical listings.
- Standardize cache-tag naming (`*_pub`) across a project so listings and blocks share a predictable invalidation vocabulary.
- Cut over-invalidation on editorial sites where any node save currently flushes every listing via `node_list`.
