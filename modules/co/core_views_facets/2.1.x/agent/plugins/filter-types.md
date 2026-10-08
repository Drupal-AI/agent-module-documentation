<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter-type plugins (and the facet source / URL processor plugins)

The module maps each Views **filter/argument** to a "filter type" plugin that knows how to build
the facet's count query and turn raw DB rows into facet results. It defines two plugin types.

## The two plugin types

| Plugin type id | Manager service | Annotation | Directory |
|---|---|---|---|
| `core_views_facets_exposed_filter_types` | `plugin.manager.core_views_facets.exposed_filter_types` | `@CoreViewsFacetsExposedFilterType` | `Plugin/facets/processor/exposed_filter_type/` |
| `core_views_facets_contextual_filter_types` | `plugin.manager.core_views_facets.contextual_filter_types` | `@CoreViewsFacetsContextualFilterType` | `Plugin/facets/processor/contextual_filter_type/` |

Both managers extend `default_plugin_manager`; both annotations extend Facets' `FacetsProcessor`.
A plugin's **`id` must equal the Views filter/argument `plugin_id`** it handles (that is how the
module selects a handler for a given filter). Implementations extend
`Drupal\core_views_facets\CoreViewsFacetsFilterType` and implement
`CoreViewsFacetsFilterTypeInterface`:

- `prepareQuery(ViewExecutable $view, HandlerBase $handler, FacetInterface $facet)` — alter/return
  the count query.
- `processDatabaseRow(\stdClass $row, HandlerBase $handler, FacetInterface $facet): Result` —
  turn a result row into a facet `Result` (set raw + display value).

### Shipped implementations

Exposed (`exposed_filter_type/`): `taxonomy_index_tid` (Term — loads term labels), `bundle`
(node bundle), `boolean`, `generic` (fallback).
Contextual (`contextual_filter_type/`): `node_type`, `generic` (fallback).

### Skeleton for a custom exposed filter type

```php
namespace Drupal\my_module\Plugin\facets\processor\exposed_filter_type;

use Drupal\core_views_facets\CoreViewsFacetsFilterType;
use Drupal\facets\FacetInterface;
use Drupal\views\Plugin\views\HandlerBase;

/**
 * @CoreViewsFacetsExposedFilterType(
 *   id = "my_views_filter_plugin_id",
 *   label = "My filter type"
 * )
 */
class MyFilterType extends CoreViewsFacetsFilterType {
  public function processDatabaseRow(\stdClass $row, HandlerBase $handler, FacetInterface $facet) {
    $result = parent::processDatabaseRow($row, $handler, $facet);
    // e.g. $result->setDisplayValue(<human label for $result->getRawValue()>);
    return $result;
  }
}
```

## The facet_source & url_processor plugins (context)

- Facet sources (Facets `@FacetsFacetSource`): `core_views_exposed_filter` and
  `core_views_contextual_filter`, each with a deriver that emits one derivative per matching view
  display. Base class `CoreViewsFacetSourceBase` (default `urlProcessor = 'core_views_url_processor'`).
- URL processor (Facets `@FacetsUrlProcessor`): `core_views_url_processor` ("Core views url
  processor") — must be assigned on the facet source (see
  [../configure/setup-facet.md](../configure/setup-facet.md)); it builds query URLs the way Views
  exposed filters read them.

These are Facets plugins, not new plugin *types* — you implement them only if extending the
module itself.
