<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views plugins, setup form & caching

## Install / operate

`drush en ai_related_content` (pulls `views`, `block`, `search_api`, `ai_search`). Configure AI Search
with a Search API vector database first. Then at **`/admin/config/ai/ai-related-content-setup`**
(permission `administer ai related content`) pick a compatible index and **Create View**; place the
`ai_related_content` block or render it with Twig Tweak. Ensure the index has **`nid` indexed as a
Filterable Attribute** (to exclude the current node) and a **Content access** processor (for per-result
access).

## Filter `ai_related_content_node_filter`

`src/Plugin/views/filter/AIRelatedContentNodeFilter.php`, `@ViewsFilter`, extends
`Drupal\search_api\Plugin\views\filter\SearchApiFulltext`. `getEntityType()` returns `node`.

- Options (`defineOptions()` + schema `views.filter.ai_related_content_node_filter`): `view_mode`
  (default `teaser`), `vector_source_search_api_index` (default `_generate_embedding`),
  `generate_embedding_on_demand_fallback` (default FALSE). `buildOptionsForm()` hides the fulltext
  operator/exposed/value widgets and adds the three selects/checkbox; index options come from
  `AiRelatedContentManager::findCompatibleIndexes()` (indexes whose server backend extends
  `AiSearchBackendPluginBase`).
- `query()`: resolves the current node (`getNodeForRelatedContent()` → argument's access-checked node);
  aborts the Search API query if none. Adds `nid NOT IN [id]` to exclude the current item (NOT IN is
  used because it is in Search API's canonical operator set). Then:
  - `getVectorFromNode()` — when a source index is chosen, queries that index for `drupal_entity_id =
    entity:node/<id>:<lang>`, collects `raw_vector` extra-data from matching result items (guards with
    `str_starts_with($id, $entity_id)`), returns the single vector or `averagePooling()` of chunks. For
    Pinecone it supplies a cached placeholder "Title" vector (`getPineconeTitlePlaceholderVector()`,
    CACHE_PERMANENT, keyed by provider/model/dimensions) because Pinecone cannot do metadata-only
    lookups, and adds an `nid` metadata condition. Requires the server's `include_raw_embedding_vector`.
  - If a vector is found → `setOption('vector_input', $vector)`.
  - Else, when in a source-index mode without the opt-in fallback → abort (no results). Otherwise
    on-demand: `getTextFromNode()` renders the node in `view_mode`, converts to markdown via
    `League\CommonMark\CommonMarkConverter(['html_input'=>'strip','allow_unsafe_links'=>FALSE])` (or
    `strip_tags` fallback), sets it as the fulltext `$this->value`, and calls `parent::query()` so AI
    Search embeds it.
- **Access to results:** unpublished/restricted nodes are NOT excluded by a query condition (unreliable
  on VDB backends); instead Search API's Views query plugin runs a real `$node->access('view')` on every
  result post-query (`SearchApiQuery::addResults()`), which also enforces published status — documented
  inline at `query()`.
- `getCacheMaxAge()`: returns 0 (uncacheable) only when it would generate on demand AND the source node
  has no renderable text (so an empty result is never cached); otherwise the parent max-age.

## Argument `ai_related_content_node_argument`

`src/Plugin/views/argument/AIRelatedContentNodeArgument.php`, extends `SearchApiStandard`. `getNode()`
loads the node from the numeric argument and returns it **only if `$node->access('view')`** — it does
not trust that the caller (page display path arg, `drupal_view()`) already access-checked. `query()` is
a no-op (the filter does the querying). `getTitle()` returns the node label.

## Results cache `ai_related_content_results`

`src/Plugin/views/cache/AiRelatedContentResultsCache.php`, extends `SearchApiTimeTagCache`.
`prepareViewResult()` replaces each row's `_item` with an empty `Item` carrying only index/id/datasource
and clears `_object`, so the **raw embedding vector (potentially >1 MB/row) is never serialized** into
the results cache; `SearchApiRow::preRender()` lazily reloads the real item by id on a cache hit. Option
`strip_relationship_data` (default TRUE) also clears `_relationship_objects` (turn off only when a Views
relationship outputs a field). Schema `views.cache.ai_related_content_results`.

## Setup form `CreateAiRelatedContent`

`src/Form/CreateAiRelatedContent.php`, `FormBase`, route
`ai_related_content.create_related_content_form` (permission `administer ai related content`,
`restrict access: true`, `_admin_route`). `submitForm()` reads
`config/template-do-not-install/views.view.ai_related_content.template.yml`, `str_replace`s
`INDEX_NAME_HERE` / `INDEX_SOURCE_NAME_HERE` with the **selected index machine names** (constrained to
the validated select `#options`), sets each node type's row view mode to `:default`, then creates/updates
the `view` entity through the entity API (so a UUID + cache metadata are generated). Warns that the view
defaults to public access — review who may see the results.

## Hooks & update hooks

- `Hook/AiRelatedContentHooks::viewsDataAlter()` — on each `search_api_index_*` Views table, finds the
  `search_api_fulltext` alias and registers `ai_related_content_node_filter` / `_node_argument` beside it.
- `formViewEditFormAlter()` — builds a fresh executable per display, collects
  `getStaticConfigurationWarnings()` (missing argument, missing/`nid`-not-Filterable-Attribute,
  source-index without raw vectors) and shows them as warnings.
- `viewsPreRender()` — merges the source node's cache tags into `$view->element['#cache']['tags']`.
- `.install`: `update_10001` resaves the view to recalc cache metadata; `update_10002` sets the view's
  access to require `access content`; `update_10003` switches the results cache to
  `ai_related_content_results` (entity-id-only).

## Boundaries (no external I/O of its own)

All embedding/VDB access goes through the **drupal/ai** abstraction (`ai.provider`, `ai.vdb_provider`) —
the module makes no direct HTTP calls and handles no credentials of its own. Search API conditions are
built via the query builder (`addCondition`). Rendered source text is fed to the search query, not
emitted back to the page.
