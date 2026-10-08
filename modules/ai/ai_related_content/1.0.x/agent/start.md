<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Related Content (ai_related_content) — agent index

A Views-block integration with **AI Search** that surfaces related content by semantic (vector)
similarity to the current node. Attaches Search API Views plugins to any AI-Search-backed index and
ships a helper form that scaffolds the view from a template.

- Package `AI Related Content`. Core `^10 || ^11`. `configure:
  ai_related_content.create_related_content_form`.
- Dependencies: **`views`**, **`block`**, **`search_api:search_api`**, **`ai:ai_search`** (composer:
  `drupal/ai ^1.2`, `drupal/search_api ^1.0`). Suggests `league/commonmark` (better source-text
  extraction). No Drush.
- **Permission** `administer ai related content` (`restrict access: true`) — the only route.

## What it provides

- **Views filter** `Plugin/views/filter/AIRelatedContentNodeFilter` (`ai_related_content_node_filter`,
  extends `SearchApiFulltext`) — the heavy lifting. Finds content similar to the current node; excludes
  it (`addCondition('nid', [id], 'NOT IN')`); reuses an indexed vector (`getVectorFromNode()`,
  average-pooled) or generates one on demand from the rendered node (`getTextFromNode()` → embedding via
  drupal/ai).
- **Views argument** `Plugin/views/argument/AIRelatedContentNodeArgument`
  (`ai_related_content_node_argument`, extends `SearchApiStandard`) — loads the source node and
  **access-checks it** (`$node->access('view')` in `getNode()`).
- **Views cache** `Plugin/views/cache/AiRelatedContentResultsCache` (`ai_related_content_results`,
  extends `SearchApiTimeTagCache`) — caches **only the entity id** per row (strips `_item`/raw vector),
  optional `strip_relationship_data`.
- **Setup form** `Form/CreateAiRelatedContent` at `/admin/config/ai/ai-related-content-setup` — builds/
  resets the `ai_related_content` view from `config/template-do-not-install/…template.yml` for a chosen
  compatible index (validated select options from `AiRelatedContentManager::findCompatibleIndexes()`).
- **Hooks** `Hook/AiRelatedContentHooks`: `views_data_alter` (registers the filter/argument on each
  `search_api_index_*` table beside the fulltext field), `form_view_edit_form_alter` (misconfig
  warnings), `views_pre_render` (adds the source node's cache tags).
- **Config schema** (`config/schema/…`): the three Views plugins. **Update hooks** (`.install`):
  `10001` recalc cache metadata, `10002` require `access content` on the view, `10003` switch to the
  entity-id-only results cache.

## Docs

- Filter/argument/cache plugins, on-demand vs indexed vectors, access model, caching, setup form,
  hooks, update hooks → [plugins/views_related_content.md](plugins/views_related_content.md)

## Mechanism (one line)

contextual `nid` (route/argument, access-checked) → filter `query()` gets or generates a vector via the
**drupal/ai** VDB + provider abstraction → Search API vector query (backend-parameterized, no raw SQL) →
results filtered by Search API's own per-result `$node->access('view')` → rendered through normal Views/
entity rendering (escaped) and cached (entity-id-only, per node + node-grant).
