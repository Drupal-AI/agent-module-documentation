<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Evaluations (ai_evaluations) — agent index

Adds an **evaluation layer** over the Drupal AI Chatbot / AI Assistant API: end-user
upvote/downvote buttons, logged agent results, admin review screens, and CSV export/import.
Package *AI Tools*. **Experimental** (`lifecycle: experimental`). Core `^10.2 || ^11`.
License GPL-2.0-or-later. Version 0.1.0.

- **Entities, routes, permission, services, formatters, cron** →
  [config/architecture.md](config/architecture.md)

## Dependencies

- `drupal:views`, `ai:ai_assistant_api`, `ai:ai_chatbot`. Composer requires `drupal/ai ^1.1`.
- No submodules, no Drush, **no config schema** (only `config/install/` defaults).

## Entities it provides

- **`ai_evaluation`** (content entity, base table `ai_evaluation`, admin permission
  `administer ai_evaluation`) — bundles `vote` and `comparison` (config entities
  `ai_evaluation_type`). Fields include `value`, `messages` (map), `assistant`, `thread_id`,
  `system_role`, `preprompt_instructions`, `pre_action_prompt`, `assistant_message`,
  `model_config`. Owner defaults to anonymous (uid 0) if unset (`AIEvaluation::preSave()`).
- **`ai_agent_result`** (content entity, base table `ai_agent_result`, admin permission
  `administer ai_agent_result`) — logs `ai_provider_info`, `question`, `prompt_used`,
  `response_given`, `detailed_output`, `thread_id`, `action`, `log_status`.
- **`ai_evaluation_type`** (config bundle entity).

## Routes (`ai_evaluations.routing.yml`)

- `ai_evaluations.vote` — `ai-evaluations/vote/{assistant_id}/{thread_id}/{vote}` →
  `Controller\Vote::vote()`; **`_access: 'TRUE'`** (open). Creates an `ai_evaluation` and returns
  an AjaxResponse. Wired into the chatbot via `hook_deepchat_buttons_alter()`.
- `entity.ai_evaluation.settings` — `admin/config/ai/evaluation`, `AIEvaluationSettingsForm`,
  `administer ai_evaluation`.
- `ai_evaluations.evaluations` / `.ai_assistant.evaluations` / `.ai_assistant.evaluation` —
  admin evaluation screens, `administer ai_evaluation`.
- `ai_evaluations.ai_assistant.evaluations.export` — `admin/config/ai/evaluation/export`,
  `administer ai_evaluation` (CSV download via `Evaluations::export()`).
- `ai_evaluations.ai_assistant.evaluations.import` — `admin/config/ai/evaluation/import`,
  `EvaluationsImportForm`, `administer ai_evaluation`.
- `ai_evaluations.ai_evaluation_type.edit_form` — bundle edit, `administer ai_evaluation`.

## Permission (`ai_evaluations.permissions.yml`)

- `administer ai_evaluation` — `restrict access: true`. Gates every admin route (settings, review,
  export, import, bundle edit). Also each entity's `admin_permission`.

## Services / hooks

- `ai_evaluations.post_request_subscriber` = `EventSubscriber\PostRequestEventSubscriber` —
  subscribes to `PostGenerateResponseEvent`; on `assistant_action_ai_agent` or `ai_assistant_api`
  tagged runs it creates an `ai_agent_result` capturing provider/model/config, the user question,
  system prompt, response, and raw output.
- `.module` hooks: `hook_cron` (daily prune of unattached `ai_agent_result` older than 1 day,
  `accessCheck(FALSE)`), `hook_deepchat_buttons_alter` (adds vote buttons linking to
  `ai_evaluations.vote`), `hook_preprocess_ai_chatbot` / `_ai_deepchat` (attach libraries),
  `hook_entity_operation`, `hook_entity_view` (renders logged messages/agent-results on the
  evaluation view), `hook_theme` (`ai_chatbot_message__evaluation`, `ai_evaluations_logged`).
- Field formatters (`src/Plugin/Field/FieldFormatter/`): `Vote` (✓/✗), `Comparison`, `AiMap`.

## Mechanism (from source)

- `Vote::vote()` loads the `ai_assistant` by URL id, snapshots its config + the runner's message
  history, and saves an `ai_evaluation` (bundle `vote`) with `value = {vote}`.
- `Evaluations::export()` emits CSV where each cell is `base64_encode(serialize($field_values))`;
  `EvaluationsImportForm::submitForm()` reads that CSV back, decoding each cell into its field
  value (JSON for `messages`/`model_config`), and creates `ai_evaluation` entities. Import requires
  `administer ai_evaluation`.
