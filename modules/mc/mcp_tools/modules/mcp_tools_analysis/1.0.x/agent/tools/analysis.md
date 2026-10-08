<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analysis tools

Plugins in `src/Plugin/tool/Tool/`. All are operation **Read**, `MCP_CATEGORY = 'analysis'` ->
permission **`mcp_tools use analysis`**, read scope. Each delegates to a specialized analyzer
service (or the `AnalysisService` facade). None write.

| Tool id | Class -> service | Inputs | Inspects |
|---|---|---|---|
| `mcp_analysis_broken_links` | `FindBrokenLinks` -> `LinkAnalyzer` | `limit` (int), `base_url` (string) | Extracts `href`s from text fields of published nodes and HEAD-checks internal links. |
| `mcp_analysis_seo` | `AnalyzeSeo` -> `SeoAnalyzer` | `entity_type` (string, required), `entity_id` (int, required) | Meta tags, headings, alt text, content quality of one entity. |
| `mcp_analysis_security` | `SecurityAudit` -> `SecurityAuditor` | — | Reviews config (e.g. `user.settings` register mode), permissions, and role grants. |
| `mcp_analysis_performance` | `AnalyzePerformance` -> `PerformanceAnalyzer` | — | Cache settings, watchdog errors, DB table-size query. |
| `mcp_analysis_accessibility` | `CheckAccessibility` -> `AccessibilityAnalyzer` | `entity_type` (string, required), `entity_id` (int, required) | Images without alt, heading order, link-text quality. |
| `mcp_analysis_content_audit` | `ContentAudit` -> `ContentAuditor` | `stale_days` (int), `include_drafts` (bool), `content_types` (list) | Stale / orphaned / draft content. |
| `mcp_analysis_duplicates` | `FindDuplicateContent` -> `DuplicateDetector` | `content_type` (string, required), `field` (string), `threshold` (float) | Similar content by field values. |
| `mcp_analysis_unused_fields` | `FindUnusedFields` -> `FieldAnalyzer` | — | Fields with no data across all entities. |

## Outbound link fetching

`LinkAnalyzer::findBrokenLinks()` fetches nothing unless `mcp_tools.settings` `allowed_hosts`
is non-empty (otherwise it returns `URL_FETCH_DISABLED`). It validates the resolved base host
and each target host against that allowlist, only checks internal links, sets a 5s timeout, and
installs an `on_redirect` guard that rejects redirects to any host outside the allowlist.

## Notes

- All tools are read-only and honor the connection's read scope + `mcp_tools use analysis`.
- Analyzers read entity, config, and DB metadata only; they do not read arbitrary server files.
