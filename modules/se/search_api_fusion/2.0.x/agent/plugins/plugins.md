# Plugins provided

The module provides plugin **implementations** of existing plugin types (it defines **no new plugin type**).

| Plugin type | Id | Class | How to enable |
|---|---|---|---|
| Solr connector (`search_api_solr`) | `fusion` | `Plugin\SolrConnector\FusionConnector` | Pick "Fusion" as the Solr connector when adding a Solr backend server. See configure/connector.md. |
| Search API processor | `fusion_request_signal` | `Plugin\search_api\processor\RequestSignal` | Index → **Processors** tab → "Send request signal to Fusion". |
| Autocomplete suggester (`search_api_autocomplete`) | `fusion` | `Plugin\search_api_autocomplete\suggester\FusionSuggester` | Index → **Autocomplete** tab → suggester "Fusion query profile". |
| Views area | `search_api_fusion_spellcheck`, `search_api_fusion_landing_pages` | `Plugin\views\area\*` | Add as header/footer areas — see views/views.md. |
| Views field | `search_api` | `Plugin\views\field\SearchApiFusionStandard` | Overrides search_api's standard field handler — see views/views.md. |

## fusion_request_signal (processor)

Stage `postprocess_query` (weight 0). After a search runs it sends a Fusion **request** signal — but only if
the current user has `send signals to any fusion server`. It loads the server's Fusion connector, flattens the
query keys (`search_api_solr` `Utility::flattenKeys`), adds `page_title` (via `title_resolver`) and `app_id`,
merges facet filters via `FusionConnector::getSignalParamsFilter()`, then calls
`$connector->sendSignal('request', $params)`. Every failure path is logged and swallowed so it never breaks the
search response.

## fusion (autocomplete suggester)

Config key `fusion_qprofile_autocomplete` (required textfield). `getAutocompleteSuggestions()` runs the user
input through `FusionConnector::queryProfile()` against that profile
(`/api/apps/<app>/query/<profile>`, `q` = input, `rows` = query limit or 10), then maps
`response.docs[*].query` into suggestions via `SuggestionFactory`. `supportsSearch()` / `getFusionConnector()`
gate the suggester to indexes whose server actually uses the `fusion` connector. (User input is passed
straight to Solarium, which handles escaping.)
