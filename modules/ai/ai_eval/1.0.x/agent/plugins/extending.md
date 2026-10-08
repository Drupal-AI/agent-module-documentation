<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Eval — extension points: graders, dataset sources, check executors, scoring

AI Eval invokes only two hooks (both plugin-definition alters, see `ai_eval.api.php`); everything
else is extended by defining a plugin, tagging a service, or subscribing to an event.

## 1. Grader plugins (AiEvalGrader)

- Namespace `Plugin/AiEvalGrader/` in any module; attribute
  `\Drupal\ai_eval\Attribute\AiEvalGrader`; interface `\Drupal\ai_eval\GraderInterface`.
- Extend `\Drupal\ai_eval\GraderBase` (deterministic) or `\Drupal\ai_eval\LlmJudgeBase` (LLM
  judge). Manager `\Drupal\ai_eval\GraderPluginManager` (service `ai_eval.grader_manager`).
- Attribute metadata: `min_score`/`max_score` (the scale the grader answers on), `llm` (calls a
  model?), `sees_tool_calls` (LLM judge shown the agent's tool-call record?), `observes_actions`
  (verdict rests on what the agent *did*, not what it wrote?).
- `\Drupal\ai_eval\ScoreScale` maps a grader's declared scale onto the composite 0-5 scale before
  averaging; stored results carry the scale they were produced on (an altered scale never rewrites
  history).
- Shipped graders (`src/Plugin/AiEvalGrader/`): LLM judges `relevance_grader`,
  `completeness_grader`, `actionability_grader`, `accuracy_grader` (hard-caps must_not_contain hits
  at 1, evasive answers ≤ 2, reads `expected_facts`), `fact_match_grader`, `groundedness_grader`
  (binary 0/1); deterministic `format_grader` (format + char cap), `tool_usage_grader` (scores
  against `expected_tools`, can assert call args and two-tool order, reads the agent's own tool
  record), `rubric_checks` (runs a rubric of deterministic checks).
- `hook_ai_eval_grader_info_alter(&$definitions)` — hide/relabel a grader or correct capability
  metadata.

## 2. Dataset source plugins (AiEvalDatasetSource)

- Namespace `Plugin/AiEvalDatasetSource/`; attribute `Attribute\AiEvalDatasetSource`; interface
  `DatasetSourceInterface` (normally extend `DatasetSourceBase`). Manager
  `DatasetSourcePluginManager` (service `ai_eval.dataset_source_manager`).
- Optional capability interfaces: `WritableDatasetSourceInterface` (stores that accept writes),
  `SplitAwareDatasetSourceInterface` (stores carrying the dataset-level `splits` block).
- Shipped sources: `ConfigSource`, `EntitySource`, `FileSource`.
- `hook_ai_eval_dataset_source_info_alter(&$definitions)` — hide/relabel a source.

## 3. Check executors (tagged services)

- Implement `\Drupal\ai_eval\CheckExecutorInterface` and tag the service `ai_eval.check_executor`.
  `\Drupal\ai_eval\Service\RubricCheckEvaluator` dispatches each rubric check to the first executor
  whose `applies()` returns TRUE; a check no executor claims is **non-executable and excluded from
  score combining**.
- An executor that also implements `CheckSchemaProviderInterface` contributes JSON Schema for the
  kinds it introduces, which `Service\RubricValidator` splices into the rubric schema — so a new
  check kind needs no patch to `schema/rubric.schema.json`.
- Shipped executors (`src/Plugin/CheckExecutor/`): `StringCheckExecutor`
  (`must_contain_any`/`must_not_contain`), `TargetMatchExecutor` (`target_match`).
- **Not shipped in this version**: executors for the schema's `command` and `score_delta` kinds
  ("executors pending" — the `command` kind's contract mandates running in a sandbox provider,
  never on the host, and there is no host command execution anywhere in the code). `tool_usage`
  and `llm_judge` are never executed here either (the tool assertion is graded case-level by
  `tool_usage_grader`; a judge prompt named by a check is not run by the evaluator).

## 4. Events

- `\Drupal\ai_eval\Event\EvalRunCompleteEvent` — dispatched once per stored result, after the
  `ai_eval_result` row is inserted, by `Service\EvalRunner::finalizeRun()` and the `ai-eval:run`
  command. Shipped subscriber: `EventSubscriber\EnvelopeExportSubscriber` (exports a result
  envelope when `export_envelope_on_complete` is enabled).

## Scoring & statistics (services)

- `Service\Scorer` (`ai_eval.scorer`) combines per-grader `GradeResult`s (NULL/skip results are
  excluded from averaging) using `GraderScaleResolver` + `ScoreScale`.
- Trust / quality-gate layer: `Service\JudgeValidator` + `JudgeValidationRunner` +
  `JudgeValidationStore` (validate a judge against `HumanLabelSource` gold labels),
  `Service\JudgeGateTrust` (per-grader trust state), `Service\CorrectedPassRate` (bias-corrected
  rate from judge FP/FN), plus `ConfidenceInterval`, `AgreementStatistics`, `Correlation`,
  `SampleSize`, `BetaBinomialSampler`, `GoldSetAgreement`.
- Optimization: `Command\EvalOptimizeCommand` + `Service\SyntheticPromptBuilder` propose candidate
  prompts, run each `optimizer_candidate_runs` times, and accept one only if it beats the current
  by `improvement_margin` on a held-out split (`DatasetSplitter`).

## Schemas

Public JSON Schemas under `schema/` (`dataset.schema.json`, `rubric.schema.json`,
`judge.schema.json`, `failure_taxonomy.schema.json`) are the authoring contract; the module is
their reference implementation. `Service\DatasetValidator` / `RubricValidator` /
`FailureTaxonomyValidator` validate YAML against them via `opis/json-schema`.
