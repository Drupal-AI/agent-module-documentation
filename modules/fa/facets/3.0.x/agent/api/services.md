# Services & programmatic API

Key services (`facets.services.yml`):

| Service | Class / interface | Use |
|---|---|---|
| `facets.manager` | `DefaultFacetManager` | Central orchestrator: loads facets for a source, runs processors, builds render arrays. `getFacetsByFacetSourceId($id)`, `build($facet)`, `processFacets($source_id)`, `returnProcessedQueryResults()`. |
| `plugin.manager.facets.widget` | `WidgetPluginManager` | Discover/instantiate widget plugins. |
| `plugin.manager.facets.processor` | `ProcessorPluginManager` | Discover processors; `getProcessorsByStage()`. |
| `plugin.manager.facets.query_type` | `QueryTypePluginManager` | Map data types to query logic. |
| `plugin.manager.facets.url_processor` | `UrlProcessorPluginManager` | Active-filter URL handling. |
| `plugin.manager.facets.facet_source` | `FacetSourcePluginManager` | Facet sources (Search API displays, derived). |
| `plugin.manager.facets.hierarchy` | `HierarchyPluginManager` | Nested facet structure. |
| `facets.utility.url_generator` | `FacetsUrlGenerator` | Build URLs for a set of active facet values (decoupled/programmatic links). |
| `facets.utility.date_handler` | `FacetsDateHandler` | Format/parse dates for date facets. |

```php
/** @var \Drupal\facets\FacetManager\DefaultFacetManager $fm */
$fm = \Drupal::service('facets.manager');
$facets = $fm->getFacetsByFacetSourceId('search_api:views_page__solr_search__page_1');
foreach ($facets as $facet) {
  $render = $fm->build($facet);   // renderable array for the facet block
}
```

- Facet entities: load via `\Drupal::entityTypeManager()->getStorage('facets_facet')`.
- Event subscribers (`SearchApiSubscriber`, `ConfigurationSubscriber`) wire facets into
  Search API query execution and rebuild facet blocks on config changes automatically.
- Cache context `facets_filter` varies render caching by active facets.
