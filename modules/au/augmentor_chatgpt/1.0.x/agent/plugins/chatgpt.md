<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Augmentor plugin: `chatgpt`

Class `Drupal\augmentor_chatgpt\Plugin\Augmentor\ChatGpt` (`src/Plugin/Augmentor/ChatGpt.php`),
extends `ChatGptBase` (`src/ChatGptBase.php`) → `Drupal\augmentor\AugmentorBase`. Registered with the
`#[Augmentor(id: 'chatgpt', label: 'ChatGPT', ...)]` attribute (a legacy `@Augmentor` annotation is
also present). Uses `DependencySerializationTrait`.

## Constants
- `DEFAULT_ENGINE = 'gpt-3.5-turbo'` — default model when the live list is unavailable.
- `MESSAGE_ROLES = ['system' => 'System', 'assistant' => 'Assistant', 'user' => 'User']`.

## Settings (`defaultConfiguration()`)
Adds to the base + `ChatGptBase` config: `model`, `messages`, `temperature`, `max_tokens`, `top_p`,
`n`, `frequency_penalty`, `presence_penalty`, `user_tracking` (all default `NULL`). Stored on the
Augmentor config entity's `settings`; no config schema is shipped by this module.

## Config form (`buildConfigurationForm()`)
- **Model** select — only rendered when a key is set (`$this->configuration['key']`); options come from
  `models()` (live API list), default `DEFAULT_ENGINE`.
- **Messages** fieldset — a `#tree` list of rows, each a `role` select (`MESSAGE_ROLES`) + `content`
  textarea (default `{input}`). Ajax "Add one more message" / "Remove last message" buttons manage the
  row count via `$form_state->get('num_messages')`; static handlers `addOne()`, `removeCallback()`,
  and the ajax `addmoreCallback()` (returns `$form['settings']['messages']`).
- **Advanced** details — number inputs: `temperature` (def 1), `max_tokens` (def 100), `top_p` (def 0),
  `n` (def 1), `frequency_penalty` (def 0), `presence_penalty` (def 0); `user_tracking` checkbox
  (def TRUE) — sends the current user id to OpenAI for abuse monitoring.

`submitConfigurationForm()` writes each of the above from `$form_state` back into `$this->configuration`.

## Execution (`execute($input)`)
1. Iterates `configuration['messages']`; for each non-empty row builds `['role'=>..., 'content'=>...]`,
   replacing `{input}` with `$input` **only** in `user` messages.
2. Builds `$options` with `model`, `messages`, and casts `temperature`/`top_p`/`frequency_penalty`/
   `presence_penalty` to float, `max_tokens`/`n` to int. If `user_tracking`, adds
   `user => $this->currentUser->id()`.
3. Calls the selected SDK (see [config/settings.md](../config/settings.md)):
   - `orhanerday`: `Json::decode($this->getClient()->chat($options), TRUE)`
   - `openai_php`: `$this->getClient()->chat()->create($options)->toArray()`
4. If the result has an `error` key, logs `error.message` and returns
   `['error' => 'Error during the chat completion execution, please check the logs...']`.
   Otherwise collects each `choices[].message.content` through `AugmentorBase::normalizeText()`
   (trim + `Html::decodeEntities`) into `$output['default']` (an array of strings).
5. Any thrown `\Throwable` is logged and returns `['_errors' => 'Error during the chat completion...']`.

## Model list (`models()`, private)
`orhanerday`: `getClient()->listModels()` (JSON-decoded); `openai_php`: `getClient()->models()->list()->toArray()`.
Maps `data[].id => id`. On a missing `data` key, logs `error.message`.

## Return shape
Success: `['default' => ['<completion text>', ...]]`. Consumers read the `default` output key.
