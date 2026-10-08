# Prompt explorer form

Route `openai_prompt.prompt_form` → `/admin/config/openai/openai-prompt` →
`\Drupal\openai_prompt\Form\PromptForm` (form id `openai_prompt_prompt`), gated by
`_permission: 'access openai prompt'`. No stored config — each AJAX submit issues one completion
call and shows the answer.

## Fields

| Field | Key | Default | Notes |
|-------|-----|---------|-------|
| Prompt | `prompt` | required | The text prompt. |
| Model | `model` | `text-davinci-003` | Options from `filterModels(['text'])` (legacy text/completions models). |
| Temperature | `temperature` | `0.4` | 0–2. |
| Max tokens | `max_tokens` | `128` | Min 128, max 4097. Validated: `text-davinci-003` ≤ 4097; `text-curie-001`/`text-babage-001`/`text-ada-001` ≤ 2049. |
| Response | `response` | read-only | Output textarea, wrapper `#openai-prompt-response`. |

## Runtime

The submit button's `#ajax` callback is `::getResponse`, which reads the values and calls
`$this->api->completions($model, $prompt, $temperature, $max_tokens)` (parent `OpenAIApi::completions()`,
the legacy `/v1/completions` endpoint) and sets the trimmed answer into `response`. `submitForm()` is
empty — the work happens in the AJAX callback.

To call the same endpoint from code:

    $answer = \Drupal::service('openai.api')
      ->completions('gpt-3.5-turbo-instruct', 'Write a haiku about Drupal.', 0.4, 128);

Parent service reference: [../../../../../1.0.x/agent/api/service.md](../../../../../1.0.x/agent/api/service.md).
