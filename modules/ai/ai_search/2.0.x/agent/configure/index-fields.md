# Index, tracker, fields & processors

## The tracker — `ai_search_tracker`

When you create an index on an AI Search server, select the **AI Search Chunked Tracker**
(`ai_search_tracker`, `src/Plugin/search_api/tracker/AiSearchTracker.php`, extends Basic). It tracks
per-item chunk progress using the two extra `search_api_item` columns (`total_chunks`,
`processed_chunks`) added at install. `hook_form_search_api_index_form_alter` in `ai_search.module`:

- Removes the `ai_search_tracker` option unless at least one server uses the `search_api_ai_search`
  backend.
- Attaches `ai_search/conditional_tracker` JS and adds a validate handler
  (`ai_search_index_form_validate`) enforcing: AI Search servers **must** use `ai_search_tracker`, and
  `ai_search_tracker` may only be used with AI Search servers.

`trackItemsUpdated()` / `trackAllItemsUpdated()` reset `status`, `total_chunks` (NULL) and
`processed_chunks` (0) only when the index's backend is `search_api_ai_search`, else fall back to
Basic.

## Fields form override — `Form\AiSearchIndexFieldsForm`

`hook_entity_type_alter` replaces the `search_api_index` entity's **`fields`** form handler with
`Drupal\ai_search\Form\AiSearchIndexFieldsForm` (extends Search API's `IndexFieldsForm`). Reached at
the index **Fields** tab (`/admin/config/search/search-api/index/<id>/fields`). It adds, per field, an
**Indexing option** select whose values come from the `ai` enum
`Drupal\ai\Enum\EmbeddingStrategyIndexingOptions`:

- **Main Content** — chunked + embedded (the vectorized body). At least one field must be Main Content;
  most strategies allow only one (validated against
  `EmbeddingStrategyCapability::MultipleMainContent`).
- **Contextual Content** — prepended to every chunk for context (title, taxonomy, …).
- **Filterable Attribute** — stored as VDB metadata for filtering.
- **(Ignore / Not indexed)** — excluded.

Advanced checkboxes: `control_field_max_length` (per-attribute max length inputs), and metadata
trimming flags. The form also has a **"Preview content to be vectorized"** checker: pick a data source
+ entity (autocomplete) and it renders each generated chunk (id, dimensions, metadata) by calling the
embedding strategy's `getChunks()`/`getEmbedding()` — content is markdown-rendered when
`league/commonmark` is present (`html_input: strip`, `allow_unsafe_links: FALSE`). You must clear the
checker before the form will save.

### Per-index config object — `ai_search.index.<index_id>`

Search API can't store custom field config, so `save()` writes a separate config object
(`config/schema/ai_search.index.schema.yml`):

| Key | Type | Meaning |
|---|---|---|
| `index_id` | string | The index id. |
| `control_field_max_length` | bool | Show/apply per-attribute max lengths. |
| `exclude_chunk_from_metadata` | bool | Drop the `content` attribute from stored metadata. |
| `exclude_title` | bool | Don't auto-add the title to chunk metadata (added by update `10006`). |
| `indexing_options` | sequence | Per field: `field_name`, `indexing_option` (enum key), `max` (int, `-1` = unlimited). |

`hook_preprocess_search_api_index` adds a warning row on the index page when `indexing_options` is
empty ("must be configured in the Fields tab first"), and explains that the VDB row-count statistic is
not meaningful.

## Processors

Add these on the index's **Processors** tab.

| Processor id | Class | Stage | Purpose |
|---|---|---|---|
| `ai_search_score_threshold` | `ScoreThreshold` | postprocess_query | Drop result items whose score is below `minimum_relevance_score` (0–1). Overridable per query with the `ai_search_score_threshold_override` option. Only supports AI Search indexes. |
| `database_boost_by_ai_search` | `DatabaseBoostByAiSearch` | preprocess_query | **Hybrid search** on a `search_api_db` index: run the configured AI index first and prepend/re-rank matches. |
| `solr_boost_by_ai_search` | `SolrBoostByAiSearch` | — | Same idea for `search_api_solr` indexes (applied via `PostConvertedQueryEvent`, see the event subscriber). |

Boost processor config (`config/schema/ai_search.processor.schema.yml`): `search_api_ai_index` (which
AI index to combine with), `minimum_relevance_score`, `number_to_return`, `exact_phrase_action`
(`skip`/`reduce`/`continue`), `exact_phrase_action_reduce_number`, `pass_conditions_fields` (which
parent-query field conditions to forward to the AI query). The boost mechanism and its access model are
detailed in [../api/search.md](../api/search.md).
