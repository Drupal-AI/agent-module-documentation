Search API Exclude adds a per-node "exclude from search index" checkbox so editors can keep specific nodes out of a Search API index, enforced by a Search API processor that drops the excluded nodes at index time.

---

Search API Exclude extends Search API with a fine-grained, per-node opt-out from indexing. It defines a `sae_exclude` boolean base field on every node entity and a `node_exclude` Search API processor (running in the `alter_items` stage). Exclusion is enabled per content type: a "Search API Exclude → Enabled" checkbox on the node-type form stores a `search_api_exclude.enabled` third-party setting on the bundle. When enabled for a bundle, the node edit form gains a "Search API Exclude" details group with a "Prevent this node from being indexed" checkbox that writes to `sae_exclude`. On indexing, the `node_exclude` processor inspects each node item, checks whether its bundle has exclusion enabled, and if the node's `sae_exclude` flag is set it removes that item from the batch so it never reaches the search backend. The processor only supports indexes whose datasource covers the `node` entity type. Because the flag is applied at index time, changing a content type's enabled setting or a node's checkbox requires a reindex for the change to take full effect; the module prompts the editor to reindex when the bundle setting changes. It depends on Search API (`^1.3`) and works alongside any Search API server/backend.

---

- Keep a specific node out of a Search API index without unpublishing it.
- Give editors a per-node "Prevent this node from being indexed" checkbox on the node form.
- Enable the exclude checkbox only for the content types where you need it (per-bundle opt-in).
- Hide internal or staging nodes from site search while leaving them publicly viewable.
- Exclude a landing page or thank-you page from search results.
- Stop duplicate or thin-content nodes from polluting search relevance.
- Remove legal/boilerplate nodes (privacy policy, terms) from the searchable set.
- Let content authors self-manage what appears in search without touching the index config.
- Add the `node_exclude` processor to a Search API index to honor per-node exclusions.
- Combine with any backend (database, Solr) since exclusion happens before items reach the server.
- Exclude nodes from one index while keeping them in another (processor is per-index).
- Turn exclusion on for the "Article" bundle but leave "Page" unaffected.
- Reindex after toggling a bundle's Enabled setting so the change takes effect.
- Reindex after flipping a node's checkbox to push the change to the backend.
- Query the `sae_exclude` base field programmatically to find opted-out nodes.
- Set `sae_exclude` in code (entity API) to bulk-exclude nodes during a migration.
- Keep search-excluded editorial notes attached to content that stays live.
- Prevent event nodes past their date from being indexed by scripting the flag.
- Use the third-party `search_api_exclude.enabled` setting to configure bundles as config.
- Export the per-content-type enabled setting with `drush config:export` for deployment.
- Restrict exclusion to node-based indexes (the processor only supports node datasources).
- Offer marketing a simple toggle to pull a page out of on-site search.
- Exclude member-only nodes from a public search index.
- Audit which bundles allow exclusion by reading their `third_party_settings`.
