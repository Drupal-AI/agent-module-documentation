<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field plugins and the Solr event subscriber

## Field type — `search_api_solr_boosted_keyword`
`src/Plugin/Field/FieldType/SearchApiSolrBoostedKeyword.php`, extends `FieldItemBase`.

- Properties (`propertyDefinitions`): `value` (string, **required**, label "Keyword") and `boost`
  (integer, **required**, label "Boost level").
- Storage schema (`schema`): `value` varchar length 255; `boost` int, `not null`, default `0`.
- `isEmpty()` returns true when `value` is `NULL` or empty string (boost alone does not count).
- `default_widget` = `search_api_solr_boosted_keyword_widget`;
  `default_formatter` = `search_api_solr_boosted_keyword_formatter`.

Cardinality is whatever you set on the field — set it to unlimited to attach several keywords with
different boosts to one entity.

## Widget — `search_api_solr_boosted_keyword_widget`
`src/Plugin/Field/FieldWidget/SearchApiSolrBoostedKeywordWidget.php`, extends `WidgetBase`.

- Renders a `textfield` (**Keyword**) and a `number` field (**Boost level**, `#min 1`, `#max 20`,
  `#step 1`, default `1`). Note the storage default is `0` but the widget default and minimum are
  `1`.
- Single-cardinality fields render as a `fieldset`; multi-value fields render as an inline flex
  `container` (`display:flex;`). Cosmetic inline styles only.

## Formatter — `search_api_solr_boosted_keyword_formatter`
`src/Plugin/Field/FieldFormatter/SearchApiSolrBoostedKeywordFormatter.php`, extends `FormatterBase`.

- `viewElements()` renders each item via an `inline_template` as `{{ value|nl2br }} (Boost level: N)`
  where `N` is `$item->boost`. `value` goes through Twig autoescaping; `boost` is an integer column.

## Event subscriber — the actual Solr integration
`src/EventSubscriber/SearchApiSolrBoostedKeywordEventSubscriber.php`, service
`search_api_solr_boosted_keyword.query_alter_subscriber` (arg `@language_manager`). This is where
the boosting happens — there is **no Search API processor**.

Subscribed events (`SearchApiSolrEvents`):
- `POST_CREATE_INDEX_DOCUMENTS` → `alterSolrDocuments()`
- `PRE_QUERY` → `alterSolrQuery()`

### Indexing (`alterSolrDocuments`)
1. Loads the index from the first document's `index_id`; bails if null.
2. Finds index fields whose `getOriginalType()` is `field_item:search_api_solr_boosted_keyword`,
   mapping them to their per-language Solr field names via
   `SolrBackendInterface::getSolrFieldNamesKeyedByLanguage()`.
3. For each document, matches it back to its Search API item / content entity by language, and for
   each keyword field calls `getKeywordIndexValue()`:
   - For each field value, appends the keyword (with **all spaces removed**,
     `str_replace(' ', '', $value)`) to the indexed value **`boost` times** — boost 3 → the token
     appears three times. Space removal keeps a multi-word keyword as a single token so `termfreq`
     works on it.
4. Writes the rebuilt value back with `$document->setField()`.

So the **per-keyword boost controls term frequency** in the Solr document.

### Querying (`alterSolrQuery`)
1. Re-derives the boosted Solr fields for the query's languages; the boost used here is the Search
   API **field** boost (`$field->getBoost()`), not the per-keyword value.
2. Splits the query keys into words (`termfreq` does not accept phrases), and **escapes each word
   with `$solarium_query->getHelper()->escapeTerm()`** before use.
3. Builds boost functions `termfreq(<solrField>,<escapedTerm>)^<fieldBoost>`. Multi-word keys also
   get an extra, stronger phrase-boost function on the space-stripped concatenation
   (`^ intval(boost) * wordCount`).
4. On a Solarium `Select\Query\Query`: sets the edismax boost functions, forces `defType=edismax`
   (so the parser is not converted back to lucene), and **removes the boosted fields from the
   edismax query-fields** (`qf`) with a `preg_replace` so they contribute to ranking but not to
   the match set.

### Relevance formula
Document lift for a query ≈ (repeat count from per-keyword boost) × (Search API field boost).
Because boosted fields are pulled out of `qf`, a keyword only *raises the rank* of a document that
already matches on some real field — it never makes a non-matching document appear.

## Practical notes
- Changing a keyword/boost only takes effect after the item is **reindexed**.
- The search term is escaped (`escapeTerm`) before entering the boost function, so a user's search
  string cannot inject Solr function syntax. Field names and boosts come from index config (admin).
