<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Azure OpenAI Augmentor plugins

Two `@Augmentor` plugins in `src/Plugin/Augmentor/`, both extending `AzureOpenAIBase`. Each implements `execute(string $input): array` and returns `['default' => [ ...strings ]]` (Augmentor's expected shape). On any exception the error is logged and `[]` is returned.

## `azure_openai_chat` — `AzureOpenAIChat`
- Chat/conversational endpoint. Description: "Given a prompt, the model will return a conversational response."
- Extra config key: `role` (`select`, options `user`/`assistant`, default `user`) via `MESSAGE_ROLES`.
- `execute()`: `getClient(base_url, api_version)` → `prepareText($input)` → `buildOptions()` → `$client->chat()->create($options)` → `processChoices($result->toArray())`.
- `buildOptions()`: builds `messages` = `[['role' => $role, 'content' => $content]]`. When role is `user`, `$content` = the `prompt` template with `{input}` replaced by the prepared input; otherwise `$content` = the raw prompt (input is ignored).
- `processChoices()`: for each `result['choices']`, appends `trim($this->normalizeText($choice['message']['content']), '"')`.

## `azure_openai_completions` — `AzureOpenAICompletions`
- Legacy completions endpoint. Description: predicted completions, optionally with token probabilities.
- Extra config keys (in an "Advanced settings" details group): `temperature` (`number`, step .01, default `0.3`) and `max_tokens` (`number`, default `4000`).
- `execute()`: same flow but `$client->completions()->create($options)`.
- `buildOptions()`: `prompt` = template with `{input}` replaced by `'"' . addslashes($input) . '"'`; `temperature` cast to double; `max_tokens` cast to int.
- `processChoices()`: for each `result['choices']`, appends `trim($this->normalizeText($choice['text']), '"')`.

## Shared input handling (`AzureOpenAIBase::prepareText`, static)
Cleans input before sending to Azure: wraps in `<div>`, parses with `DOMDocument`, strips the tags `pre, code, script, iframe, drupal-media` (plus any passed in), decodes entities, `strip_tags`, removes newlines, collapses spaces, then `preg_replace("/[^\w.?!,' ]/iu", '', ...)` to drop non-word punctuation, and finally `Unicode::truncate($text, $max_length=10000, TRUE)`. Comment notes this is reused from the OpenAI module to improve completion quality.

`normalizeText()` (inherited from `AugmentorBase`) just `Html::decodeEntities()` + `trim()`.
