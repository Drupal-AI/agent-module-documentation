<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ai_empathy — entities, routes & permissions

## Entities (`src/Entity/`)

- **`ai_empathy_scenario`** — `@ConfigEntityType` (`AiEmpathyScenario.php`). The dilemma definition:
  `label`, `description`, `category` (see `ScenarioCategory` enum), `reference_decision`,
  `difficulty` (1–5, `DifficultyLevel` enum), `context_details`, `weight`. 19 defaults ship in
  `config/install/ai_empathy.ai_empathy_scenario.*.yml` (military/medical/emotion/cultural). Managed via
  the scenario list/add/edit/delete routes and the AI generate form. Schema: `ai_empathy.ai_empathy_scenario.*`.
- **`ai_empathy_result`** — `@ContentEntityType` (`AiEmpathyResult.php`). One scored evaluation: scenario
  id, run number, provider, model, the AI response text, and metric fields `decision_accuracy`,
  `empathy_alignment`, `explanation_quality`, `consistency_index`, plus system-cost fields
  (latency_ms, output_tokens, tokens_per_sec, peak_rss_mb, energy_j) and `benchmark_id`. Submodules add
  base fields to this entity (`tone_alignment`, `accountability`, `trust`, healthcare metrics) via
  `hook_entity_base_field_info`.
- **`ai_empathy_session`** — `@ContentEntityType` (`AiEmpathySession.php`). A training-mode session.
- **`ai_empathy_rating`** — `@ContentEntityType` (`AiEmpathyRating.php`). A human rating on a result
  (empathy/quality scores, notes, uid, result_id).
- **`ai_empathy_comparison`** — `@ContentEntityType` (`AiEmpathyComparison.php`). A blind A/B comparison
  record (result_a, result_b, uid); installed by `ai_empathy_update_10001`.

## Permissions (`ai_empathy.permissions.yml`)

- `administer ai empathy` — **restricted**; settings, scenario CRUD, AI generate.
- `run ai empathy evaluation` — run evaluations, training, launch benchmarks.
- `view ai empathy results` — dashboard, results, sessions, analysis, calibration, benchmark results/export.
- `rate ai empathy results` — human rating, blind comparison.

## Routes (`ai_empathy.routing.yml`, all under `/admin/config/ai/empathy`)

| Route | Path suffix | Perm |
|---|---|---|
| `ai_empathy.dashboard` | `` (base) | view |
| `ai_empathy.settings_form` | `/settings` | administer |
| `entity.ai_empathy_scenario.collection` / `.add_form` / `.edit_form` / `.delete_form` | `/scenarios…` | administer |
| `ai_empathy.scenario_generate` | `/scenarios/generate` | administer |
| `ai_empathy.run_evaluation` | `/evaluate` | run |
| `entity.ai_empathy_result.collection` / `.canonical` | `/results`, `/results/{id}` | view |
| `ai_empathy.rate_result` | `/results/{id}/rate` | rate |
| `ai_empathy.training` | `/training` | run |
| `entity.ai_empathy_session.collection` | `/sessions` | view |
| `ai_empathy.rating_analysis` | `/analysis` | view |
| `ai_empathy.calibration` | `/calibration` | view |
| `ai_empathy.blind_comparison` | `/compare` | rate |
| `ai_empathy.benchmark` | `/benchmark` | run |
| `ai_empathy.benchmark.results` / `.export` | `/benchmark/{id}[/export]` | view |

Every route carries a real `_permission`; there is no `_access: TRUE` or `access content` route and no
anonymous endpoint. Controllers escape all model/scenario/user text via `Html::escape()` + `nl2br`
(`AiEmpathyResultViewController::view()`); dashboard/benchmark/calibration DB reads bind values and use
hardcoded column names (no dynamic SQL). CSV export (`AiEmpathyBenchmarkController::exportCsv()`) streams
`BenchmarkService::buildCsv()` over admin-controlled provider names + numeric scores.
