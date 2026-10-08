# search_api_exclude — agent start

Adds a per-node "exclude from search index" checkbox and a `node_exclude` Search API
processor that drops the flagged nodes at index time. Enabled per content type via a
third-party setting; stores the flag in a `sae_exclude` boolean base field on nodes.
Depends on `search_api`. No admin page of its own (no `configure` route, no custom
permissions).

- Enable exclusion per bundle, use the per-node checkbox, add the processor to an index → [configure/search_api_exclude.md](configure/search_api_exclude.md)
- Who can toggle exclusion (access model, no custom permissions) → [permissions/search_api_exclude.md](permissions/search_api_exclude.md)
