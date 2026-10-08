<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SDK selection & credentials

## Install / enable
`composer require drupal/augmentor_chatgpt` (pulls `drupal/augmentor`, `orhanerday/open-ai`,
`openai-php/client`), then enable `augmentor_chatgpt`. No install hooks, no default config.

## Where configuration lives
There is **no settings route or config object owned by this module**. A `chatgpt` augmentor is a
config entity created and edited through the Augmentor base module's admin UI (Web services »
Augmentors), gated by Augmentor's `administer augmentors` permission. All plugin settings persist on
that entity's `settings`. This module also ships no config schema.

## SDK choice (`ChatGptBase`, `src/ChatGptBase.php`)
`defaultConfiguration()` adds `sdk` (default `'orhanerday'`). `buildConfigurationForm()` renders an
**SDK** select with two options:
- `orhanerday` → `orhanerday/open-ai` (`Orhanerday\OpenAi\OpenAi`)
- `openai_php` → `openai-php/client` (`OpenAI\Client`)

`getSdk()` returns the stored value (default `orhanerday`). `getClient()` dispatches to
`getOrhanerdayClient()` (`new OrhanerdayOpenAi($api_key)`) or `getOpenAiClient()`
(`\OpenAI::client($api_key)`), each memoized in `$this->client`. Both SDKs talk to OpenAI's own
endpoints; the base URL is not configurable here.

## API key (credential handling)
The key is **not** stored inline. `AugmentorBase` holds a `key` config value that is the machine name
of a **Key** entity (Key module). `getKeyValue()` → `getKeyObject()->getKeyValue()` resolves the
secret at call time and passes it to the SDK constructor in `getOrhanerdayClient()` /
`getOpenAiClient()`. Configure the OpenAI API key as a Key entity and select it on the augmentor.

## Operating notes
- On API/auth failure, `execute()` and `models()` log the OpenAI `error.message` (or the thrown
  message) to the logger and return a generic user-facing error; the raw completion is not echoed
  unfiltered into markup by this module.
- `user_tracking` (default on) sends the current Drupal user id as OpenAI's `user` field.
- Costs/limits are governed by `max_tokens`, `n`, and the chosen `model`.
