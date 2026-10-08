# ChatGPT explorer form

Route `openai_chatgpt.chat_form` → `/admin/config/openai/chatgpt` →
`\Drupal\openai_chatgpt\Form\ChatGptForm` (form id `openai_chatgpt_form`), gated by
`_permission: 'access openai chatgpt'`. No stored config — conversation state lives in the form's
`$form_state` storage for the session of the form.

## Fields

| Field | Key | Default | Notes |
|-------|-----|---------|-------|
| Ask ChatGPT | `text` | required | The user turn. |
| Model | `model` | `gpt-3.5-turbo` | Options from `filterModels(['gpt'])`. |
| Temperature | `temperature` | `0.4` | 0–2. |
| Max tokens | `max_tokens` | `128` | Min 128. Validated per model (gpt-4 ≤ 8192, gpt-3.5-turbo ≤ 4096, gpt-3.5-turbo-16k ≤ 16384). |
| Profile (system) | `system` | "You are a friendly helpful assistant…" | Required; used as the `system` message when the conversation starts. Change it before the first turn. |
| Response | `response` | read-only | Output textarea, wrapper `#openai-chatgpt-response`. |

## Conversation flow (runtime)

`submitForm()`:
1. Reads the existing `messages` from form storage. If empty, seeds
   `[{system: profile}, {user: text}]`; otherwise appends `{user: text}` to the history.
2. `$result = $this->api->chat($model, $messages, $temperature, $max_tokens)` (parent
   `OpenAIApi::chat()`).
3. Appends `{assistant: $result}`, saves the whole `messages` array back to storage, and
   `setRebuild(TRUE)`.

The `#ajax` callback `::getResponse` renders the last stored assistant message into `response`.
Because the full history is resent each turn, later turns cost more tokens; the profile/system
message is fixed once the conversation begins (reload the form to change it).

Parent service reference: [../../../../../1.0.x/agent/api/service.md](../../../../../1.0.x/agent/api/service.md).
