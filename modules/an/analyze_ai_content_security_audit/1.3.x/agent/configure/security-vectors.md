<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure content security audit vectors

## Prerequisites
1. Configure a chat AI provider/model at `/admin/config/ai/providers` (analyzer uses the default chat provider, temperature 0.2).
2. Enable the analyzer per content type at `/admin/config/content/analyze-settings` (writes `analyze.settings:status.<entity_type>.<bundle>.analyze_ai_content_security_audit_analyzer`; per-vector toggles live in `analyze.plugin_settings`).

## Manage vectors
All under `/admin/config/analyze/content-security-audit`, permission **`administer analyze settings`**:
- **Settings/list** — `SecurityVectorSettingsForm`.
- **Add vector** — `AddVectorForm` (route `…vector.add`): id, label, description, weight.
- **Delete vector** — `DeleteVectorForm` (route `…vector.{vector_id}.delete`): removes the vector and deletes its rows from `analyze_ai_content_security_audit_results`.

Vectors persist to config `analyze_ai_content_security_audit.settings:vectors`. Defaults seeded on install: `pii_disclosure`, `credentials_disclosure`. Built-in prompt criteria exist only for those two ids; custom ids fall back to a generic "general security risks" instruction.

## How scoring works
`SecurityVectorStorageService` caches one row per (entity_type, entity_id, vector_id, langcode) with a SHA-256 `content_hash` and MD5 `config_hash`. Scores are recomputed only when either hash changes; changing any vector config calls `invalidateConfigCache()` which deletes rows whose `config_hash` differs. Scores are clamped 0–100 and shown as `analyze_gauge` gauges (summary = max score; full report = one gauge per enabled vector).

## Batch / programmatic
- The plugin implements `BatchableAnalyzerInterface`: `processEntity($entity, $force_refresh)` (force deletes then re-scores), `hasResults()`, `countAnalyzedEntities()`.
- Results dashboard: Views view `ai_content_security_audit_results` (color-scaled gauges via `views_color_scales`).
- No Drush commands ship here; the base Analyze module provides `drush analyze:setup-ai` for AI-assistant integration.
