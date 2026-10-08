<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI AutoEvals automatically grades the factual accuracy of AI responses using a two-step LLM process — extract the criteria a correct answer must satisfy from the user's question, then compare the AI response against those criteria and store a score.

---

AI AutoEvals (module `ai_autoevals`, package AI) instruments the contributed `ai` module to evaluate the quality of AI responses. It subscribes to the AI module's `PreGenerateResponseEvent`/`PostGenerateResponseEvent` (and, if present, `ai_agents` `AgentFinishedExecutionEvent`) in `AiAutoevalsSubscriber`: when auto-tracking is on, or a request is tagged `ai_autoevals:track`, and the operation type and tag/keyword filters match an enabled **evaluation set**, it captures the input and output and creates an `ai_autoevals_evaluation_result` content entity, then enqueues it on the `ai_autoevals_evaluation_worker` queue. The `EvaluationWorker` queue worker runs the two-step evaluation: `FactExtractor` derives expected criteria from the user input (via a pluggable `FactExtractor` plugin — `ai` LLM-based, `keyword` rule-based, or `hybrid`), and `Evaluator` sends a factuality prompt (from `factuality.yaml`, an `ai_prompt` entity, or a custom template) to the configured provider/model and parses the returned choice (A–E) into a 0–1 score using the set's `choice_scores`. All LLM calls go through the `ai` module's provider abstraction (`AiProviderPluginManager` / `ProviderProxy`) tagged `ai_autoevals:internal`, so credentials, provider selection, and transport are handled by `ai` + `key`. Results are browsed on an admin dashboard and results list, with a detail view (input, output, extracted facts, LLM analysis, tags, metadata), plus requeue, re-evaluate-with-different-config, delete, and batch operations. Configuration comprises the `ai_autoevals.settings` object (default provider/model, operation types, auto-track, fact-extraction method, context depth, retention period, debug, global keyword/tag exclusions) and `ai_autoevals.evaluation_set.*` config entities (which the fluent `EvaluationSet::builder()` can create programmatically). `hook_cron()` purges results older than the retention period; lifecycle events (`pre_evaluation`, `post_evaluation`, `evaluation_failed`) and `hook_ai_autoevals_evaluation_sets_alter()` allow extension. Every route is gated by a granular permission (view/edit/delete results, view/manage sets, requeue, batch, administer).

Use it to measure and track how factually accurate your site's AI features are over time, A/B-compare provider/model/prompt configurations, and gate AI features on evaluation quality — for testing and evaluation purposes (the project marks itself not production ready).

---

- Automatically evaluate the factual accuracy of AI responses generated through the `ai` module.
- Derive evaluation criteria from the user's question, not the AI answer, to avoid grading bias.
- Auto-track every matching AI request, or opt in per request with the `ai_autoevals:track` tag.
- Add context tags to a request and trigger evaluation sets on those tags.
- Choose fact extraction per set: AI-generated (LLM), rule-based (keyword), or hybrid.
- Give an evaluation set custom domain knowledge to sharpen AI fact extraction.
- Override the evaluation prompt per set with a custom template or an `ai_prompt` entity.
- Map the A–E evaluation choices to custom numeric scores per set.
- Trigger or exclude evaluations by query/response keywords and by request tags.
- Restrict evaluation to specific operation types (e.g. `chat`, `chat_completion`).
- Include prior conversation turns as context via a configurable context depth.
- Process evaluations asynchronously via the `ai_autoevals_evaluation_worker` queue (cron or `drush queue:run`).
- View a dashboard with totals, average score, status counts, per-set stats, and score distribution.
- Browse and filter the results list by status, evaluation set, and provider.
- Inspect a result's input, output, extracted facts, LLM analysis, tags, and metadata.
- Requeue failed or pending evaluations.
- Re-evaluate an existing result with a different evaluation-set configuration for comparison.
- Run batch re-evaluations / comparisons across many results.
- Create evaluation sets programmatically with the fluent `EvaluationSet::builder()`.
- Purge old results automatically via a configurable retention period on cron.
- React to `pre_evaluation`, `post_evaluation`, and `evaluation_failed` events.
- Filter candidate evaluation sets with `hook_ai_autoevals_evaluation_sets_alter()` (e.g. by language or role).
- Add a custom `@FactExtractor` plugin for specialized criteria extraction.
- Rely on the `ai` provider abstraction and `key` for provider credentials rather than storing keys itself.
- Gate all administration and results access behind granular AI AutoEvals permissions.
