# RAG plugins (function call, assistant action, explorer)

These are plugins ai_search provides to **other AI-suite modules**, so an assistant/chatbot/agent can
retrieve passages from an AI Search index. They all run a normal Search API query on the index — access
control is the same model as in [../api/search.md](../api/search.md).

## Function-call tool — `ai_search:rag_search`

`src/Plugin/AiFunctionCall/RagTool.php` — an `ai` module FunctionCall
(`#[FunctionCall(id: 'ai_search:rag_search', function_name: 'ai_search_rag_search', group:
'information_tools')]`). Lets a tool-calling LLM search one index. Context params: `index` (required,
the index id), `search_string` (required), `amount` (default 10), `min_score` (default 0.5).

`execute()` loads the index, runs `query([...])->setOption('search_api_ai_get_chunks_result', TRUE)`,
sets the keys, filters by `min_score`, and returns the matching chunks' `content` as a formatted text
block. It **does not** set `search_api_bypass_access`, so the backend's per-entity `view` check runs
against the current user — the tool cannot surface content the caller can't view.

## Assistant action — `rag_action`

`src/Plugin/AiAssistantAction/RagAction.php` — an `ai_assistant_api` action
(`#[AiAssistantAction(id: 'rag_action')]`) exposing two actions: **`search_rag`** (search a configured
RAG database) and **`reuse_rag`** (reuse a prior answer from context). Each configured "RAG database"
(built in `ragSegment()`) has: `database` (index id), `description`, `score_threshold`, `min_results`,
`max_results`, `output_mode` (`chunks` | `rendered`), `rendered_view_mode`, `aggregated_llm` (prompt
template with `[question]`/`[entity]` tokens), `allow_access_bypass`, `try_reuse`, `context_threshold`.

- **`chunks` mode** returns raw chunk `content`.
- **`rendered` mode** loads each matched entity, renders it in the chosen view mode, converts to
  markdown (`league/html-to-markdown`, tags stripped), and makes a follow-up LLM call to summarise
  against the question.

### Access control (default-deny)

- `getRagResults()` sets `search_api_bypass_access` to
  **`!empty($rag_database['allow_access_bypass'])`** — i.e. access is **enforced unless the admin ticks
  the box**.
- `fullEntityCheck()` additionally re-checks each loaded entity:
  `if (empty($allow_access_bypass) && !$entity->access('view', $currentUser)) continue;`.
- The `allow_access_bypass` checkbox is warning-labelled ("Only enable this for fully public
  indexes…"). Install update **`ai_search_update_10009`** migrated the legacy opt-in `access_check`
  flag to this opt-out `allow_access_bypass` (default FALSE), forcing the safe default on existing
  configs. Configure it on the AI Assistant entity (`ai_assistant_api.ai_assistant.*`).

## AI API Explorer — `vector_db_generator`

`src/Plugin/AiApiExplorer/VectorDBGenerator.php` — an `ai_api_explorer` plugin
(`#[AiApiExplorer(id: 'vector_db_generator', title: 'Vector DB Explorer')]`) giving a form to try a
prompt against an AI Search index and see the ranked rows. This is an **admin debugging tool**, reached
only through the AI API Explorer UI (which is permission-gated by the `ai_api_explorer` module), and it
deliberately sets `search_api_bypass_access = TRUE` so an administrator can inspect all matches. Row
values are `htmlspecialchars`-escaped; the `content` column is rendered through CommonMark into
`#markup` (Xss::filterAdmin applies). `isActive()` only shows it when an enabled index uses the
`search_api_ai_search` backend and an embeddings provider exists.
