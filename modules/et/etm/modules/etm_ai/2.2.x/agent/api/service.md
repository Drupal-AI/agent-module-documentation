<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EtmAiService & AiController

## Service `etm_ai.service` (`Service\EtmAiService`)

Constructor args (`etm_ai.services.yml`): `ai.provider` (`AiProviderPluginManager`),
`entity_type.manager`, `database`, `logger.factory`, `cache.default`, `config.factory`,
`http_client`, `state`, `extension.list.module`.

`isAvailable()` → `aiProvider->hasProvidersForOperationType('chat', TRUE)`. All operations build a
prompt with `getExpertPreamble()` (varies by `power_level`) plus vocabulary context
(`getTaxonomySummary`, `getAllTermNamesWithTids`, `getAncestorPath`, `getChildTermNames`).

Public operation methods (each returns a parsed-JSON array):

- `generateChildren($vid, $parentTid, $count=15)`
- `suggestParent($vid, $termName)`
- `findSemanticDuplicates($vid)` — batches 500 terms/request.
- `generateDescriptions($vid, $tids, $overwrite=FALSE)`
- `healthCheck($vid)` — AI audit (distinct from the parent's rule-based `TreeController::healthCheck`).
- `semanticSearch($vid, $query)`
- `restructure($vid, $prompt, $referenceStructure=NULL)` — returns `operations` + `summary`.
- `listTemplates()` / `loadTemplateStructure($id)` / `mapToTemplate($vid, $templateId)` — templates
  from `templates/*.yml`; `loadTemplateStructure` sanitises the id to `[A-Za-z0-9_-]`.
- `chatCommand($vid, $message, $history=[])` — history capped at last 6; returns `answer` or
  `action` (+ operations).
- `extractFromText($vid, $text, $sourceType)` / `fetchUrlContent($url)`.
- `deepAnalysis($vid)` — four sequential passes (structure, naming, completeness, synthesis).
- `autoTag($vid, $content, $maxTags=10)`, `mapRelationships($vid)`.

Internal AI plumbing:

- `chatRaw($prompt, $vid)` / `chat($prompt, $cacheKey, $vid)` — resolve provider/model from
  `etm_ai.settings` (`ai_provider`/`ai_model`) or the AI module default; `configureProvider()`
  applies the `temperature`; set a taxonomy-expert system role; call `$provider->chat()`. `chat()`
  additionally caches (`cache.default`, 1h, tag `etm_ai`) keyed by cache key + SHA-256 of the prompt.
- `assertWithinDailyLimit($vid)` — per-vocabulary counter in `state` keyed by UTC day; enforces
  `daily_request_limit` (0 = unlimited); only counts calls that reach the provider (cache hits are
  free).
- `parseJsonResponse()` / `repairTruncatedJson()` — strip markdown fences, extract the outermost
  `{…}`, and close unbalanced braces/brackets when a reply is truncated at the token limit.

### URL fetch (`fetchUrlContent`)

Used only by `extractTaxonomy`. Validates the URL, restricts to http/https, and calls
`assertPublicUrl()` — which resolves the host (A/AAAA) and rejects any private/reserved/loopback
address, re-checking on every redirect (`on_redirect`, max 3, strict). The response is tag-stripped
and size-capped before being sent to the model.

## Controller `etm_ai.controller` (`Controller\AiController`)

Args: `etm_ai.service`, `csrf_token`, `logger.factory`, `current_user`. Each handler validates the
`X-CSRF-Token` header against the `taxonomy_manager` token (`validateCsrfToken`), returns 503 if no
AI provider is available, sanitises input (tid/count caps, history role whitelist), and returns
`{status, …}` JSON. Errors are logged and returned as a generic message.

## Routes (`etm_ai.routing.yml`)

All under `/admin/structure/taxonomy/manage/{taxonomy_vocabulary}/ai/…` unless noted; all
`_admin_route`. Requirements combine a permission with `_etm_access: 'TRUE'`.

| Route | Path suffix (method) | Permission |
|---|---|---|
| `etm_ai.settings` | `/admin/config/content/etm-ai` (form) | `administer taxonomy` |
| `.generate_children` | `/ai/generate-children` (POST) | `use etm ai features` |
| `.suggest_parent` | `/ai/suggest-parent` (POST) | `use etm ai features` |
| `.semantic_duplicates` | `/ai/semantic-duplicates` (POST) | `use etm ai features` |
| `.generate_descriptions` | `/ai/generate-descriptions` (POST) | `use etm ai features` |
| `.health_check` | `/ai/health-check` (POST) | `use etm ai features` |
| `.restructure` | `/ai/restructure` (POST) | `use etm ai features` |
| `.templates` | `/admin/structure/taxonomy/ai/templates` (GET) | `use etm ai features` (no `_etm_access`) |
| `.map_template` | `/ai/map-template` (POST) | `use etm ai features` |
| `.chat` | `/ai/chat` (POST) | `use etm ai features` |
| `.extract` | `/ai/extract` (POST) | `use etm ai features` |
| `.search` | `/ai/search` (GET) | `use etm ai features` |
| `.deep_analysis` | `/ai/deep-analysis` (POST) | `use etm ai advanced features` |
| `.auto_tag` | `/ai/auto-tag` (POST) | `use etm ai advanced features` |
| `.relationships` | `/ai/relationships` (POST) | `use etm ai advanced features` |
