# api — calling AI operations from code

The entry point is the `ai.provider` plugin manager service
(`Drupal\ai\AiProviderPluginManager`). Never instantiate a vendor SDK directly — go
through a provider so vendor choice stays config-driven.

## The pattern (chat)

```php
/** @var \Drupal\ai\AiProviderPluginManager $manager */
$manager = \Drupal::service('ai.provider');

// 1. Resolve the site's default provider + model for an operation type.
//    Returns NULL if no default is configured for that operation.
$defaults = $manager->getDefaultProviderForOperationType('chat');
if (!$defaults) {
  // No provider set — tell the user to configure one at /admin/config/ai/settings.
  return;
}

// 2. Instantiate that provider plugin.
/** @var \Drupal\ai\OperationType\Chat\ChatInterface $provider */
$provider = $manager->createInstance($defaults['provider_id']);

// 3. Build a typed input: an array of ChatMessage(role, text).
use Drupal\ai\OperationType\Chat\ChatInput;
use Drupal\ai\OperationType\Chat\ChatMessage;

$input = new ChatInput([
  new ChatMessage('system', 'You are a terse assistant.'),
  new ChatMessage('user', 'Name three primary colors.'),
]);

// 4. Call the operation. Third arg is tags (for logging/filtering).
$output = $provider->chat($input, $defaults['model_id'], ['my_module']);

// 5. Read the normalized response (a ChatMessage).
$text = $output->getNormalized()->getText();
```

`getDefaultProviderForOperationType($operation_type)` returns
`['provider_id' => string, 'model_id' => string]` or `NULL`.
There is also `getSetProvider($operation_type, $preferred_model = NULL)` which returns
`['provider_id' => ProviderProxy, 'model_id' => string]` — note the `provider_id` here is
the **instantiated** provider, and `$preferred_model` accepts a combined
`"provider__model"` simple-option string.

## Operation types (interface + input/output live under `src/OperationType/<Name>/`)

Each provider declares which of these it supports. Call the matching method on the provider:

| Operation type id | Method | Input → Output |
|---|---|---|
| `chat` | `chat($input, $model_id, $tags)` | `ChatInput` → `ChatOutput` (`->getNormalized()` = `ChatMessage`) |
| `embeddings` | `embeddings($input, $model_id, $tags)` | `EmbeddingsInput`/string → `EmbeddingsOutput`; `embeddingsVectorSize($model_id)` gives the dimension |
| `text_to_image` | `textToImage(...)` | prompt → image output (persist as `ai_file`) |
| `text_to_speech` / `speech_to_text` | `textToSpeech(...)` / `speechToText(...)` | text↔audio |
| `moderation` | `moderation(...)` | text → flags |
| `translate_text` | `translateText(...)` | text → translated text |
| `summarization` | `summarize(...)` | text → summary |
| others | | `image_classification`, `object_detection`, `rerank`, `text_classification`, `image_to_image`, `image_to_video`, `audio_to_audio`, `speech_to_speech`, `image_and_audio_to_video`, `generic_type` |

Signatures (from the interfaces):
- `chat(array|string|ChatInput $input, string $model_id, array $tags = []): ChatOutput`
- `embeddings(string|EmbeddingsInput $input, string $model_id, array $tags = []): EmbeddingsOutput`

## Streaming chat

`ChatOutput::getNormalized()` may return a `StreamedChatMessageIterator` when streaming is
enabled — iterate it to receive `StreamedChatMessage` chunks as they arrive (see
`src/OperationType/Chat/StreamedChatMessageIteratorInterface.php`).

## Other useful services

| Service | Class | Use |
|---|---|---|
| `ai.provider` | `AiProviderPluginManager` | resolve/instantiate providers (above) |
| `ai.tokenizer` | `Utility\Tokenizer` | count tokens (tiktoken) before a call |
| `ai.text_chunker` | `Utility\TextChunker` | split long text into model-sized chunks |
| `ai.prompt_manager` | `Service\AiPromptManager` | load/render reusable `ai_prompt` entities |
| `ai.vdb_provider` | `AiVdbProviderPluginManager` | resolve a vector-database provider |
| `ai.prompt_json_decode` | `Service\PromptJsonDecoder\PromptJsonDecoder` | robustly decode JSON the LLM returned |

## Function calling (tools)

To let the model call Drupal logic, implement `FunctionCall` plugins (see
[plugins/ai.md](../plugins/ai.md)) and attach them to the `ChatInput` via its tools API,
then loop: send → if the response requests a tool call, execute it and send the result back.
