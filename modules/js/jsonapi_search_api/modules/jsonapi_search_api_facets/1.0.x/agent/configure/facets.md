<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API facets: plugins, events, and how a facet is configured

The submodule provides Facets plugins and event subscribers; it defines no plugin *type* and
has no settings form. Configuration lives in Facets' own config entities.

## Plugins

- **Facet source** `jsonapi_search_api_facets` — `Plugin\facets\facet_source\JsonApiFacets`
  with deriver `JsonApiFacetsDeriver`: one derivative per **enabled index whose server
  supports `search_api_facets`**, id `jsonapi_search_api_facets:<index_id>`, display id
  `jsonapi_search_api_facets_<index_id>`.
  (Note: the deriver calls `$index->getServerInstance()->supportsFeature(...)`; an index with
  no server can make it error, so keep serverless indexes off facets-capable sites.)
- **Widget** `jsonapi_search_api` — `Plugin\facets\widget\JsonApiResponseWidget`: renders a
  facet as JSON for the response instead of HTML.
- **URL processor** `json_api` — `Plugin\facets\url_processor\JsonApiQueryString`: reads and
  writes facet state via the JSON:API `filter` query parameter.

## Configuring a facet (Facets UI or config)

1. Create a facet in the Facets module (`facets_facet` config entity) whose **source** is
   `jsonapi_search_api_facets:<index_id>` and whose `field_identifier` is an indexed field.
2. On save, the submodule's presave hooks apply the right defaults automatically:
   - `jsonapi_search_api_facets_facets_facet_presave()` — if the facet's source starts with
     `jsonapi_search_api_facets` and no widget is set, it sets the widget to
     `jsonapi_search_api`.
   - `jsonapi_search_api_facets_facet_source_presave()` — a `jsonapi_search_api_facets:*`
     facet **source** config gets filter key `filter` and URL processor `json_api`.
   - Form alters lock the source's URL processor to `json_api`, hide the breadcrumb option,
     and restrict facet widgets to the `jsonapi_*` ones (and vice-versa for other sources).

Programmatic example:
```php
use Drupal\facets\Entity\Facet;
$facet = Facet::create([
  'id' => 'content_type',
  'name' => 'Content type',
  'facet_source_id' => 'jsonapi_search_api_facets:content',
  'field_identifier' => 'type',
  'url_alias' => 'type',
]);
$facet->save();                       // widget is now 'jsonapi_search_api'
$facet->getWidget()['type'];          // 'jsonapi_search_api'
```

## Runtime (how facets reach the response)

- `SearchApiQueryPreExecute` (Search API `QUERY_PRE_EXECUTE`): for a `jsonapi_search_api:<id>`
  search on a facets-capable server, it calls `facetManager->alterQuery()` to add facet
  aggregations, tags OR-operator facet conditions (`facet:<field>`), and removes alias-only
  conditions.
- `AddSearchMetaEventSubscriber` (`jsonapi_search_api.add_search_meta`): builds each facet for
  source `jsonapi_search_api_facets:<index>`, sorted by weight, and sets `meta.facets` on the
  response.

So on the client: `GET /jsonapi/index/content?filter[type]=article` selects the facet and the
response includes `meta.facets` with counts. Hierarchical facets, minimum count and hard
limit are not yet honored.
