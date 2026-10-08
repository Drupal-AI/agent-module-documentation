<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# openai_gpt3_completions — the OpenAI completions Augmentor plugin

Two classes:
- `src/OpenAiGPT3Base.php` — abstract base `OpenAiGPT3Base extends AugmentorBase implements ContainerFactoryPluginInterface`. Holds SDK selection, client construction and the chunker helper.
- `src/Plugin/Augmentor/OpenAiGPT3Completions.php` — concrete plugin `OpenAiGPT3Completions extends OpenAiGPT3Base`. Attribute `#[Augmentor(id: 'openai_gpt3_completions', label: 'OpenAI GPT3 Completion', …)]` (also legacy annotation). `const DEFAULT_MODEL = 'gpt-3.5-turbo-instruct'`.

## Install / enable

1. `composer require drupal/augmentor_openai_gpt3` (pulls `drupal/augmentor ^1.1`, `orhanerday/open-ai ^5.2`, `openai-php/client >=0.10`).
2. `drush en augmentor_openai_gpt3 -y`.
3. Create/enable a **Key** holding the OpenAI API key (uses the base module's Key integration).
4. Go to the Augmentor admin list (Web services → Augmentors, `administer augmentors`), add an augmentor of type **OpenAI GPT3 Completion**, pick the Key, and configure. This project adds no route of its own; the add/edit form is the base module's `AugmentorForm`.

## SDK selection (base)

`OpenAiGPT3Base::buildConfigurationForm()` adds a `sdk` select with options `orhanerday`
(`orhanerday/open-ai`, default) and `openai_php` (`openai-php/client`).

- `getClient()` → `getSdk()` (`configuration['sdk']`, default `orhanerday`) → `getOrhanerdayClient()` or `getOpenAiClient()`.
- `getOrhanerdayClient()`: `new \Orhanerday\OpenAi\OpenAi($api_key)`, cached in `$this->client`.
- `getOpenAiClient()`: `\OpenAI::client($api_key)`.
- `$api_key = $this->getKeyValue()` — inherited from `AugmentorBase`; resolves the configured **Key entity** via `keyRepository->getKey($this->key)->getKeyValue()`. The raw key never lives in plugin config.
- Both SDKs talk to OpenAI over their own default HTTPS transport; the endpoint host is **not** configurable here.

## Settings (`defaultConfiguration()` / `buildConfigurationForm()`)

Base: `sdk`.

Plugin top-level:
- `engine` — the model. The **Model** select only appears when a key is set; options come from `models()` (live `listModels()` / `models()->list()` call); default `DEFAULT_MODEL`.
- `prompt` — textarea, default `{input}`. `{input}` is replaced with the (possibly summarized) source text at execution.

`advanced` details group (mirrors the OpenAI completions API):
`suffix`, `temperature` (default 0), `max_tokens` (default 16), `top_p` (default 0), `n` (default 1),
`best_of` (default 1), `stream` (default FALSE), `logprobs`, `echo` (FALSE), `stop`, `logit_bias`
(JSON token→bias), `frequency_penalty` (0), `presence_penalty` (0), `user_tracking` (checkbox,
default TRUE — when on, sends `user => currentUser->id()`).

`chunker` details group ("Summarizer"):
`enable` (FALSE), `engine` (model, shown only with a key), `prompt` (default
`Summarize the following text: {input}`), `min` (4000), `max` (6000).

`submitConfigurationForm()` writes each of these back into `$this->configuration` (note it reads
model from `form_state->getValue('model')` into `configuration['engine']`, and stores the whole
`chunker` subtree).

## Execution flow — `execute($input)`

1. `summarizeInput($input)` — if the chunker is enabled, split via `stringToChunks($input, min, max)`, drop chunks ≤20 chars, merge chunks until `min` length, and for each merged block call `completion()` with the chunker prompt (fixed `temperature 0.7`, `max_tokens 2048`, `top_p 1.0`); concatenate the best choice of each. Returns the summarized text (or the original if disabled/empty).
2. Compute `completion_max_input_length = 0.9 * max_tokens * 4`; if the (summarized) input is still longer, summarize **once more**.
3. Build the options array: `model` (=`engine`), `prompt` (`{input}` substituted), `temperature`, `max_tokens`, `top_p`, `n`, `best_of`, `frequency_penalty`, `presence_penalty`; add `user` if `user_tracking`.
4. `output['default'] = $this->completion($options)`; return `$output`.

## `completion(array $options)`

- `orhanerday`: `$client->completion($options)` then `Json::decode()`. `openai_php`: `$client->completions()->create($options)->toArray()`.
- Error handling: if the decoded result has `_errors` or `error`, log `OpenAI API error: %message` at error level and return `['_errors' => t('Error during the completion execution, please check the logs…')->render()]`. Any thrown `\Throwable` is caught, logged the same way, and returns the same generic `_errors` payload.
- Success: iterate `result['choices']`, push `normalizeText($choice['text'])` into `$choices`, return the array. `AugmentorBase::normalizeText()` runs `Html::decodeEntities()` + `trim()`.

## Chunker helper — `stringToChunks($input, $min = 4000, $max = 6000)`

Pure string splitter (no API): walks lines, treats punctuation-free short lines as headings
(`headingLike()`) to force chunk boundaries, packs lines toward `min`/`max` character budgets, and
falls back to sentence-splitting (`preg_split('/([.?!:])/')`) when a single line exceeds `max`.
Returns an array of text chunks.

## Operating notes

- No permissions/routes are defined here; access is entirely the base module's `administer augmentors`.
- Output is returned as data (`['default' => [strings]]` or `['_errors' => msg]`) to the Augmentor
  framework — this plugin does not render it, so escaping is the responsibility of whatever consumes
  the augmentor result.
- With `user_tracking` on, the Drupal user id is sent to OpenAI as the `user` field (abuse-monitoring
  identifier); turn it off to avoid that egress.
