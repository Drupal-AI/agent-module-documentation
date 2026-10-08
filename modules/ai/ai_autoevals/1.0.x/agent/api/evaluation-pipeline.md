<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI AutoEvals — the evaluation pipeline

Capture (synchronous, on `ai` events) → queue → grade (asynchronous, queue worker). All LLM calls
go through the `ai` provider abstraction; AutoEvals never talks to a provider HTTP API directly.

## 1. Capture — `EventSubscriber\AiAutoevalsSubscriber`

Subscribes to `ai` module `PreGenerateResponseEvent` (`onPreGenerateResponse`, prio 100) and
`PostGenerateResponseEvent` (`onPostGenerateResponse`, prio 100); also
`ai_agents.finished_execution` (`onAgentFinishedExecution`) when `ai_agents` is installed.

- **Pre**: guarded by a static re-entrancy `$depth`. Returns early if tags contain
  `ai_autoevals:internal` (AutoEvals' own calls) or any `global_exclude_tags`; if the operation type
  isn't in `operation_types`; or if `auto_track` is off **and** the tag `ai_autoevals:track` is
  absent. Otherwise resolves a matching set via
  `EvaluationManager::getMatchingEvaluationSetWithHook()` and stashes a pending record (input,
  provider/model, tags, metadata) keyed by request thread id, and tracks conversation context via
  `ConversationTracker`.
- **Post**: pops the pending record, extracts output text, re-checks global + per-set response
  exclusion/inclusion keywords, then `EvaluationManager::createEvaluation($data)` +
  `queueEvaluation()`. Input/output text is extracted defensively from strings/objects/arrays by
  `extractInputText()`/`extractOutputText()`.
- **Agent-finished**: only root agents (no caller id); same auto_track + set-matching gates; stores
  `provider_id = 'ai_agents'`, `model_id = agentId`.

`EvaluationManager::getMatchingEvaluationSetWithHook()` order: global query-exclusion circuit
breaker → candidate sets by operation type + tags → `hook_ai_autoevals_evaluation_sets_alter()` →
per-set query exclusion/inclusion keyword checks → first surviving set.

## 2. Create & queue — `Service\EvaluationManager`

- `createEvaluation(array $data)` creates an `ai_autoevals_evaluation_result` (status `pending`).
- `queueEvaluation(int $id)` pushes `{evaluation_id, queued_at}` onto queue
  `ai_autoevals_evaluation_worker`.
- `requeueEvaluation()` resets a non-completed result to pending and re-queues.
- Read helpers (`getEvaluationHistory()`, `getStatistics()`, `getRecentEvaluations()`) use entity
  queries with `accessCheck(TRUE)` and bound `->condition()` filters (status / evaluation_set_id /
  provider_id / score range); averages via `database->select()->addExpression('AVG(score)')`.

## 3. Grade — `Plugin\QueueWorker\EvaluationWorker` (id `ai_autoevals_evaluation_worker`, cron 60s)

Per item: load the result, dispatch `PreEvaluationEvent`, run fact extraction then evaluation,
persist choice/score/analysis/status, dispatch `PostEvaluationEvent` (or `EvaluationFailedEvent` on
error). Run via cron or `drush queue:run ai_autoevals_evaluation_worker`.

### Fact extraction — `Service\FactExtractor` + `Plugin\FactExtractor\*`

- `FactExtractor` (facade) maps the method to a plugin: `ai_generated → ai`, `rule_based → keyword`,
  `hybrid → hybrid`; caches results in `cache.ai_autoevals_facts`.
- `FactExtractorManager` discovers `@FactExtractor` plugins (interface
  `FactExtractorPluginInterface::extract(string $input, array $context, ?EvaluationSetInterface)`).
- `AiFactExtractor` (id `ai`) builds an extraction prompt (optionally injecting the set's
  `custom_knowledge`), calls `provider->chat($msg, $model, ['ai_autoevals:internal'])`, and parses a
  JSON array of criteria strings out of the response. `KeywordFactExtractor` / `HybridFactExtractor`
  / `RegexFactExtractor` provide rule-based variants. Criteria describe what a correct answer must
  contain, derived from the **input only** (not the AI answer).

### Evaluation — `Service\Evaluator::evaluate($set, $input, $facts, $output)`

- `loadPromptTemplate()`: custom template on the set → referenced `ai_prompt` entity →
  default `factuality.yaml` (`prompt` key), loaded via `ExtensionPathResolver`.
- Substitutes `{{input}}`, `{{expected}}` (bulleted facts), `{{output}}` into the template,
  `provider->chat($msg, $model, ['ai_autoevals:internal'])`.
- `parseResponse()`: regex-extracts a choice `A`–`E` (parenthesized letter, bare letter, `Choice:`,
  `Answer:`, or keyword synonyms subset/superset/exact match/disagreement/irrelevant); defaults to
  `D` (disagreement) with a warning when nothing parses. `calculateScore()` maps the choice through
  the set's `choice_scores`.

## Events (`src/Event/*`)

`PreEvaluationEvent` (`ai_autoevals.pre_evaluation`), `PostEvaluationEvent`
(`ai_autoevals.post_evaluation`), `EvaluationFailedEvent` (`ai_autoevals.evaluation_failed`).
