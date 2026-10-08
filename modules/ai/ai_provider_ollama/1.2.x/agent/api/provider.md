<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The provider plugin and control API

## Calling it through the AI module

```php
/** @var \Drupal\ai\AiProviderPluginManager $manager */
$manager  = \Drupal::service('ai.provider');
$provider = $manager->createInstance('ollama');

// Chat
$messages = new \Drupal\ai\OperationType\Chat\ChatInput([
  new \Drupal\ai\OperationType\Chat\ChatMessage('system', 'You are terse.'),
  new \Drupal\ai\OperationType\Chat\ChatMessage('user', 'Summarise Drupal in one line.'),
]);
$output = $provider->chat($messages, 'llama3_latest', ['my_module']);
$text   = $output->getNormalized()->getText();

// Embeddings
$vector = $provider->embeddings('some text', 'nomic_embed_text')->getNormalized();
$size   = $provider->embeddingsVectorSize('nomic_embed_text');
$max    = $provider->maxEmbeddingsInput('nomic_embed_text');

// Moderation (see the model constraint below)
$verdict = $provider->moderation('is this abusive?', 'llama_guard3')->getNormalized();
```

Model ids are the **machine names** produced by `getMachineName()` — transliterated, lowercased,
non-`[a-z0-9_]` replaced with `_`. So the Ollama model `llama3:latest` becomes `llama3_latest`.
`getModel()` maps that machine name back to the real model name using the cached list in state
(falling back to the string you passed).

## Operation types

`getSupportedOperationTypes()` → `['chat', 'embeddings', 'moderation']`.
`isUsable($operation_type)` simply checks membership in that list, so a provider instance reports
as usable even when the Ollama host is unreachable — check `getConfiguredModels()` if you need a
real health signal.

`getModelSettings($model_id, $generalConfig)` returns `$generalConfig` unchanged: there are no
per-model overrides, everything comes from the AI module's general configuration merged into the
payload.

## Chat / embeddings transport

`OllamaProvider extends OpenAiBasedProviderClientBase` — chat and embeddings ride the AI module's
OpenAI-compatible client pointed at your Ollama host, so the payload shape is OpenAI's
(`model`, `messages`, plus the tunables from `definitions/api_defaults.yml`).

`definitions/api_defaults.yml` declares, for `chat`: `max_tokens` (int, default 1024),
`temperature` (float, default 1, min 0 / max 2 / step 0.1), `frequency_penalty` and
`presence_penalty` (min −2 / max 2), among others. These are what the AI module renders as
configuration in its UIs and passes through.

## Moderation is model-specific

```php
$payload  = ['model' => $model_id, 'messages' => $chat_input] + $this->configuration;
$response = $this->client->chat()->create($payload)->toArray();
$message  = $response['choices'][0]['message']['content'];   // throws if absent

switch (explode(':', $model_id)[0]) {
  case 'llama-guard3': return LlamaGuard3::moderationRules($message);
  case 'shieldgemma':  return ShieldGemma::moderationRules($message);
  default: throw new AiRequestErrorException('Model not supported for moderation.');
}
```

So moderation is *chat plus a parser*: the two classes in `src/Models/Moderation/` turn the
model's free-text answer into a `ModerationResponse`. To support another guard model you must
patch this switch — there is no plugin/hook seam for it. Note the match is against the model id
**before the colon**, i.e. the real Ollama name (`llama-guard3:8b`), not the machine name.

## `OllamaControlApi` (service `ai_provider_ollama.control_api`)

Direct wrapper over Ollama's native REST API using `http_client`; get it from the provider with
`getControlClient()` or from the container.

| Method | Endpoint | Purpose |
|---|---|---|
| `setConnectData($baseUrl)` | — | Sets the base host used by all calls |
| `getModels()` | `GET api/tags` | Installed models |
| `embeddings($text, $model)` | `POST api/embeddings` | Raw embedding call |
| `embeddingsVectorSize($model)` | `POST api/show` | Vector dimensions |
| `embeddingsContextSize($model)` | `POST api/show` | Context window |
| `chat(array $payload)` | `POST api/chat` | Native (non-OpenAI-shaped) chat |

```php
$api = \Drupal::service('ai_provider_ollama.control_api');
$api->setConnectData('http://host.docker.internal:11434');
$models = $api->getModels();
```

`makeRequest()` builds `rtrim($baseHost, '/') . '/' . $path`, JSON-encodes the body, sets
`Content-Type: application/json`, and applies the 5 s / 120 s timeout split described in
[../configure/setup.md](../configure/setup.md). Responses are returned as the raw Guzzle body —
`Json::decode()` it yourself when calling the service directly.

## Authentication

```php
public function hasAuthentication(): bool { return FALSE; }
public function setAuthentication(mixed $authentication): void { $this->client = NULL; }
```

There is no API key concept. Anything that can reach `host_name:port` can use the models. Treat
the network boundary as the control.
