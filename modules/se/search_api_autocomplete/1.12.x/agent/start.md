# search_api_autocomplete — agent start

Adds type-ahead autocomplete to Search API searches. Requires `search_api`. Configured
per index at **Admin → Config → Search → Search API → [index] → Autocomplete**
(`/admin/config/search/search-api/index/{index}/autocomplete`). Each enabled search is a
`search_api_autocomplete_search` config entity. No `configure` route (per-index tab).

- Enable/configure autocomplete on a search → [configure/searches.md](configure/searches.md)
- Suggester & search plugin types (build your own) → [plugins/plugin-types.md](plugins/plugin-types.md)
- Alter suggestions / fields via hooks → [hooks/hooks.md](hooks/hooks.md)
- Services & programmatic helpers → [api/services.md](api/services.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
