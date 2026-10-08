<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bedrock` AI provider plugin

`\Drupal\ai_provider_aws_bedrock\Plugin\AiProvider\BedrockProvider`, declared with
`#[AiProvider(id: 'bedrock', label: 'AWS Bedrock')]`, extends `ai`'s `AiProviderClientBase` and
implements `ChatInterface`, `EmbeddingsInterface`, `TextToImageInterface`. It is consumed through
the `ai` module's provider system (`ai.provider` plugin manager) — you normally reach it via the AI
module, not directly. This module defines no plugin *type* of its own.

## Supported operations

`getSupportedOperationTypes()` → `['chat', 'embeddings', 'text_to_image']`. `isUsable()` returns
FALSE unless `profile` config is set, then checks the requested operation type against that list.

| Method | Purpose |
|--------|---------|
| `chat($input, $model_id, $tags)` | Calls Bedrock `converse` (or `converseStream` when streamed). Maps `ChatInput` messages, images, tool-use/tool-result and system prompt to the AWS Converse shape; returns `ChatOutput`. Streaming yields via `BedrockChatMessageIterator`. |
| `embeddings($input, $model_id, $tags)` | Calls `invokeModel`; body built by the Titan/Cohere embeddings handler; returns `EmbeddingsOutput`. `maxEmbeddingsInput()` is hardcoded to `1024`. |
| `textToImage($input, $model_id, $tags)` | Calls `invokeModel`; body/output handled by the Stable Diffusion / Titan Image handler; returns `TextToImageOutput` (`ImageFile[]`). |
| `getConfiguredModels($operation_type, $capabilities)` | Loads the client, returns filtered model list. |
| `getModelSettings($model_id, $generalConfig)` | Returns per-model config form definitions (delegates to the matching `Models\**` handler by id prefix). |
| `getApiDefinition()` | Parses `definitions/api_defaults.yml`. |
| `getConfig()` | Immutable `ai_provider_aws_bedrock.settings`. |
| `setAuthentication($profile)` | Sets the active profile id and resets the cached clients. |
| `enableModeration()` / `disableModeration()` | Toggle the pre-request moderation flag at runtime. |

## Raw SDK access for integrators

```php
/** @var \Drupal\ai_provider_aws_bedrock\Plugin\AiProvider\BedrockProvider $p */
$p = \Drupal::service('ai.provider')->createInstance('bedrock');

$runtime = $p->getClient();          // Aws\BedrockRuntime\BedrockRuntimeClient
$models  = $p->getModelClient();     // Aws\Bedrock\BedrockClient (control-plane)
// Optional: hot-swap the AWS profile for this call only.
$runtime = $p->getClient('other_profile_id');
```

Both accept an optional profile id; passing one calls `setAuthentication()` first. Internally
`loadClient()` builds the clients from `aws.client_factory`
(`$clientFactory->setProfile($profile_entity)->getClient('bedrock' | 'bedrockruntime')`), loading the
`aws_profile` entity named by config. TLS/transport is handled entirely by `aws/aws-sdk-php` with
its defaults; this module passes no client transport overrides.

## Model discovery, capabilities and manual models

`getModels($operation_type, $capabilities)` calls `listFoundationModels(['byOutputModality' => …])`
(`TEXT` for chat, `EMBEDDING` for embeddings, `IMAGE` for text_to_image), keeps only `ACTIVE`
models, drops non-`ON_DEMAND` models when the `on_demand` setting is on, and applies per-family
capability filters. Any `listFoundationModels` exception is swallowed (empty/manual list returned).
Newline-separated ids from the matching `*_manual_models` config are always appended. Results are
`asort`ed and cached permanently under cache key `bedrock_models_<op>_<hash>` with tag
`aws_bedrock_models`.

## Model family handlers (`src/Models/**`)

Static handler classes, dispatched by `$model_id` prefix, each exposing some of
`providerConfig()` (adds config-form fields), `providerCapabilities()` (capability gate),
`formatInput()`, `formatOutput()`:

| Prefix | Handler | Operation |
|--------|---------|-----------|
| `ai21` | `Models\Chat\Ai21Chat` | chat |
| `cohere.command` | `Models\Chat\CohereChat` | chat |
| `anthropic` (`claude-3` gates vision/JSON) | `Models\Chat\AnthropicChat` | chat |
| `meta.llama` | `Models\Chat\MetaChat` | chat |
| `mistral.mistral` / `mistral.mixtral` | `Models\Chat\MistralChat` | chat |
| `amazon.titan-text` / `amazon.titan-tg1` | `Models\Chat\TitanChat` | chat |
| `amazon.titan-embed` | `Models\Embeddings\TitanEmbeddings` | embeddings (text + image) |
| `cohere.embed` | `Models\Embeddings\CohereEmbeddings` | embeddings |
| `stability.stable-diffusion-xl` | `Models\TextToImage\StableDiffusion` | text_to_image |
| `amazon.titan-image-generator-v1` | `Models\TextToImage\TitanImage` | text_to_image |

To support a model AWS won't list for the current IAM role, add its id to the matching
`*_manual_models` setting (see [configure/settings.md](../configure/settings.md)); it is routed to a
handler by the same id-prefix match, so a new model in an existing family works without code.
`BedrockJsonSerializeDecorator` wraps the raw `Aws\Result` so `ChatOutput` can serialize it.
