# search_api — agent start

Generic search framework: **Index** + **Server** config entities, pluggable backends,
datasources, processors, trackers. Admin UI: **Admin → Config → Search and metadata →
Search API** (`/admin/config/search/search-api`, route `search_api.overview`).
Permission: `administer search_api`.

- Create/configure indexes, servers, fields, processors → [configure/indexes-servers.md](configure/indexes-servers.md)
- Plugin types it defines & how to implement one → [plugins/plugin-types.md](plugins/plugin-types.md)
- Build & run a search query, index in code → [api/query-and-index.md](api/query-and-index.md)
- Alter/react to indexing & queries via hooks → [hooks/hooks.md](hooks/hooks.md)
- Drush commands (index, status, tracker, search) → [drush/commands.md](drush/commands.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
