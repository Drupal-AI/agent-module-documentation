<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI AutoEvals (ai_autoevals) — agent index

**Automated two-step LLM factuality evaluation of AI responses.** Extract expected criteria from the
user input, then grade the AI response against them and store a 0–1 score. Package `AI`. Depends on
**`ai`** and **`key`**. Core `^10.2 || ^11`. GPL-2.0-or-later. Version 1.0.0-alpha2 (project marks
itself *not production ready*). All LLM calls go through the `ai` provider abstraction.

Solution docs:
- **Settings, evaluation-set config entity + builder, permissions, cron** →
  [config/settings.md](config/settings.md)
- **Runtime pipeline: event subscriber → queue → FactExtractor plugins → Evaluator** →
  [api/evaluation-pipeline.md](api/evaluation-pipeline.md)
- **Dashboard, results list, detail/requeue/re-evaluate/batch routes** →
  [api/dashboard-and-results.md](api/dashboard-and-results.md)

## What it provides (from source)

- **Content entity** `ai_autoevals_evaluation_result` (`Entity\EvaluationResult`, base table
  `ai_autoevals_evaluation_result`) — one graded evaluation (input, output, facts, status, score,
  choice, analysis, tags, metadata, re_evaluation_of, …). Access handler
  `EvaluationResultAccessControlHandler` maps view/update/delete to the module's permissions.
- **Config entity** `ai_autoevals_evaluation_set` (`Entity\EvaluationSet`, prefix
  `ai_autoevals.evaluation_set`) — per-scenario evaluation config; fluent
  `EvaluationSet::builder($id, $label)` → `EvaluationSetBuilder`.
- **Config object** `ai_autoevals.settings` (provider/model, operation_types, auto_track,
  fact_extraction_method, context_depth, retention_period, debug_mode, global exclusions).
- **Plugin type `FactExtractor`** (`@FactExtractor` annotation, `PluginManager\FactExtractorManager`,
  dir `Plugin/FactExtractor`): `ai` (LLM), `keyword` (rule-based), `hybrid`. Interface method
  `extract(string $input, array $context, ?EvaluationSetInterface): array`.
- **Queue worker** `ai_autoevals_evaluation_worker` (`Plugin\QueueWorker\EvaluationWorker`,
  `cron time = 60`).
- **Services**: `ai_autoevals.config`, `.evaluation_manager`, `.fact_extractor`, `.evaluator`,
  `.conversation_tracker`, `.batch_processor`, `.keyword_matcher`, `.event_subscriber`, plus cache
  bin `cache.ai_autoevals_facts`.
- **Events**: `ai_autoevals.pre_evaluation`, `.post_evaluation`, `.evaluation_failed`
  (`src/Event/*`). Alter hook `hook_ai_autoevals_evaluation_sets_alter()` (see `ai_autoevals.api.php`).
- **Hooks** (`ai_autoevals.module`): `hook_help`, `hook_theme` (3 themes), `hook_cron` (retention
  purge), `hook_form_alter` (placeholder).

## Routes (all permission-gated; see routing.yml)

`ai_autoevals.settings_form` (`/admin/config/ai/autoevals`, `administer ai autoevals`);
`ai_autoevals.dashboard` + `.results` + `.result_view` (`/admin/content/ai-autoevals[...]`,
`view ai autoevals results`); evaluation-set list/add/edit/delete (`view`/`manage ai autoevals
sets`); `.result_requeue` (`requeue ai autoevals`); `.result_reevaluate` (`edit ai autoevals
results`); `.result_delete` (`delete ai autoevals results`); `.batch` (`batch ai autoevals`).

## Two-step flow

`AiAutoevalsSubscriber` (on `ai` Pre/Post generate events, tag `ai_autoevals:track` or auto_track,
skips tag `ai_autoevals:internal`) → `EvaluationManager::createEvaluation()` + `queueEvaluation()`
→ `EvaluationWorker` → `FactExtractor` (criteria from input) → `Evaluator::evaluate()` (factuality
prompt → provider `chat()` → parse choice A–E → `calculateScore()`).
