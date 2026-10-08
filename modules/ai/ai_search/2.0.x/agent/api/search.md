# Querying, options, similarity search, boost & hooks

AI Search has **no routes or services you call directly** — you drive it through a normal Search API
query on the index, and `SearchApiAiSearchBackend::search()` (`src/Plugin/search_api/backend/
SearchApiAiSearchBackend.php:414`) does the vector lookup.

## Run a semantic query from PHP

```php
$index = \Drupal::entityTypeManager()->getStorage('search_api_index')->load('my_ai_index');
$query = $index->query(['limit' => 10]);
$query->keys('how do I cancel my membership');   // free text; embedded into a query vector
$results = $query->execute();
foreach ($results->getResultItems() as $item) {
  $score   = $item->getScore();                       // similarity/distance score
  $content = $item->getExtraData('content');          // chunk text (unless excluded from metadata)
  $eid     = $item->getExtraData('drupal_entity_id'); // "entity:node/123:en"
}
```

The backend turns `keys()` into a single embedding vector (it joins the terms and calls the
`embeddings_engine` provider), then asks the VDB for nearest neighbours.

## Query options the backend honours

Set with `$query->setOption($name, $value)`:

| Option | Type | Effect |
|---|---|---|
| `search_api_bypass_access` | bool (default FALSE) | Skip the per-entity `view` access check. **Leave FALSE** for user-facing search. See access model below. |
| `search_api_ai_get_chunks_result` | bool | Return one result per **chunk** (id `entity_id:chunk_id`, keyed by `drupal_long_id`) instead of one per entity. Used by the RAG plugins. |
| `search_api_ai_max_pager_iterations` | int (default 10) | Max iterations when backfilling the limit past access-denied items. |
| `vector_input` | float[] | Search by a **pre-computed vector** instead of `keys()` — this is how similarity/"more like this" search works. |
| `ai_search_score_threshold_override` | float | Overrides the `ai_search_score_threshold` processor's minimum (see [../configure/index-fields.md](../configure/index-fields.md)). |

Result-set extra data set by the backend: `real_offset`, `reason_for_finish` (`limit` / `max_retries`
/ `reached_end` / `client_error` / `search_error`), `current_vector_score`. Per-item extra data:
everything the VDB returned (`content`, `drupal_entity_id`, `drupal_long_id`, …) plus `raw_vector` when
`include_raw_embedding_vector` is enabled on the server.

## Similarity search (find related content)

Enable **Include raw embedding vector** on the server, fetch a source entity's vector, then query with
it:

```php
// 1. Get the stored vector for node 123.
$q = $index->query();
$q->addCondition('drupal_entity_id', 'entity:node/123:en');
$src = $q->execute()->getResultItems()[0]->getExtraData('raw_vector');

// 2. Find nearest neighbours to that vector.
$q2 = $index->query();
$q2->setOption('vector_input', $src);
$related = $q2->execute();
```

The contrib module *AI Related Content* wraps this pattern.

## Access control model (important)

Because a vector index returns nearest neighbours with no notion of Drupal grants, the backend applies
access **after** the VDB returns candidates:

- `search()` reads `search_api_bypass_access` (default **FALSE** → access enforced).
- In `doSearchWithIteration()` each candidate is checked by `checkEntityAccess($drupal_entity_id)`
  (`:845`), which loads the entity, resolves the translation, and returns
  `$entity->access('view', $this->currentUser)`. Entities that fail to load are **denied** (fail
  closed).
- To still fill the requested `limit` after denials, the backend over-fetches (`limit * 2`) and
  iterates up to `maxAccessRetries` (default 10, or `search_api_ai_max_pager_iterations`), excluding
  already-seen ids each pass.
- When grouping is available and access is enforced (non-chunked), it uses
  `vectorSearchWithGrouping()` to avoid duplicate entities.

Callers that legitimately bypass access: the admin **VDB Explorer** form and the **hybrid boost**
processors (they only compute candidate ids for re-ranking a separately-access-filtered traditional
index). The RAG assistant action exposes an explicit, warning-labelled opt-out. See
[../plugins/rag.md](../plugins/rag.md).

## Hybrid boost mechanism

`BoostByAiSearchBase::getAiSearchResults()` runs the configured AI index (with
`search_api_bypass_access = TRUE`), keeps ids scoring above `minimum_relevance_score`, and invokes the
alter hook (below). `DatabaseBoostByAiSearch::preprocessSearchQuery()` then tags the *database* query
with `ai_search_ids:<comma-list>`; `ai_search_query_search_api_db_search_alter()` (in `ai_search.module`)
calls `DatabaseBoostByAiSearch::queryAlter()`, which rewrites the SQL to OR-in `item_id IN (:ids)`
alongside the keyword condition and adds a `CASE`-based `ai_boost` sort column. **All ids are bound as
placeholders** — no SQL is built from raw strings. The final result set is still produced (and
access-filtered) by the database/Solr backend. Solr uses `SolrBoostByAiSearchEventSubscriber` on
`PostConvertedQueryEvent`. Language normalization maps VDB result languages onto the query's allowed
languages.

## Hooks

- **Provided** (`ai_search.api.php`):
  `hook_ai_search_boost_results_alter(array &$results, mixed $keywords, IndexInterface $ai_search_index,
  IndexInterface $target_index)` — re-rank/filter the `entity_id => score` map before it is applied to
  the traditional index.
- **Alter invoked**: `embedding_strategy_info` (plugin definitions of the `EmbeddingStrategy` type).
