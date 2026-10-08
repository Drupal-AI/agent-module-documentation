<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Solr: Boosted Keyword (search_api_solr_boosted_keyword) — agent index

A field type that stores **keyword + boost-level** pairs on an entity, plus a Search API Solr
**event subscriber** that (a) repeats each keyword in the Solr document once per boost level and
(b) rewrites the query with edismax `termfreq` boost functions so chosen documents rank higher for
chosen terms. Version **2.0.0-beta3** (**beta**). Requires **`search_api_solr >= 4.x`** and core
`field`. Core requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

## What it provides
- **Field type** `search_api_solr_boosted_keyword` — properties `value` (varchar 255, the keyword)
  and `boost` (int, default 0). `FieldType/SearchApiSolrBoostedKeyword.php`.
- **Widget** `search_api_solr_boosted_keyword_widget` — a text field + a number field (`#min 1`,
  `#max 20`, default 1). `FieldWidget/SearchApiSolrBoostedKeywordWidget.php`.
- **Formatter** `search_api_solr_boosted_keyword_formatter` — renders `keyword (Boost level: N)`.
  `FieldFormatter/SearchApiSolrBoostedKeywordFormatter.php`.
- **Overview form** at `/admin/config/search/keywords`
  (`BoostedKeywordsOverviewForm`) — filter boosted keywords by content type / language / status,
  and export to CSV. Permission **`administer boosted keywords overview`**.
- **Service** `search_api_solr_boosted_keyword.keywords_manager` (`BoostedKeywordsManager`) —
  raw-SQL lookup of keyword usages across node fields, feeding the overview.
- No config entity, no Search API processor, no config schema, no Drush commands. There is **no
  per-keyword config storage** beyond the field values on each entity.

## The mechanism (both halves live in one event subscriber)
`EventSubscriber/SearchApiSolrBoostedKeywordEventSubscriber.php`:
- **Index** (`SearchApiSolrEvents::POST_CREATE_INDEX_DOCUMENTS` → `alterSolrDocuments`): for each
  indexed field of original type `field_item:search_api_solr_boosted_keyword`, replaces the Solr
  document value with the keyword **repeated `boost` times** (`getKeywordIndexValue()`), stripping
  internal spaces so a phrase indexes as a single token.
- **Query** (`SearchApiSolrEvents::PRE_QUERY` → `alterSolrQuery`): splits the search keys into
  words, **escapes each with `$solarium_query->getHelper()->escapeTerm()`**, and for every boosted
  field adds `termfreq(<solrField>,<term>)^<fieldBoost>` to the edismax boost functions (the
  `^boost` is the Search API **field** boost, `$field->getBoost()`). Forces `defType=edismax` and
  **strips the boosted fields from the edismax query-fields** (`qf`) so they influence ranking, not
  matching. Multi-word keys also get a stronger phrase boost function.

## Effective relevance formula
Per-keyword boost sets **term frequency** in the document; the Search API field boost is the
**multiplier** in the `termfreq(...)^boost` function. A document's lift for a query ≈ (times the
keyword was repeated) × (field boost).

## Three things to hold in mind
1. **Boosting is a relevance signal, not a filter.** A boosted document ranks higher for a term it
   already matches; it does **not** appear for terms it matches nowhere.
2. **Boosts compete.** When every editor boosts their own page the effect cancels — the overview
   form exists so someone can govern this.
3. **The field is index data.** A keyword/boost change takes effect only after that item is
   **reindexed**.

## Setup (from README)
1. Add a *Search API Solr: Boosted Keyword* field to the target bundle(s).
2. Have a Search API server on the Solr backend with an index.
3. Index at least one boosted-keyword field (fulltext advised so the field itself can be boosted).
4. Run a Search API query (e.g. an index View) ordered by relevance.

## Detail docs
- `plugins/field-and-events.md` — field type/widget/formatter and the index/query event subscriber.
- `config/overview-and-permission.md` — the overview form, CSV export, permission and routing.
