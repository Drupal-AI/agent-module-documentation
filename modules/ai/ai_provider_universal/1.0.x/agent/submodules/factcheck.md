<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodule: Fact Check (ai_provider_universal_factcheck)

Source: `web/modules/contrib/ai_provider_universal/modules/ai_provider_universal_factcheck/`. Human name
"AI Provider: Universal — Fact Check". Depends on `ai_provider_universal`,
`ai_provider_universal_router` and core `node`. Package AI Providers. Version 1.0.0-beta3. Configure
route `ai_provider_universal_factcheck.settings`.

## What it does

Verifies content claim by claim and grades it. The `FactChecker` pipeline extracts atomic claims from a
text with an LLM, retrieves evidence (a local `ai_search` index first, then web search), issues a
SUPPORTED / UNSUPPORTED / CONTRADICTED verdict per claim (batched or per-claim), checks claims against a
curated distrusted-source list, and returns a support score. Alongside it runs readability (pure-PHP
Flesch), an LLM AI-likelihood heuristic, and verbatim plagiarism search. Scans run on demand (a node
tab, or a standalone page/block over pasted text or a public URL) or on a schedule via scan profiles.

## Entities

- **`FactcheckResult`** — content entity, id `aip_factcheck_result`, base table `aip_factcheck_result`,
  `admin_permission: 'view factcheck results'`. Fields: `subject`, `url`, `node` (ref), `score`,
  `ai_score`, `readability`, `plagiarism_matches`, `details` (map), `uid`, `created`. Surfaced through
  the shipped `factcheck_results` view (page `admin/content/factcheck/results`, access
  `view factcheck results`).
- **`ScanProfile`** — config entity, id `aip_scan_profile`, config_prefix `scan_profile`,
  `admin_permission: 'administer factcheck settings'`. Keys: `bundles[]`, `operations`
  (default insert/update), `published_only` (TRUE), `cooldown` (3600s), `checks{}`, `event_on`
  (threshold). Admin UI under `/admin/config/ai/factcheck/scan-profiles`. `appliesTo()` is the cheap
  request-path filter.

## Settings — `ai_provider_universal_factcheck.settings`

`profile` (fast|balanced|thorough), `checker_model`, `extractor_model`, `evidence_index` (ai_search
index id), `max_claims` (5), `detector_model`, `plagiarism_key`, `tavily_key`, `mbfc_key` (all **Key
entity ids**), `notify_email`, `scan_flood_limits` (role→int), `scan_flood_window` (3600s), and
`prompts` overrides (extract/verify/batch_verify/taint/analyze/detect). Config form `SettingsForm`.

## Routes & permissions

| Route | Path | Handler | Access |
|---|---|---|---|
| `.settings` | `/admin/config/ai/factcheck` | `SettingsForm` | `administer factcheck settings` OR `administer ai providers` |
| `.standalone` | `/admin/content/factcheck` | `StandaloneFactCheckForm` | `use standalone fact check` |
| `.content_scan` | `/node/{node}/factcheck` | `ContentScanForm` | `_entity_access: node.view` AND (`run content scan` OR `administer nodes` OR `administer ai providers`) |

Permissions (`.permissions.yml`): `administer factcheck settings` (restrict access), `view factcheck
results`, `use standalone fact check`, `run content scan`. `hook_install` grants `run content scan` to
the `administrator` role. Model-based checks spend LLM/API budget — grant the scan permissions
accordingly and note the per-role scan flood limits.

## Services

`FactChecker` (alias `ai_provider_universal_factcheck.checker`; claim extraction → evidence → verdict →
taint → score), `EvidenceRetriever` (local ai_search index, then Tavily web search honoring
trusted/distrusted domains), `PlagiarismChecker` (Serper.dev exact-phrase search), `AiDetector` (LLM
AI-likelihood 0–100), `ReadabilityScorer` (Flesch), `ScanRunner` (worker: runs checks cheapest-first,
persists a result row, fires `ContentReviewEvent`), `ScanScheduler` (on node save: cheap filters +
cooldown, enqueues), `TrustedSiteRepository` (reads `trusted_site` nodes), `BiasRatingImporter`
(imports MBFC ratings into `trusted_site` nodes), `AdminNotifier` (fires
`FactcheckNotificationEvent`, optional mail).

## Other components

- **Drush** `factcheck:sync-bias-ratings` (`fcsyncbias`) — `--file` (local JSON, bundled sample default)
  / `--fetch=domains` (live MBFC API) / `--update`.
- **QueueWorker** `aip_content_review` (cron) — re-validates and runs `ScanRunner::run`.
- **Block** `ai_provider_universal_factcheck_standalone` — renders the standalone form; block access
  `use standalone fact check`.
- **Events** `ContentReviewEvent` (scheduled-scan signal for ECA/Workflow), `FactcheckNotificationEvent`.
- **Hooks** `hook_mail`, `hook_node_insert`, `hook_node_update` (→ `ScanScheduler`).
- **Data** `data/mbfc-ratings-full.json` (~2.8 MB, ~8.7k domains) and a small sample; a `trusted_site`
  content type + example seeds come from the parent project's `factcheck_trusted_sites*` recipes.

## Flow

Manual: node tab or standalone page → collect text (node fields, or fetch a URL / pasted text) → flood
check → Batch API extracts claims, verifies in chunks (evidence index → Tavily, LLM verdicts), scores
readability, AI-likelihood, plagiarism → results shown in a table and stored as an
`aip_factcheck_result` row. Scheduled: node save → `ScanScheduler` enqueues → cron `ScanRunner` runs the
profile's checks, persists a row and dispatches `ContentReviewEvent` (never mutates the node).
