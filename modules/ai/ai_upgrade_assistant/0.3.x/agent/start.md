<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Upgrade Assistant (ai_upgrade_assistant) — agent index

**Experimental** developer tool that pairs the **Upgrade Status** deprecation scanner with the
**OpenAI Chat Completions API** to review Drupal module source and suggest upgrade/deprecation
fixes. Package `Development`. Core `^9 || ^10 || ^11`. PHP `>=8.1`. License GPL-2.0-or-later.
Version 0.3.0. Depends on modules `system`, `update`, and `upgrade_status`.

The project page self-describes as highly experimental ("USE AT YOUR OWN RISK"). In 0.3.0 much of
the code is **incomplete or not wired to routes** — several controller/service methods call
methods that do not exist, and patch/apply/update/dashboard paths are unrouted (see notes below).

- **Settings form, config keys, permissions** → [config/settings.md](config/settings.md)
- **Routes, controllers, services, and what actually runs** → [services/services.md](services/services.md)

## What it provides

- **Routes** (`ai_upgrade_assistant.routing.yml`), all under `/admin/reports/upgrade-assistant`
  except settings; all gated by permission **`access upgrade status`** (from upgrade_status)
  except settings which uses **`administer site configuration`**:
  `upgrade` (UpgradeController::overview), `check_status`, `start_analysis`, `analyze_module/{module}`,
  `module_details/{module}`, `module_patches/{module}`, `generate_report`, and
  `settings` (SettingsForm at `/admin/config/development/ai-upgrade-assistant`).
- **Permissions** (`ai_upgrade_assistant.permissions.yml`): `access upgrade assistant` and
  `administer upgrade assistant` (both `restrict access: true`) — **defined but not referenced by
  routing.yml**, which instead uses `access upgrade status`.
- **Services** (`ai_upgrade_assistant.services.yml`): `project_analyzer` (ProjectAnalyzer),
  `openai` (OpenAIService), `batch_analyzer` (BatchAnalyzer), `analysis_tracker` (AnalysisTracker),
  `patch_generator` (PatchGenerator), `report_generator` (ReportGenerator). A second file
  `ai_automatic_update.services.yml` (not the module's `.services.yml`, so **not loaded** by Drupal)
  also lists a `rollback_manager` (RollbackManager) and swaps OpenAIService's arg order.
- **Controllers**: Upgrade, Analysis, Patch, Report, Update, Dashboard (`src/Controller/`).
  **Forms**: SettingsForm, ApplyUpdatesForm (`src/Form/`).
- **Theme hooks** (`.module`): `upgrade_dashboard`, `upgrade_recommendations`. **Libraries**:
  `dashboard`, `diff_view`, `upgrade_assistant`.
- **Config object** `ai_upgrade_assistant.settings` (no `config/install` or `config/schema` ships).

## How it works (from source)

- `OpenAIService::analyzeCode()` builds a chat prompt and POSTs to the hardcoded
  `https://api.openai.com/v1/chat/completions` via `@http_client` (Guzzle, default TLS on) with
  `Authorization: Bearer <openai_api_key>`; retries on HTTP 429 with backoff.
- `ProjectAnalyzer` enumerates modules via `module_handler`, resolves each module's directory with
  `getModule($name)->getPath()`, recursively finds `*.php/*.module/*.inc/*.install`, reads each
  file and hands its contents to `OpenAIService::analyzeCode()`. All scanned paths derive from the
  installed extension list, never a raw request path.
- `PatchGenerator` can write AI-suggested `code_example` into files and shell out to `diff`/`patch`
  (Symfony Process); `RollbackManager` backs up/restores files. **None of these are reached by a
  registered route in 0.3.0.**

## Caveats (0.3.0 is partly broken)

- `AnalysisController::startAnalysis()`/`analyzeModule()` call `batchAnalyzer->createAnalysisBatch()`
  / `createModuleAnalysisBatch()`, which **do not exist** on `BatchAnalyzer` → fatal if invoked.
- `BatchAnalyzer` calls `projectAnalyzer->getModuleFiles()/analyzeFile()/getCustomModules()/getContribModules()`
  — also **absent** from `ProjectAnalyzer`.
- `AnalysisController` uses `Url` without importing it; `ReportController` links to routes
  (`ai_upgrade_assistant.analyze`, `export_report`) and `PatchController`/`UpdateController` link to
  routes (`apply_patch`, `generate_patch`, `view_patch`, `download_patch`, `apply_updates`) that are
  **not defined** in routing.yml → `RouteNotFoundException` when those links render.
- `ApplyUpdatesForm::processUpdate()` and `createBackup()` are stubs ("not yet implemented").
- Practically working, reachable surface: the **settings form**, the static **upgrade overview**
  page, and **check_status** (reads state). Treat everything else as prototype.
