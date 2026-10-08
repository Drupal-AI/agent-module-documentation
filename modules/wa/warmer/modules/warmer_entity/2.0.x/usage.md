Entity Warmer is a submodule of Warmer that provides the `entity` warmer plugin: it loads entities of the entity-type/bundle pairs you select so their entity cache is warm.

---

Entity Warmer registers one `@Warmer` plugin, id `entity` (`EntityWarmer`, in `src/Plugin/warmer/`). It adds two plugin-specific settings on top of the shared `frequency`/`batchSize`: `entity_types` (a multi-select of `entity_type_id:bundle` pairs to warm) and `published_only` (a checkbox that limits warming to entities implementing EntityPublishedInterface that are published). On each batch it queries entity IDs for the selected bundles, loads them via the entity storage `loadMultiple()` — which populates the persistent entity cache — and resets the in-memory static cache between types. Config lives under `warmer.settings:warmers.entity` (schema `warmer.settings.warmer_plugin.entity`). Configure it in the Warmer settings form at `/admin/config/development/warmer/settings`; warm it with `drush warmer:enqueue entity`. It has no routes, permissions, services, or Drush commands of its own — everything runs through the parent Warmer framework.

---

- Warm the entity cache for Article nodes so page renders that load them are fast after a cache clear
- Pre-load several content types at once (e.g. `node:article`, `node:page`) in a single warmer
- Warm taxonomy terms, users, media, or any content entity type/bundle
- Restrict warming to published entities only via the "published only" option
- Keep the entity cache hot on cron by setting a `frequency` on the entity warmer
- Control how many entities are loaded per batch with `batchSize`
- Warm entities immediately after deploy with `drush warmer:enqueue entity --run-queue`
- Combine node and taxonomy warming to speed up pages that render both
- Warm a high-traffic bundle more aggressively by giving the entity warmer a short frequency
- Avoid warming unpublished/draft content by enabling "published only"
- Warm media entities so image-heavy pages render without cold-cache stalls
- Warm commerce or custom content entities the same way as nodes
- Reduce first-visit latency after a full cache flush by pre-warming key entity types
- Pre-warm entities referenced by menus or blocks so navigation renders fast
- Schedule off-peak entity warming by relying on cron + frequency
