<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Evaluations — architecture, entities, routes & operation

## Install / enable

```
composer require drupal/ai_evaluations
drush en ai_evaluations
```

Pulls `drupal/ai` and requires the `views`, `ai_assistant_api`, and `ai_chatbot` modules enabled.
The module is `lifecycle: experimental`. Two `ai_evaluation_type` bundles ship as install config:
`vote` and `comparison` (`config/install/ai_evaluations.ai_evaluation_type.*.yml`); the `evaluations`
View and two `system.action` configs also install. There is **no `config/schema/`** directory.

## Entities

### `ai_evaluation` (content, `src/Entity/AIEvaluation.php`)
Base table `ai_evaluation`; bundle entity `ai_evaluation_type`; `admin_permission =
administer ai_evaluation`; `field_ui_base_route = ai_evaluations.ai_evaluation_type.edit_form`.
Base fields: `uid` (owner, defaults to **anonymous uid 0** if unset — `preSave()`), `value`,
`messages` (map: role/message/timestamp), `assistant` (ref), `thread_id`, `system_role`,
`preprompt_instructions`, `pre_action_prompt`, `assistant_message`, `model_config` (map), plus
changed/created. Handlers: `AIEvaluationForm`, core delete forms, `AIEvaluationHtmlRouteProvider`,
`AIEvaluationListBuilder`, `EntityViewsData`.

### `ai_agent_result` (content, `src/Entity/AIAgentResult.php`)
Base table `ai_agent_result`; `admin_permission = administer ai_agent_result`. Fields:
`label`, `thread_id`, `action`, `log_status`, `ai_provider_info`, `question`, `prompt_used`,
`response_given`, `detailed_output`, `uid`. Written by the event subscriber (below).

### `ai_evaluation_type` (config bundle, `src/Entity/AiEvaluationType.php`)
`config_export = {id, label}`; `admin_permission = administer ai_evaluation`.

## Routes & permission

| Route | Path | Access | Handler |
|---|---|---|---|
| `entity.ai_evaluation.settings` | `admin/config/ai/evaluation` | `administer ai_evaluation` | `AIEvaluationSettingsForm` |
| `ai_evaluations.vote` | `ai-evaluations/vote/{assistant_id}/{thread_id}/{vote}` | **`_access: 'TRUE'`** | `Vote::vote()` |
| `ai_evaluations.evaluations` | `admin/config/ai/evaluation/evaluations` | `administer ai_evaluation` | `Evaluations::assistantEvaluations()` |
| `ai_evaluations.ai_assistant.evaluations` | `admin/config/ai/ai-assistant/{ai_assistant}/evaluation` | `administer ai_evaluation` | `Evaluations::assistantEvaluations()` |
| `ai_evaluations.ai_assistant.evaluation` | `.../evaluation/{ai_evaluation}` | `administer ai_evaluation` | `Evaluations::assistantEvaluation()` |
| `ai_evaluations.ai_assistant.evaluations.export` | `admin/config/ai/evaluation/export` | `administer ai_evaluation` | `Evaluations::export()` |
| `ai_evaluations.ai_assistant.evaluations.import` | `admin/config/ai/evaluation/import` | `administer ai_evaluation` | `EvaluationsImportForm` |
| `ai_evaluations.ai_evaluation_type.edit_form` | `admin/config/ai/evaluation/{ai_evaluation_type}` | `administer ai_evaluation` | `ai_evaluation_type.edit` |

Permission `administer ai_evaluation` (`ai_evaluations.permissions.yml`) is `restrict access: true`.
The vote route is the one intentionally-public endpoint (end users vote from the chatbot UI).

## Vote flow

`hook_deepchat_buttons_alter()` (`.module`) adds up/down buttons whose URLs point at
`ai_evaluations.vote` with `assistant_id`, `thread_id`, and `vote` (1 or 0).
`Vote::vote($assistant_id, $thread_id, $vote)` (src/Controller/Vote.php):
loads the `ai_assistant`, primes `ai_assistant_api.runner` with the thread, then
`entityTypeManager->getStorage('ai_evaluation')->create([... 'value' => $vote,
'messages' => [$runner->getMessageHistory()], 'system_role' => ..., 'model_config' => ...])->save()`
and returns an AjaxResponse replacing `.chat-message-evaluation` with a "logged" message. It does
not call the AI provider; it only reads config + message history and writes one entity.

## Event logging

`PostRequestEventSubscriber::logAgentPostRequest()` (subscribes to
`PostGenerateResponseEvent`): for runs tagged `assistant_action_ai_agent` or `ai_assistant_api`,
it extracts prompt/thread tags and creates an `ai_agent_result` with the decoded response
(`ai.prompt_json_decode`), provider/model/config, the first user message text, the system prompt
(`getDebugData()['chat_system_role']`), and `Json::encode($event->getOutput()->getRawOutput())`.

## Export / import

- `Evaluations::export()` (src/Controller/Evaluations.php:90) — loads all `ai_evaluation`
  (`accessCheck(FALSE)`), skips `id` and entity_reference fields, and writes each remaining field
  as `base64_encode(serialize($values))`, one CSV row per evaluation; downloads `evaluations-YYMMDD.csv`.
- `EvaluationsImportForm` (src/Form/EvaluationsImportForm.php) — uploads a CSV; `submitForm()`
  reads rows and decodes each base64-encoded cell back into its stored field value (`messages`/
  `model_config` as JSON), then creates `ai_evaluation` entities (dupes by UUID are swallowed via
  the `EntityStorageException` catch). Import is restricted to holders of `administer ai_evaluation`
  and should only be pointed at export files you produced and trust.

## Cron

`ai_evaluations_cron()` — at most once per 24h (state key `ai_evaluations_clean_agent_responses`):
deletes `ai_agent_result` entities older than one day whose `ai_evaluation` is NULL
(`accessCheck(FALSE)`), keeping only results that got attached to an evaluation.

## Display

`hook_entity_view()` renders an evaluation's `messages` and matching `ai_agent_result` fields
(provider info, prompt, question, response, detailed output) in `<h3>`/`<pre>` blocks on the
evaluation view. Field formatters: `Vote` (renders `✓`/`✗` from `value`), `Comparison` (renders
`value`), `AiMap` (renders map/message rows). These display surfaces are all behind
`administer ai_evaluation`.

## Notes

- No config schema means these entities/config have no typed-data schema (config-inspection and
  translation tooling will warn); functionality is unaffected.
- API keys / TLS are entirely the `drupal/ai` provider layer's concern; this module holds no
  credentials and makes no direct outbound HTTP.
