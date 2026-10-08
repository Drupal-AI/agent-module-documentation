<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Eval (ai_eval) — agent index

An **evaluation framework for AI agents and providers**. Define datasets (YAML / config / content
entities / browser), point an **eval target** at an ai_agents plugin (agent mode) or any AI
provider (chat mode), run it, and get scored results with pass/fail quality gates. Ships pluggable
**graders** (deterministic + LLM-judge), production-**trace review**, judge validation against
human labels, and **prompt optimization**. htmx-driven admin UI + Drush. Package *AI*.
Core `^11.3`, PHP `8.3`. License GPL-2.0-or-later. Version 1.0.0-beta3.

- **Install, settings, permissions, routes, entities, Drush** →
  [config/settings.md](config/settings.md)
- **Plugin types (graders, dataset sources), check executors, scoring, events** →
  [plugins/extending.md](plugins/extending.md)
- **Submodule** `ai_eval_droost` (deterministic grader over built Drupal state) is documented in
  its own nested tree at `../../modules/ai_eval_droost/1.0.x/` (relative to the `ai_eval` project
  bucket: `modules/ai/ai_eval/modules/ai_eval_droost/1.0.x/`).

## Dependencies

- `ai:ai` (drupal/ai) — provider abstraction (`ai.provider`); all model calls and credentials
  live here. `drupal:options`, `drupal:file`. Composer also requires `opis/json-schema ^2.3`
  (validates the dataset/rubric/judge YAML against `schema/*.schema.json`).

## Entities

- **Content**: `ai_eval_annotation`, `ai_eval_dataset`, `ai_eval_question`, `ai_eval_rubric`,
  `ai_eval_review_label` (`src/Entity/`).
- **Config**: `ai_eval_target` (`ai_eval.target.*`), `ai_eval_judge_config`
  (`ai_eval.judge_config.*`), `ai_eval_failure_mode` (`ai_eval.failure_mode.*`).
- **Custom DB tables** (not entities, `ai_eval.install`): `ai_eval_result`,
  `ai_eval_optimization`, `ai_eval_run`, `ai_eval_generation`.

## Plugin types it defines

- **AiEvalGrader** — `#[AiEvalGrader]` attribute, `GraderInterface`; manager
  `ai_eval.grader_manager`. Nine shipped graders in `src/Plugin/AiEvalGrader/` (LLM judges:
  relevance/completeness/actionability/accuracy/fact_match/groundedness; deterministic:
  format/tool_usage/rubric_checks).
- **AiEvalDatasetSource** — `#[AiEvalDatasetSource]` attribute, `DatasetSourceInterface`; manager
  `ai_eval.dataset_source_manager`. Shipped: `config`, `entity`, `file` sources.
- **Check executors** — tagged services (`ai_eval.check_executor`) implementing
  `CheckExecutorInterface`, dispatched by `Service\RubricCheckEvaluator`. Shipped:
  `StringCheckExecutor`, `TargetMatchExecutor`. (The schema also defines `command`/`score_delta`
  kinds, but **no executor for them ships in this version** — unclaimed checks are non-executable
  and excluded from scoring.)

## Routes & permissions

All routes live under `/admin/config/ai/ai-eval/**` and require one of four permissions
(`ai_eval.permissions.yml`): `operate ai eval`, `administer ai eval`, `annotate ai eval results`,
`validate ai eval judges`. Every mutation route is POST-guarded by `_csrf_request_header_token`
(apply/reject use `_csrf_token`); no route is public. See [config/settings.md](config/settings.md)
for the route table.

## Drush (`drush.services.yml`, `src/Command/`)

`ai-eval:run` (aer), `:optimize` (aeo), `:validate-judge` (aevj), `:judges` (aej),
`:distill` (aed), `:sample-traces` (aest), `:import-traces` (aeit), `:import-envelope` (aeie),
`:export-envelope` (aee), `:target-fixtures` (aetf).

## Key services

`ai_eval.eval_runner` (`Service\EvalRunner`) runs a target and finalizes results (dispatching
`EvalRunCompleteEvent`); `ai_eval.scorer` (`Service\Scorer`) combines grader scores via
`ScoreScale` onto the composite 0-5 scale; `ai_eval.generation_runner`, `ai_eval.trace_importer`,
`ai_eval.judge_validator`, `ai_eval.promotion_service`, `ai_eval.result_envelope`, and a large
statistics layer (confidence intervals, corrected pass rate, agreement, sample size).

## Mechanism (from source)

- A run resolves the target's dataset (via a dataset-source plugin), executes each question against
  the agent/provider, grades each response with the target's graders, and stores an
  `ai_eval_result` row; the UI streams progress from `ai_eval_run`/`ai_eval_generation`.
- LLM judges call the configured `judge_provider`/`judge_model` through `drupal/ai`; deterministic
  graders and check executors run locally with no API cost.
- The results/trace UI renders AI/trace text as markdown **client-side** with a strict sanitizer
  (`js/markdown-render.js`: reads `textContent`, converts, then allow-lists tags/attrs before the
  single `innerHTML` write) — see the htmx interaction contract in `docs/adr/0001`.
