<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ai_empathy — services, scoring pipeline & events

All services are declared in `ai_empathy.services.yml`.

## Services (`src/Service/`)

- **`ai_empathy.evaluator`** → `EmpathyEvaluator` — sends a scenario to the evaluation provider
  (`@ai.provider`), builds the prompt (dispatching `PROMPT_ALTER`), then scores the response via
  `ai_empathy.scoring` and persists an `ai_empathy_result`. Args: ai.provider, entity_type.manager,
  scoring, config.factory, event_dispatcher.
- **`ai_empathy.scoring`** → `EmpathyScoringService` — the grading core, reused by the field action,
  guardrail, and submodule scorers. Two entry points:
  - `scoreResponse($text, $scenario)` — grades against a scenario on **decision_accuracy (0–100)**,
    **empathy_alignment (1–5)**, **explanation_quality (1–5)**; dispatches `SCORE_ALTER` so submodules
    can add metrics; tags the AI call `['ai_empathy','ai_empathy_scoring','ai_empathy_scenario:<id>']`.
  - `scoreResponseGeneral($text)` — scenario-less; returns empathy_alignment + explanation_quality only.
  - `computeConsistencyIndex($results)` — 100 − mean coefficient-of-variation across runs.
  - Both build a `ChatInput` with a rubric system prompt, call `$provider->chat()`, and parse the reply
    with `parseScores()`/`parseGeneralScores()`: a `preg_match('/\{[^}]+\}/')` JSON extract, then
    `json_decode`, then each metric **clamped** to its range with a safe default on malformed output.
    Throws `RuntimeException` if `scoring_provider_model` is unset.
- **`ai_empathy.benchmark`** → `BenchmarkService` — aggregates results by `benchmark_id`, builds
  rankings/trends and the CSV (`buildCsv()`). Args: entity_type.manager, uuid.
- **`ai_empathy.scenario_generator`** → `ScenarioGeneratorService` — AI-assisted scenario authoring.
- **`ai_empathy.training`** → `EmpathyTrainingService`, **`ai_empathy.reliability`** →
  `EmpathyReliabilityService` (Cohen's/Fleiss' kappa, human-vs-AI divergence — `@database` reads bind
  values), **`ai_empathy.calibration`** → `EmpathyCalibrationService` (difficulty calibration),
  **`ai_empathy.scheduled_evaluator`** → `EmpathyScheduledEvaluator` (see config/settings.md).
- `logger.channel.ai_empathy`; hook handler service `AiEmpathyHooks` (autowired).

## Events (`src/Event/AiEmpathyEvents.php`)

- **`ai_empathy.prompt_alter`** (`EvaluationPromptAlterEvent`) — fired while building the user message
  sent to the evaluated model; subscribers append context (e.g. brand voice from `ai_empathy_ccc`).
- **`ai_empathy.score_alter`** (`ResponseScoreAlterEvent`) — fired after scoring, before persistence;
  `setScore($key, $value)` adds/overrides a metric. Any score key matching a base field on
  `ai_empathy_result` is persisted automatically. Used by governance (accountability/trust), ccc
  (tone_alignment), healthcare and hr subscribers.

## AI abstraction

Every provider call goes through the `ai` module (`AiProviderPluginManager`,
`loadProviderFromSimpleOption()` / `getModelNameFromSimpleOption()`, `ChatInput`/`ChatMessage`,
`$provider->chat($input, $model_id, $tags)`). No direct HTTP client, no TLS options, no credential
handling in this project — API keys stay in the `ai` provider config.
