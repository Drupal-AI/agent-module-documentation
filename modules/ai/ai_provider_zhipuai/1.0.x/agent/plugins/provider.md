<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `zhipuai` AI provider plugin

`Plugin\AiProvider\ZhipuaiProvider` — a `drupal/ai` provider for Zhipu AI's GLM chat
models. Declared with `#[AiProvider(id: 'zhipuai', label: 'Zhipuai')]`, extends
`Drupal\ai\Base\AiProviderClientBase`, implements
`Drupal\ai\OperationType\Chat\ChatInterface`.

## Capabilities

- `getSupportedOperationTypes()` → `['chat']`.
- `getConfiguredModels('chat')` → `glm-4.5`, `glm-4.5-air`, `glm-4.5-x`, `glm-4.5-airx`,
  `glm-4.5-flash` (returned as a `value => value` map). Other operation types → empty.
- `isUsable()` returns FALSE unless `api_key` config is set (and, if an operation type is
  given, that it is `chat`).
- `getConfig()` reads config object `ai_provider_zhipuai.settings`.

## Authentication

- `loadApiKey()` resolves the configured Key entity:
  `keyRepository->getKey($this->getConfig()->get('api_key'))->getKeyValue()`.
- `setAuthentication($key)` / `getClient($api_key)` allow hot-swapping the key at runtime.
- `loadClient()` lazily fetches the `ai_provider_zhipuai.client` service and calls
  `setApiToken()` with the resolved key.

## `chat()` flow

1. `loadClient()`.
2. `$this->client->textGeneration('/chat/completions', $model_id, $input)`.
3. `Json::decode($response)`, then build a
   `ChatMessage($data['choices'][0]['message']['role'], …['content'])`.
4. Return `new ChatOutput($message, $response, [])`.

## The HTTP client (`ZhipuaiClient`)

Service `ai_provider_zhipuai.client`, constructed with core `@http_client` (Guzzle).

- Base (serverless) URL: `https://open.bigmodel.cn/api/paas/v4`.
- `finalEndpoint($endpoint)`: if `$endpoint` starts with `http(s)://` it is used as a
  dedicated URL, otherwise it is appended to the serverless base. In this module the
  endpoint is always the hard-coded `/chat/completions`, and `model_id` is one of the
  fixed model names above.
- `textGeneration()` takes the first message from the prompt
  (`$prompt->getMessages()[0]->toArray()`) and posts
  `{ model, messages: [{ role, content }] }`.
- `makeRequest()`:
  - throws if no API token is set;
  - sets `connect_timeout` / `read_timeout` to 120s;
  - sets `Authorization: Bearer <apiToken>` and (for JSON bodies)
    `Content-Type: application/json`;
  - `POST`s via the injected Guzzle client and returns the response body.
  - Uses core/Guzzle default TLS behaviour (no `verify`/SSL options are overridden).

## Configure it

See [../config/settings.md](../config/settings.md): create a Key with your Zhipuai API
key, then select it at `/admin/config/ai/providers/zhipuai`.

## Notes

- Zhipu's v4 API accepts the API key directly as a Bearer token, so this module sends the
  raw key as `Authorization: Bearer …` — it does **not** build a signed JWT. The key is
  never written to logs or placed in a URL.
- `SettingsForm::submitForm()` also calls `->set('model', …)`, but the form defines no
  `model` element, so that value is effectively unset — a harmless no-op; model choice is
  driven by `getConfiguredModels()` / the AI module's operation config.
