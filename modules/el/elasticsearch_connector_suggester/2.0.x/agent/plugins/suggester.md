<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Suggester plugin `elastic_live_results` + Tokenizer processor

## Install & enable

1. `drush en elasticsearch_connector_suggester` (pulls `elasticsearch_connector`,
   `search_api_autocomplete`, `search_api`).
2. On the Search API **index** (backed by an Elasticsearch Connector server), *Processors* tab →
   enable **"Elasticsearch Connector Suggester Tokenizer"** and set its options.
3. *Autocomplete* tab → enable a search, choose suggester **"Elastic display live results"**, pick
   the fulltext **field(s)**, choose the **Analyzer**, save. Saving triggers a mapping rebuild (see
   `api/events.md`).

There is **no settings route, permission or config object** owned by this module; all config lives
inside the `search_api_autocomplete_search` entity's suggester settings and the index/processor
config.

## Suggester: `ElasticLiveResults`

`src/Plugin/search_api_autocomplete/suggester/ElasticLiveResults.php`, annotation
`@SearchApiAutocompleteSuggester(id = "elastic_live_results", label = "Elastic display live
results")`. Extends `Drupal\search_api_autocomplete\Plugin\search_api_autocomplete\suggester\LiveResults`
and implements `PluginFormInterface`. `create()` injects `search_api.fields_helper` and `renderer`.

- **`defaultConfiguration()`** = parent config + `'analyzer' => 'standard'`.
- **`buildConfigurationForm()`** = parent form + a `#type => select` **`analyzer`** with options
  `standard, simple, whitespace, stop, keyword, pattern, fingerprint`. This analyzer choice is read
  later by the field-mapping subscriber to build the ES `completion` mapping.
- Inherits parent settings such as `fields`, `view_modes`, `suggest_keys`, and `highlight`.

### `getAutocompleteSuggestions($query, $incomplete_key, $user_input)`

1. Restricts `fields` to still-valid fulltext fields (`$index->getFulltextFields()`), else logs a
   warning; sets `$query->keys($user_input)` and runs `$query->execute()` (empty array on
   `SearchApiException`).
2. If the normal result set is empty, it reads the raw ES response from
   `$results->getAllExtraData()['elasticsearch_response']`: first `hits.hits`, otherwise
   `suggest.autocomplete[0].options`; for each it builds a Search API item via
   `fieldHelper->createItem($index, $id)` and sets the `_score`.
3. Loads objects with `$index->loadItemsMultiple(...)` and a `SuggestionFactory($user_input)`, then
   per item:
   - **skips items with no loaded object, no datasource, no view access
     (`$item->getAccessResult()->isAllowed()`), or no item URL** — access is enforced here.
   - **highlight** on: emits `Xss::filterAdmin($highlighted_fields[$field][0])` as `#markup` via
     `factory->createUrlSuggestion($url, NULL, $render)`.
   - **`suggest_keys`** on: resolves a label (item label, or the first configured field's value read
     from the entity) and returns `factory->createFromSuggestedKeys($label)`.
   - no view mode for the bundle: `factory->createUrlSuggestion($url, $label)`.
   - view mode set: `datasource->viewItem($object, $view_mode)` (excerpt added as
     `#search_api_excerpt`) wrapped in `createUrlSuggestion`.

The plugin does not own the autocomplete route — Search API Autocomplete's
`search_api_autocomplete.autocomplete` route (and its per-search access) still governs the request.

## Processor: `Tokenizer`

`src/Plugin/search_api/processor/Tokenizer.php`, annotation
`@SearchApiProcessor(id = "elasticsearch_connector_suggester_tokenizer", label = "Elasticsearch
Connector Suggester Tokenizer")`, stages `pre_index_save=0`, `preprocess_index=-6`,
`preprocess_query=-6`. Extends core `search_api` `Tokenizer`.

- `processFieldValue(&$value, $type)`: `simplifyText()` then `explode(' ')`; keeps numeric tokens or
  tokens `>= configuration['minimum_word_size']`, each wrapped by `Utility::createTextToken()`.
- `process(&$value)`: trims `simplifyText()` output and, when `minimum_word_size > 1`, drops
  non-numeric words shorter than the minimum.

All other tokenizer options come from the core parent processor; configure them on the index's
*Processors* tab.
