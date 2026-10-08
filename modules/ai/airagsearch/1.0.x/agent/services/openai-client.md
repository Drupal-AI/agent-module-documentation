<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# airagsearch — RAG flow & services

## End-to-end RAG (search page)
1. `AISearchForm` (`/airagsearch`) renders the query box + a CSRF hidden field
   (`csrf_token->get(<airagsearch.query path>)`). JS (`js/ai-search.js`) POSTs to
   `airagsearch/query` with the token in the `token` param and `X-CSRF-Token` header.
2. `AISearchController::query()`:
   - Reads `query` (falls back to `airagsearch_query` in session), `page`, `result` per-page.
   - Loads `search_api_index`, runs `$index->query()` with lowercased whitespace-split keys, sorts
     by `search_api_relevance`, ranges by page.
   - For each result item: extracts `title`, canonical `url` (`entity->toUrl()->setAbsolute()`),
     a cleaned `snippet` and a `body_text` (from `body`/`field_body`/`search_api_fulltext`/
     `rendered_item`) via `strip_tags` + a long chain of CSS/HTML-stripping `preg_replace`s,
     capped at `ai_context_length`.
   - Builds `ai_context_docs` (up to `ai_context_results_count`) and, on `page === 0`, calls
     `OpenAIClient::askChatGPT($query, $docs)`.
   - Logs via `AnalyticsLogger::logSearch()` and returns JSON `{query, ai_response, results, pager}`.
3. JS renders results with `escapeHtml()` + `sanitizeUrl()`. Server-rendered path
   (`AISearchForm::buildForm`) escapes with `htmlspecialchars` and runs the AI answer through
   `MarkdownProcessor::convertToHtml()`; the twig template outputs `{{ ai_response|nl2br }}`
   (Twig auto-escaped).

## `Service\OpenAIClient`
- Constructor pulls `openai_api_key` from `airagsearch.settings`; logs an error if absent.
- `askChatGPT(query, context)` and `askChatGPTSummary(query, context)`: build a system+user prompt
  (strict "use only provided context" instructions), then
  `httpClient->post('https://api.openai.com/v1/chat/completions', ['headers'=>['Authorization'=>
  'Bearer '.$key], 'json'=>[...'model','messages','temperature','max_tokens'], 'timeout'=>30/40])`.
  Uses Drupal's `http_client` (Guzzle) with default TLS verification; endpoint is hard-coded.
- Response content is read from `choices[0].message.content`; token usage is logged.
- `buildContextText()` formats each doc as `Title: [title](url)` markdown + `Content: ...`.
- `normalizeUtf8String()` / `normalizeContextArray()` coerce inputs to valid UTF-8.
- `testConnection()` sends a 20-token "Say API connection successful" ping (used by `TestConnectionForm`).

## `Service\MarkdownProcessor::convertToHtml()`
Minimal, hand-rolled markdown → HTML. It `Html::escape()`s the whole string first, then
re-introduces a fixed set of tags: `###/##` headings, `[text](url)` links (URL passed through
`UrlHelper::stripDangerousProtocols` + `isValid`, label `htmlspecialchars`'d), `**bold**`,
`*italic*`, `-`/`1.` lists, `</p><p>` paragraphs, `nl2br`. There is a unit test at
`tests/src/Unit/MarkdownProcessorTest.php`.

## `Service\AnalyticsLogger`
Parameterized query-builder + one `db->query()` with a bound `:start_time` placeholder. Aggregates
by the unique `query` column, prunes to `analytics_max_records`. Self-heals the table via
`ensureAnalyticsTable()`.

## Summary path
`AISearchController::summary()` (`/airagsearch/summary`, GET) reuses the session `airagsearch_query`,
retrieves up to `summary_results_count` docs, calls `askChatGPTSummary()`, renders the markdown via
`MarkdownProcessor::convertToHtml()` into a render array (`#markup`).
