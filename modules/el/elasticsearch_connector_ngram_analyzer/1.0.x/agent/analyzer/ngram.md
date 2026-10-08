<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The n-gram analyzer, data type, and subscribers

## Install & enable

```bash
composer require drupal/elasticsearch_connector_ngram_analyzer
drush en elasticsearch_connector_ngram_analyzer -y
```

Declared dependency (`.info.yml`): `elasticsearch_connector`. The plugins and subscribers also use
Search API (`plugin.manager.search_api.data_type`, `Drupal\search_api\...`), so **`search_api` must
be enabled** even though it is not listed in `.info.yml`. No `composer.json` ships with the module.
No config forms, routes, permissions, config schema, install hooks, or Drush commands.

## Enable it on an index field

1. *Configuration → Search and Metadata → Search API* → edit an Elasticsearch-backed index → **Fields**.
2. For the text field you want partial matching on, set its **type** to **Text Ngram**
   (data type id `text_ngram`).
3. Save, then **Index now** / reindex so the new mapping and analysis settings apply.

That is the whole configuration surface — everything else happens automatically via the subscribers.

## The two plugins

**Data type — `TextNgram`** (`src/Plugin/search_api/data_type/TextNgram.php`)
`@SearchApiDataType(id = "text_ngram", label = "Text Ngram", fallback_type = "text")`, extends
`DataTypePluginBase` with an empty body. It exists so the Fields tab offers "Text Ngram" and so the
mapping subscriber can recognise the field. `fallback_type = "text"` means backends without special
handling treat it as plain text.

**Analyser — `NgramAnalyzer`** (`src/Plugin/ElasticSearch/Analyser/NgramAnalyzer.php`)
`@ElasticSearchAnalyser(id = "ngram_analyzer", ...)`, extends `AnalyserBase`. Two methods:

- `getAnalyzerDefinition()` → `['type' => 'custom', 'tokenizer' => 'es_ngram', 'filter' => ['lowercase']]`
- `getTokenizerDefinition()` → `['type' => 'ngram', 'min_gram' => 3, 'max_gram' => 3, 'token_chars' => ['letter', 'digit']]`

So tokens are **fixed 3-character grams** over letters and digits, lowercased. (There is no
`getFilterDefinition()` override on this plugin.)

## The service

`elasticsearch_connector_ngram_analyzer.analyzer_service` → `AnalyzerService`
(`src/AnalyzerService.php`, implements `AnalyzerServiceInterface`), constructed with
`@plugin.manager.elasticsearch_connector.analyser` (`AnalyserManager`). Its
`getAnalyzerDefinition($plugin_id)`, `getTokenizerDefinition($plugin_id)`, and
`getFilterDefinition($plugin_id)` each `createInstance($plugin_id)` and return the corresponding
definition. It is a thin lookup used by the settings subscriber.

## The three event subscribers (`src/EventSubscriber/`, registered in `.services.yml`)

**`AlterSettingsSubscriber::onAlterSettings()`** — subscribes to
`elasticsearch_connector` `AlterSettingsEvent`. It reads the current settings and adds:

- `analysis.analyzer.ngram_analyzer` = `analyzerService->getAnalyzerDefinition('ngram_analyzer')`
- `analysis.tokenizer.es_ngram` = `analyzerService->getTokenizerDefinition('ngram_analyzer')`

then `$event->setSettings($settings)`. This is what puts the analyzer/tokenizer into the created
Elasticsearch index settings. (Constructor also injects `plugin.manager.search_api.data_type`.)

**`MappingFieldTypesEventSubscriber::onFieldMapping()`** — subscribes to `elasticsearch_connector`
`FieldMappingEvent`. It returns early unless `$field->getType() === 'text_ngram'`; for such fields it
sets the mapping param to:

```php
[
  'type' => 'text',
  'analyzer' => 'ngram_analyzer',
  'fields' => ['keyword' => ['type' => 'keyword', 'ignore_above' => 256]],
]
```

i.e. a `text` field analyzed by `ngram_analyzer`, with an exact-match `keyword` sub-field
(`ignore_above: 256`).

**`QueryParamsEventSubscriber::onElasticsearchBuildQuery()`** — subscribes to `elasticsearch_connector`
`QueryParamsEvent`, constructed with `@current_route_match`. It locates the `query_string` clause at
either `body.query.bool.must.query_string` or `body.query.query_string`; if none, it returns. It then
`preg_replace('/( AND|~)/', '', $keys)` on the query text (removing ` AND` tokens and `~`) and sets
`default_operator = 'AND'`, writing the params back. This normalises how multi-term queries are run
against the n-gram field.

## Notes

- Grams are fixed at length 3 (min = max = 3), hard-coded in `NgramAnalyzer` — not configurable via UI.
- Reindex after enabling `text_ngram` on a field; existing documents keep their old mapping until reindexed.
- All behaviour is triggered by the `elasticsearch_connector` events above, so it only takes effect on
  indexes served by that connector.
