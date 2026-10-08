Index Now automatically pings IndexNow-compatible search engines (Bing, Yandex, and others) whenever content is created, updated, or deleted, so your changes get recrawled faster. It ships an extensible entity-indexer plugin system and a Commerce submodule.

---

The module implements the [IndexNow protocol](https://www.indexnow.org/): on entity insert/update/delete it submits the entity's absolute canonical URL to a chosen search-engine endpoint (as of Nov 2021 all participating engines share submissions). Which entity types are handled is driven by an **EntityIndexer plugin type** — classes in `Plugin/EntityIndexer/` carrying the `#[IndexableEntity]` attribute; the base module ships indexers for **nodes** and **taxonomy terms**, and the `index_now_commerce` submodule adds **products** and **stores**. Per entity type you can exclude specific bundles and events (created/updated/deleted) from the settings form at *Config → Web services → Index Now*. Ownership of the domain is proven with an **API key** (a UUID generated on install or via `drush index_now:keygenerate`) that is served as a plaintext key file at `/index_now_api_key_{key}.txt` — resolved to a controller through an inbound path processor, and reachable by anonymous users because the search engine must fetch it. Requests can be sent synchronously or, in **async mode**, queued (`index_now_submissions` queue worker) and flushed on cron; URLs are de-duplicated within a request. Insert pings are skipped for content anonymous users can't view, CLI operations are gated behind a `cli_mode` toggle, and two alter hooks let you rewrite the submitted URL or the key-location URL (useful for headless/decoupled setups). Requires `path_alias` and `config_split`; `league/commonmark` is pulled in as a dependency.

---

- Ping Bing/Yandex automatically when an editor publishes or updates a node.
- Notify search engines to drop a URL from their index when content is deleted.
- Speed up recrawling of frequently-updated pages without waiting for the crawler.
- Exclude specific content types (e.g. internal or unlisted types) from IndexNow submissions.
- Exclude specific events — for instance ping on update but not on delete.
- Submit taxonomy term pages to search engines when terms change.
- Add IndexNow support for Commerce products and stores via the submodule.
- Register a custom entity type for indexing by adding an `#[IndexableEntity]` plugin.
- Queue submissions and send them on cron (async mode) to reduce request latency on high-traffic sites.
- De-duplicate pings when a node save and its path-alias save fire in the same request.
- Generate or rotate the IndexNow API key from the CLI with `drush index_now:keygenerate`.
- Serve the required key-verification file to search engines at a stable public URL.
- Rewrite submitted URLs for a headless/decoupled front end via `hook_index_now_url_alter()`.
- Rewrite the key-location URL for multi-domain or proxied setups via `hook_index_now_key_location_url_alter()`.
- Choose which search engine endpoint to submit to (Amazon, Bing, IndexNow.org, Naver, Seznam, Yandex, Yep).
- Avoid submitting unpublished/inaccessible content on insert (anonymous view access is checked).
- Keep Drush-driven content operations from pinging search engines unless `cli_mode` is enabled.
- Log successful submissions (verbose mode) while always logging warnings/errors.
- Show editors a confirmation message when a URL was submitted (with the results permission).
- Submit canonical URLs in the entity's own language for multilingual sites.
- Integrate IndexNow into a content-publishing workflow with no custom code.
- Override an indexer's excluded-bundle/event config keys via the plugin attribute for a new entity type.
- Trigger a resubmission by re-saving an entity after a content fix.
- Keep search engines current on a news or catalog site where content changes constantly.
- Send pings from queue workers/cron in CLI context when `cli_mode` is on.
