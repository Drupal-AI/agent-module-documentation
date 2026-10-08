# Plugin types defined by facets

Declared in `facets.plugin_type.yml` (+ a hierarchy manager in `facets.services.yml`). Each
has an annotation class in `src/Annotation/` and a discovery namespace `Plugin/facets/<dir>`.

| Plugin type id | Manager service | Annotation | Namespace / base | Purpose |
|---|---|---|---|---|
| `facets_widget` | `plugin.manager.facets.widget` | `@FacetsWidget` | `Plugin/facets/widget`, `WidgetPluginBase` | Renders a facet's results (links, checkbox, dropdown, array). |
| `facets_processor` | `plugin.manager.facets.processor` | `@FacetsProcessor` | `Plugin/facets/processor`, `ProcessorPluginBase` | Transform/sort/filter facet data at `pre_query`/`post_query`/`build`/`sort` stages. |
| `facets_query_type` | `plugin.manager.facets.query_type` | `@FacetsQueryType` | `Plugin/facets/query_type` | Maps a Search API data type to backend query logic (string, date, range, granular). |
| `facets_url_processor` | `plugin.manager.facets.url_processor` | `@FacetsUrlProcessor` | `Plugin/facets/url_processor` | Reads/writes active facets to the URL (default: `QueryString`). |
| `facets_facet_source` | `plugin.manager.facets.facet_source` | `@FacetsFacetSource` | `Plugin/facets/facet_source` | Bridges a facet to its search backend (default: Search API display, derived). |
| `facets_hierarchy` | `plugin.manager.facets.hierarchy` | `@FacetsHierarchy` | `Plugin/facets/hierarchy` | Provides nested parent/child structure (Taxonomy, DateItems). |

- Processor stages/interfaces: `PreQueryProcessorInterface`, `PostQueryProcessorInterface`,
  `BuildProcessorInterface`, `SortProcessorInterface` (constants `STAGE_*` on `ProcessorInterface`).
- Widget plugins declare a default query type via `getQueryType()` and `supportsFacet()`.
- To implement one, see [widget-processor.md](widget-processor.md).
