Index Now Commerce extends Index Now so Drupal Commerce products and stores are submitted to IndexNow search engines when they are created, updated, or deleted.

---

This submodule of [Index Now](https://www.drupal.org/project/index_now) adds two EntityIndexer plugins — `CommerceProductIndexer` (`commerce_product`) and `CommerceStoreIndexer` (`commerce_store`) — each carrying the base module's `#[IndexableEntity]` attribute. That is all that's needed: the base module's `EntityActions` hooks and plugin manager pick them up automatically, so saving/deleting a product or store pings the configured search engine with the entity's absolute canonical URL, honoring the same indexability rules (CLI/`cli_mode` gate, anonymous-view check on insert, per-bundle and per-event excludes). Configuration is entirely on the parent module's settings form (*Config → Web services → Index Now*), where product-type and store-type exclusion tabs appear automatically through plugin discovery. In version 3.1.6+ the old `hook_form_..._alter`, path-alias hooks, and the `CommerceProductOperations` class were emptied/deprecated in favor of the plugin approach (all removed in 4.0.0). It requires Commerce (`commerce_product`) and the base Index Now module; there is no separate key, permission, or Drush command — it inherits everything from Index Now.

---

- Ping search engines when a Commerce product is published or updated.
- Notify engines to drop a product URL when the product is deleted.
- Submit Commerce store pages to search engines when a store changes.
- Exclude specific product types from IndexNow via the parent settings form.
- Exclude specific store types from IndexNow submissions.
- Ping on product update but not on delete by excluding the delete event.
- Keep a product catalog freshly crawled as inventory and descriptions change.
- Reuse the parent module's async queue and cron sending for product pings.
- Reuse the shared API key and engine choice for commerce entities.
- Skip pinging unpublished products on insert (anonymous view access is checked).
- Add commerce coverage to an existing Index Now setup with just this submodule enabled.
- Submit product canonical URLs in the correct language on multilingual stores.
- Avoid Drush-driven product imports pinging engines unless `cli_mode` is on.
- Let store managers see submission confirmation messages (with the results permission).
- Model per-type crawl policies (e.g. ping physical products but not digital ones) via excludes.
- Integrate IndexNow into a Commerce publishing workflow without custom code.
- Register additional commerce entity types by following the same `#[IndexableEntity]` pattern.
- Keep search engines current on a fast-moving storefront with frequent price/stock updates.
