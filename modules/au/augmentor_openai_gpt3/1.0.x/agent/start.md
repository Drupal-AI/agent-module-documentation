<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenAI GPT3 Augmentor (augmentor_openai_gpt3) — agent index

A provider add-on for the **Augmentor** framework. Registers one Augmentor plugin,
`openai_gpt3_completions`, that runs input text through the **OpenAI completions API**
(default model `gpt-3.5-turbo-instruct`). Package `Augmentor`. Core `^10.2 || ^11 || ^12`.
License GPL-2.0-or-later. Version 1.0.2.

- **The plugin, every setting, the Summarizer/chunker, SDK selection, key handling and execution flow** →
  [plugins/completions.md](plugins/completions.md)

## What it actually is

- Depends on **`augmentor:augmentor`** (info.yml). Composer also pulls two OpenAI PHP SDKs:
  `orhanerday/open-ai ^5.2` and `openai-php/client >=0.10` (composer.json). No other Drupal deps.
- **One plugin**: `OpenAiGPT3Completions` (id `openai_gpt3_completions`, label *"OpenAI GPT3 Completion"*),
  in `src/Plugin/Augmentor/OpenAiGPT3Completions.php`, extending the abstract
  `src/OpenAiGPT3Base.php`, which extends the base module's `AugmentorBase`.
- **No routes, no permissions, no config entities/schema, no Drush.** The only service is the
  help-hook object `src/Hook/AugmentorOpenaiGpt3Hooks.php` (autowired in
  `augmentor_openai_gpt3.services.yml`); `augmentor_openai_gpt3.module` is just a `#[LegacyHook]`
  shim delegating `hook_help()` to it.
- Configuration and key selection happen inside an **Augmentor config entity** through the base
  module's admin UI (`administer augmentors` permission, provided by the `augmentor` project).

## Mechanism (from source)

- `OpenAiGPT3Base::getClient()` picks the SDK from the `sdk` setting (`orhanerday` default, or
  `openai_php`), lazily builds it with `getKeyValue()` (the API key resolved from a **Key entity**
  by `AugmentorBase::getKeyValue()` → `getKeyObject()`), and caches it in `$this->client`.
- `OpenAiGPT3Completions::execute($input)` optionally summarizes over-long input (`summarizeInput()`
  + `stringToChunks()`), substitutes `{input}` into the prompt template, assembles the OpenAI
  options array, optionally adds `user => currentUser->id()` when *User Tracking* is on, then calls
  the private `completion()`; returns `['default' => <choices>]`.
- `completion()` calls the chosen SDK's completion method, decodes the response, maps each
  `choices[].text` through `AugmentorBase::normalizeText()` (entity-decode + trim), and on any API
  error or thrown `\Throwable` logs the message and returns `['_errors' => <generic message>]`.

## Settings (plugin, `defaultConfiguration()`)

`sdk` (base), plus `engine`/model, `prompt` (default `{input}`), `temperature`, `max_tokens`,
`top_p`, `n`, `best_of`, `frequency_penalty`, `presence_penalty`, `suffix`, `stream`, `logprobs`,
`echo`, `stop`, `logit_bias`, `user_tracking`, and a `chunker` group (`enable`, `engine`, `prompt`,
`min`, `max`). Details in [plugins/completions.md](plugins/completions.md).

## Notes

- The OpenAI base URL is **not configurable** — it is fixed by whichever SDK is selected; there is
  no request- or admin-supplied fetch URL.
- The API key is resolved from a Key entity (`AugmentorBase::getKeyValue()`) at call time; only
  OpenAI error messages / exception messages are logged.
