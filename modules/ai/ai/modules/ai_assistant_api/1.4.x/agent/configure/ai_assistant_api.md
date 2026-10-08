# configure — the `ai_assistant` config entity

Assistants are **`ai_assistant`** config entities (config prefix `ai_assistant`, class
`Entity\AiAssistant`). Manage them at **/admin/config/ai/ai-assistant** — the `configure`
route **`entity.ai_assistant.collection`** (`_entity_list: ai_assistant`). Add / edit /
delete forms live at `…/add`, `…/{ai_assistant}`, `…/{ai_assistant}/delete`
(`entity.ai_assistant.{add_form,edit_form,delete_form}`), all built by
`Form\AiAssistantForm`.

## Permission

The module defines exactly one permission: **`administer ai_assistant`** ("Administer AI
Assistant"), the entity's `admin_permission` — it gates every route above. Grant it with:

```bash
drush role:perm:add administrator 'administer ai_assistant'
```

There is no per-run permission; who may *run* an assistant is controlled by the `roles`
field on each entity (see `userHasAccess()` — uid 1 always passes; empty roles = open).

## Persisted fields (`config_export`)

| Field | Meaning |
|---|---|
| `id`, `label`, `description` | identity |
| `llm_provider` | provider plugin id, or `__default__` to use the site default chat provider |
| `llm_model` | model id (ignored when provider is `__default__`) |
| `llm_configuration` | extra provider config (temperature, etc.), passed to `setConfiguration()` |
| `system_prompt` | the assistant's system prompt (see override note below) |
| `pre_action_prompt` | prompt used for the action-planning (pre-)pass |
| `instructions` | extra instructions surfaced to the model |
| `actions_enabled` | map of enabled `AiAssistantAction` plugin ids → per-action config |
| `use_function_calling` | bool — use native tool/function calling instead of JSON planning |
| `ai_agent` | optional agent id; if set and `ai_agents` is installed, the run is delegated to that agent |
| `allow_history` | `session`, `session_one_thread`, or a non-storing value |
| `history_context_length` | how many prior user/assistant *pairs* to resend (default `"2"`) |
| `roles` | roles allowed to run the assistant |
| `error_message` | generic error text (`[error_message]` token is replaced with the exception) |
| `specific_error_messages` | per-case error overrides |

(The schema `config/schema/ai_assistant_api.schema.yml` also lists `assistant_message`,
`no_results_message`, `preprompt_instructions`, `system_role` — used by the form/UI but
not all are exported.)

## `allow_history` behaviour

Threads are kept in the private tempstore bin `ai_assistant_api`, keyed per user.
`shouldStoreSession()` is true only for `session` and `session_one_thread`;
`session_one_thread` reuses a single stable thread id per assistant+user. Otherwise only
the current message is sent (no memory).

## System-prompt override (a `settings.php` gotcha)

Unless the site setting **`ai_assistant_custom_prompts`** is `TRUE`, the runner **ignores**
the entity's stored `system_prompt` and loads the module's own
`resources/system_prompt.txt` instead (so upgrades ship the latest prompt). Set
`$settings['ai_assistant_custom_prompts'] = TRUE;` to make your edited `system_prompt`
authoritative.

To run an assistant from code once configured, see [../api/ai_assistant_api.md](../api/ai_assistant_api.md).
