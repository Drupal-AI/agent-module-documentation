Collects human and logged evaluations of AI Chatbot / AI Assistant responses — thumbs-up/down votes, comparisons, and captured agent results — so site builders can measure and compare AI quality.

---

AI Evaluations (an experimental module in the Drupal AI ecosystem) adds an evaluation layer on top of the AI Assistant API and AI Chatbot. It defines an `ai_evaluation` content entity (with `vote` and `comparison` bundles) and an `ai_agent_result` content entity that logs the provider, prompt, question, response, and detailed output of each assistant/agent run. In the chatbot UI it injects upvote/downvote buttons; clicking one records an `ai_evaluation` capturing the assistant's full configuration snapshot and message history at that moment, so evaluations stay meaningful even after the assistant is later edited. Administrators get per-assistant evaluation screens (total up/down counts plus a Views listing), a per-evaluation detail view that drills into the logged messages and agent results, and CSV export/import to move evaluation datasets between sites. A `PostGenerateResponseEvent` subscriber automatically logs agent and assistant-API responses as `ai_agent_result` entities, and a daily cron job prunes agent results older than a day that were never attached to an evaluation. All administrative screens are gated behind the restricted `administer ai_evaluation` permission. The module ships field formatters (Vote, Comparison, AI map) and Twig templates for rendering evaluations, and depends on `views`, `ai:ai_assistant_api`, and `ai:ai_chatbot`.

---

- Add thumbs-up / thumbs-down buttons to an AI Chatbot so end users rate responses.
- Capture a full snapshot of the assistant's config (system role, preprompts, model) at vote time.
- Store the message-history thread alongside each vote for later review.
- See total upvotes and downvotes per AI Assistant on a summary screen.
- Browse all evaluations for an assistant through a bundled View.
- Drill into a single evaluation to read the messages, prompts, and agent responses.
- Automatically log every agent/assistant-API response as an `ai_agent_result` entity.
- Inspect the provider, model, configuration, prompt, question, and raw output of a logged run.
- Compare two AI systems / prompt variants for the same goal (A/B evaluation, comparison bundle).
- Export the full evaluation dataset to CSV for offline analysis.
- Import an evaluation CSV into another site to share or aggregate evaluations.
- Define additional evaluation types (bundles) with Field UI.
- Attach custom fields to evaluations via the `ai_evaluation_type` bundle entity.
- Prune stale, unattached agent-result logs automatically via daily cron.
- Reach an assistant's evaluations directly from its entity-operations menu.
- Configure evaluation defaults on the AI Evaluation settings screen.
- Use evaluation counts to decide whether an assistant's prompt needs tuning.
- Build reports over evaluation data with Views.
- Provide a feedback loop for improving chatbot answer quality over time.
- Assemble evaluation/training datasets that could be submitted back to model providers.
