<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, controllers & services

All routes live in `ai_upgrade_assistant.routing.yml`. Every report route requires permission
`access upgrade status`; the settings form requires `administer site configuration`.

## Routes

| Route id | Path | Controller/Form::method |
|----------|------|-------------------------|
| `ai_upgrade_assistant.upgrade` | `/admin/reports/upgrade-assistant` | `UpgradeController::overview` |
| `ai_upgrade_assistant.check_status` | `.../check-status` | `UpgradeController::checkStatus` |
| `ai_upgrade_assistant.start_analysis` | `.../start` | `AnalysisController::startAnalysis` |
| `ai_upgrade_assistant.analyze_module` | `.../analyze/{module}` | `AnalysisController::analyzeModule` |
| `ai_upgrade_assistant.module_details` | `.../module/{module}` | `AnalysisController::moduleDetails` |
| `ai_upgrade_assistant.module_patches` | `.../module/{module}/patches` | `PatchController::modulePatchList` |
| `ai_upgrade_assistant.generate_report` | `.../report` | `ReportController::generateReport` |
| `ai_upgrade_assistant.settings` | `/admin/config/development/ai-upgrade-assistant` | `Form\SettingsForm` |

Routes referenced in code but **not defined** (links to them throw `RouteNotFoundException`):
`ai_upgrade_assistant.analyze`, `.view_patch`, `.apply_patch`, `.download_patch`,
`.generate_patch`, `.export_report`, `.apply_updates`. Unrouted controllers: `DashboardController`,
`UpdateController`; unrouted form: `ApplyUpdatesForm`.

## Controllers (`src/Controller/`)

- **UpgradeController** — `overview()` renders a static list of recommended upgrade commands
  (`ddev composer update …`, `drush updb`, `drush cr`) as copy/confirm buttons (no server-side
  command execution route exists). `checkStatus()` returns state as JSON.
- **AnalysisController** — `startAnalysis()`/`analyzeModule()` try to build batches via
  `BatchAnalyzer` methods that don't exist (`createAnalysisBatch`, `createModuleAnalysisBatch`) →
  fatal if hit. `moduleDetails()` reads state key `ai_upgrade_assistant.module_analysis.<module>`
  (never populated in 0.3.0, so it returns "No analysis data"). Also uses `Url` without importing it.
- **PatchController** — `modulePatchList()` reads state `ai_upgrade_assistant.module_patches.<module>`
  and lists patches; links to undefined patch routes. Does not call `PatchGenerator`.
- **ReportController** — `generateReport()` aggregates `upgrade_status.results` into a table
  (module, error/warning counts, AI-analysis presence); links to the undefined `export_report`
  route. `analyze()`/`processAiAnalysis()` (batch, route `ai_upgrade_assistant.analyze` — undefined)
  read a module's flagged files from Upgrade Status, `getModule($module)->getPath() . '/' . $file`,
  `file_get_contents`, and send the code to `OpenAIService::analyzeCode()`.

## Services (`ai_upgrade_assistant.services.yml`)

- **OpenAIService** (`Service/OpenAIService.php`) — `analyzeCode($code, $context)` reads
  `openai_api_key` from config, validates format, builds a system+user chat prompt, and
  `httpClient->post('https://api.openai.com/v1/chat/completions', ['headers'=>['Authorization'=>'Bearer '.trim($api_key)], 'json'=>$payload])`.
  Model hardcoded `gpt-4`, `temperature 0.2`, `max_tokens 2000`. Retries HTTP 429 with exponential
  backoff (`makeApiCallWithRetry`). `parseAnalysisResponse()` is mostly stubbed (the extract*
  helpers return placeholders). `setTestMode()` returns canned mock results.
- **ProjectAnalyzer** (`Service/ProjectAnalyzer.php`) — `getProjectInfo()` (core version, module
  list, root `composer.json`, upgrade_status presence), `getRecommendations()`,
  `analyzeCustomModule($name, $path)`, `analyzeFileContent()` (→ OpenAI), `findPhpFiles($dir)`
  (recursive iterator honoring `file_patterns`/`exclude_patterns`). Paths come from
  `module_handler->getModule($name)->getPath()`.
- **BatchAnalyzer** (`Service/BatchAnalyzer.php`) — Batch API orchestration
  (`createBatch()`, `batchProcessFiles()`, resume support via state). Calls several
  `ProjectAnalyzer` methods that are absent in this release.
- **AnalysisTracker** — state/config-backed progress tracking. **PatchGenerator** —
  `generatePatch()` writes AI `code_example` into a temp copy and runs `diff`; `applyPatch()` runs
  `patch -p0`; `validatePhpSyntax()` runs `php -l` on a temp file; saves patches under
  `public://ai_upgrade_assistant/patches`. **ReportGenerator** — report building. **RollbackManager**
  (declared only in the non-loaded `ai_automatic_update.services.yml`) — file backup/restore under
  `private://ai_upgrade_assistant/backups`.

## Operating notes

- Set the OpenAI API key at the settings form before any analysis; without a valid `sk-…` key
  `OpenAIService::analyzeCode()` returns NULL.
- Run an Upgrade Status scan first — the report and AI analysis read `upgrade_status.results`.
- Treat 0.3.0 as a prototype: the settings form, the static overview, and `check_status` are the
  dependable pieces; batch analysis, patching, and updating are incomplete.
