# Hooks (facets.api.php)

Facets invites one alter hook.

| Hook | Signature | Use |
|---|---|---|
| `hook_facets_search_api_query_type_mapping_alter` | `($backend_plugin_id, array &$query_types)` | Change which query-type plugin handles a Search API data type for a given backend (e.g. use a Solr-specific string query type). |

```php
function mymodule_facets_search_api_query_type_mapping_alter($backend_plugin_id, array &$query_types) {
  if ($backend_plugin_id === 'search_api_solr') {
    $query_types['string'] = 'search_api_solr_string';
  }
}
```

- Implement in `mymodule.module` or a `src/Hook/` class (`#[Hook(...)]`).
- `$query_types` is keyed by data type; values are `facets_query_type` plugin ids
  (see [../plugins/plugin-types.md](../plugins/plugin-types.md)).
- Reference: `Drupal\facets\Plugin\facets\facet_source\SearchApiBaseFacetSource`.
