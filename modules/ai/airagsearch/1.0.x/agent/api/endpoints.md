<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# airagsearch — JSON REST endpoints

Provided by `Controller\AISearchApiController` (routes in `airagsearch.routing.yml`). All are GET.

## `GET /api/airagsearch/status` — `apiStatus()`
Access: `_permission: 'access ai search api'`. Returns `{status, version, configured:{search_index,
openai_api}, endpoints}` where `configured` is booleans only (does not expose the key value).

## `GET /api/airagsearch/results` — `searchResults()`
Access: `_custom_access: '\Drupal\airagsearch\Controller\AISearchApiController::access'`, which
returns `AccessResult::allowedIfHasPermission($account, 'access ai search api')`.
Params: `q` (required, min 3 chars), `page` (default 0), `limit` (1–50, else forced to 10).
Loads `search_api_index` from config, runs `$index->query()` with lowercased whitespace-split keys,
sorts by `search_api_relevance`, and returns `{status, query, page, limit, total_results,
results:[{id,title,snippet,url,score}]}`. `url` comes from an indexed `url` field passed through
`UrlHelper::stripDangerousProtocols()` + `UrlHelper::isValid(..., TRUE)`; snippet from
`getExcerpt()` or a `strip_tags`'d 200-char body slice.

## `GET /api/airagsearch/summary` — `searchSummary()`
Access: same `::access` custom check (`access ai search api`).
Params: `q` (required, min 3), `context_limit` (1–20, else forced to 5).
Requires both `search_api_index` and `openai_api_key` set. Builds up to `context_limit` docs
(`title` + `strip_tags`'d body, capped 1200 chars), calls
`OpenAIClient::askChatGPTSummary($q, $docs)`, and returns the summary as `strip_tags`'d plain text
in `{status, query, summary, context_count, total_results}`.

## Notes for callers
- Query keys are the search terms only; no field/filter syntax is exposed.
- Results reflect whatever the configured Search API index returns for the query.
- Errors return `{error, status:'error'}` with 400/503/500 codes; the OpenAI-driven summary
  endpoint consumes paid API tokens per call.
