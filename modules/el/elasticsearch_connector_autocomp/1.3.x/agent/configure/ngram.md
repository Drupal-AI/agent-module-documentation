# Configure — enabling ngram autocomplete

All configuration is on the Search API **index** (an Elasticsearch Connector server). There is no
module settings page.

## 1. Turn on the analyzer

On *Configuration → Search and metadata → Search API → your index → Edit*, the module adds a
details section **Elasticsearch specific index options**
(`elasticsearch_connector_autocomp_form_search_api_index_form_alter`):

- **Enable ngram analyzer** (`ngram_filter_enabled`, checkbox).
- **Ngram configuration**:
  - **Ngram type** (`ngram_config.ngram_type`): `edge_ngram` (prefix matching) or `ngram`
    (substring matching).
  - **min gram** (`ngram_config.min_gram`, textfield, default `3`) — shortest fragment indexed.
  - **max gram** (`ngram_config.max_gram`, textfield, default `20`) — longest fragment indexed.

These persist as **third-party settings** under the `elasticsearch_connector` provider on the
`search_api_index` config entity (not a module-owned config object). Read them in code with
`$index->getThirdPartySetting('elasticsearch_connector', 'ngram_filter_enabled')` /
`'ngram_config'`.

**Existing index warning:** if you change `ngram_filter_enabled` or `ngram_config` on an index
that already exists, the submit handler (`..._form_submit`) sets an
`eca_confirm_form_values` rebuild and shows a confirm form: *"You are changing the analyzer on an
existing index. This will result in the index being deleted and rebuilt and you will have to
reindex all items."* Confirm to proceed; the index is dropped, recreated, and must be re-indexed.

## 2. Apply the `text_ngram` type to fields

On the index **Fields** tab (`..._form_search_api_index_fields_alter`), when ngram is enabled a
new field type **Fulltext (ngram)** (`text_ngram`) appears in each field's type select, and a
boost select is shown for it. Set the fields you want search-as-you-type on (e.g. title, name) to
**Fulltext (ngram)**. When ngram is disabled the `text_ngram` option is hidden.

## What gets sent to Elasticsearch (`DefaultSubscriber`)

On `elasticsearch_connector.prepare_index` the subscriber injects into the index settings:

```json
{"settings":{"analysis":{
  "filter":{"ngram_filter":{"type":"<ngram_type>","min_gram":<min>,"max_gram":<max>}},
  "analyzer":{"ngram_analyzer":{"type":"custom","tokenizer":"standard","filter":["lowercase","ngram_filter"]}}
}}}
```

On `elasticsearch_connector.prepare_index_mapping`, each `text_ngram` field is mapped as:
`type: text`, `boost: <field boost>`, `analyzer: ngram_analyzer`, `search_analyzer: standard`,
plus a `keyword` sub-field (`ignore_above: 256`) for exact match/sort. Using `search_analyzer:
standard` means query terms are not themselves ngram-expanded, so a typed fragment matches the
indexed ngrams without over-matching.

Tip: `min_gram`/`max_gram` are free-text; enter integers. Large ranges increase index size.
