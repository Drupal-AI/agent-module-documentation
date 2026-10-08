<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `yandex` AI provider plugin

`src/Plugin/AiProvider/YandexProvider.php` — `#[AiProvider(id: 'yandex', label: 'Yandex')]`, extends
`Drupal\ai\Base\OpenAiBasedProviderClientBase` and uses `ChatTrait`. The class is small (~60 lines):
almost all HTTP/client behaviour is inherited.

## Models (`getConfiguredModels()`)

| Model id | Label |
|---|---|
| `yandexgpt-lite/latest` | YandexGPT Lite (Latest 5) |
| `yandexgpt-lite/rc` | YandexGPT Lite (RC 5) |
| `yandexgpt/latest` | YandexGPT Pro (Latest 5) |
| `yandexgpt/rc` | YandexGPT Pro (RC 5.1) |

`getSupportedOperationTypes()` returns `['chat']`. `getModelSettings()` passes general config through
unchanged.

## Usability

`isUsable()` returns false unless a key is available (`$this->apiKey` already set **or**
`ai_provider_yandex.settings:api_key` configured), and — when an operation type is given — that it is
`chat`.

## `chat()` — endpoint + model-id rewrite

```php
public function chat(array|string|ChatInput $input, string $model_id, array $tags = []): ChatOutput {
  $this->setEndpoint('https://llm.api.cloud.yandex.net/v1');
  $catalog_id = $this->getConfig()->get('catalog_id');
  $model_id = "gpt://$catalog_id/$model_id";
  return parent::chat($input, $model_id, $tags);
}
```

The endpoint is hard-coded (not admin-settable). The model id is rewritten to Yandex's
`gpt://<catalog_id>/<model>` URI form, then the call is delegated to
`OpenAiBasedProviderClientBase::chat()`, which builds the OpenAI client via
`\OpenAI::factory()->withBaseUri(...)->withHttpClient($this->httpClient)->make()` (the injected Drupal
`http_client`), attaches the Bearer key resolved from the Key entity, and maps the response into a
`ChatOutput`.

## Inherited from `OpenAiBasedProviderClientBase`

`getClient()`, `loadClient()`/`createClient()`, `getHttpClient()`/`setHttpClient()`, `loadApiKey()`
(Key repository lookup) and the standard chat/embeddings mapping. This module overrides only the model
list, supported operations, model settings, usability and the `chat()` endpoint/model wiring above.
