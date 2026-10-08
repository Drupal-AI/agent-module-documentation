Decoupled Toolbox for Group adds a collection endpoint that lists a specific Group's content entities as decoupled JSON.

---

Provides `GET /decoupled-api/group/{gid}/{type}/{bundle}/collection` (route `decoupled_toolbox.group.entity_decoupled_data.collection`, permission `access decoupled api`), handled by `GroupEntityDecoupledDataController`. It validates paging/filter params via the parent `RequestEntity`, loads the Group by `{gid}`, resolves the matching `GroupContent` plugin for the requested `{type}`/`{bundle}` on the group type, collects the referenced target entities (batched by 50), applies the same `filter[i][f|v|c]` conditions, and renders each entity through the parent decoupled renderer. Requires the contrib Group module. It bundles the Group Content Menu sub-module. Note: the same permission/access considerations as the base collection endpoint apply.

---

- Serve the content of a single Group as a decoupled feed.
- Build a headless section/site backed by one Group.
- List `node`/`article` entities that belong to group 42 at `/decoupled-api/group/42/node/article/collection`.
- Page and filter group content with `offset`, `limit`, and `filter[i][...]`.
- Select an alternate display with `?display=`.
- Combine with Group Content Menu to also expose group menus.
