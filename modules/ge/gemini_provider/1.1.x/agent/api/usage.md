<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Programmatic use

You normally use Gemini **through the AI module's abstraction**, not this module directly.

## Get the provider and run chat / embeddings

```php
/** @var \Drupal\ai\AiProviderPluginManager $manager */
$manager = \Drupal::service('ai.provider');
$gemini = $manager->createInstance('gemini');

// Chat.
$output = $gemini->chat('Introduce yourself!', 'models/gemini-3.8-flash');
$text = $output->getNormalized()->getText();

// Embeddings (text, or text + image on gemini-embedding-2).
$vector = $gemini->embeddings('Some text', 'models/gemini-embedding-2')
  ->getNormalized();
```

Prefer letting the AI module pick the provider/model for an operation type (defaults set in the
AI settings) rather than hard-coding `gemini` — that is the point of the abstraction.

## Per-request tuning

- `setConfiguration([...])` — set generation params (`temperature`, `topP`, `topK`,
  `maxOutputTokens`, `stopSequences`, …). Note `stopSequences` is normalized from a
  comma-separated string to an array, and `responseSchema`/`responseMimeType` are pulled out
  and applied via `ChatInput` in `chat()`.
- `setChatSystemRole($message)` — set a system message (parsed as a Gemini `model` role).
- `setAuthentication($apiKey)` / `getClient($apiKey)` — hot-swap the API key for a call.

## Handy inspection methods (no API call)

- `getSupportedOperationTypes()`, `getSupportedCapabilities()`, `getSetupData()`,
  `getApiDefinition()` (reads `definitions/api_defaults.yml`), `embeddingsVectorSize($model)`,
  `maxEmbeddingsInput($model)`, `getConfig()` (the `gemini_provider.settings` immutable config).

`getConfiguredModels()` and any `chat()/embeddings()/textToImage()/textToSpeech()/speechToText()`
call DO hit the Gemini API and require a valid key; the inspection methods above do not.
Multimodal embeddings require `gemini-embedding-2` — passing an image to any other embedding
model raises `AiResponseErrorException`.
