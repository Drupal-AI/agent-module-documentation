# plugins — plugin types AI Core defines

All are attribute-based (attributes in `src/Attribute/`). Discover implementations with the
matching manager service; implement one by adding a class under
`src/Plugin/<Type>/` in your module with the attribute.

| Plugin type | Attribute | Namespace | Manager service | Purpose |
|---|---|---|---|---|
| AI Provider | `#[AiProvider]` | `Plugin/AiProvider` | `ai.provider` | Adapts one vendor (OpenAI, Anthropic, Ollama…) to the operation-type interfaces. This is how you add a new AI vendor to Drupal. |
| Operation Type | `#[OperationType]` | `Plugin/OperationType` | (defines the capability contracts) | Declares a capability (`chat`, `embeddings`, …) with its typed input/output. Rarely added by site code. |
| Function Call | `#[FunctionCall]` | `Plugin/AiFunctionCall` | `plugin.manager.ai.function_calls` (`Service\FunctionCalling\FunctionCallPluginManager`) | A **tool** the LLM can invoke — your Drupal logic exposed for function calling. |
| Function Group | `#[FunctionGroup]` | `Plugin/AiFunctionGroup` | `plugin.manager.ai.function_groups` (`Service\FunctionCalling\FunctionGroupPluginManager`) | Names a group of related function calls to grant/attach together. |
| VDB Provider | `#[AiVdbProvider]` | `Plugin/AiVdbProvider` | `ai.vdb_provider` | Adapts a vector database (used by AI Search) behind one interface. |
| Guardrail | `#[AiGuardrail]` | `Plugin/AiGuardrail` | `plugin.manager.ai_guardrail` (`Guardrail\AiGuardrailPluginManager`) | A policy check/transform applied to a request or response (e.g. RestrictToTopic). |
| Short-Term Memory | `#[AiShortTermMemory]` | `Plugin/AiShortTermMemory` | `plugin.manager.ai.short_term_memory` (`PluginManager\AiShortTermMemoryPluginManager`) | Conversational memory strategy for agents (e.g. summarize history). |
| Chat Memory | `#[ChatMemory]` | `Plugin/ChatMemory` | `plugin.manager.ai.chat_memory` (`PluginManager\ChatMemoryPluginManager`) | A strategy for persisting/retrieving chat history between turns (the chat-history store behind chatbots). |
| Data Type Converter | `#[AiDataTypeConverter]` | `Plugin/AiDataTypeConverter` | `plugin.manager.ai_data_type_converter` (`PluginManager\AiDataTypeConverterPluginManager`) | Convert Drupal data into formats an operation can consume. |
| Chat Processor | `#[ChatProcessor]` | `Plugin/AiChatProcessor` | `plugin.manager.ai.chat_processor` (`PluginManager\ChatProcessorPluginManager`) | Pre/post-process chat input/output in a pipeline. |

(`ChatMemory` is new in 1.5.x and is distinct from `AiShortTermMemory`: short-term memory
condenses the context sent to the model, while chat memory governs how a conversation's turns
are stored and reloaded.)

## Writing a Function Call (tool) — the common case

```php
namespace Drupal\my_module\Plugin\AiFunctionCall;

use Drupal\ai\Attribute\FunctionCall;
use Drupal\ai\Base\FunctionCallBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[FunctionCall(
  id: 'my_module:get_weather',
  function_name: 'get_weather',
  name: new TranslatableMarkup('Get weather'),
  description: new TranslatableMarkup('Returns the current weather for a city.'),
  // Declare parameters as context definitions so the LLM knows the schema.
)]
class GetWeather extends FunctionCallBase {

  public function execute() {
    $city = $this->getContextValue('city');
    // ...do work...
    $this->setOutput('Sunny, 21°C in ' . $city);
  }

}
```

Real examples in the module: `src/Plugin/AiGuardrail/RestrictToTopic.php` (a guardrail that
itself calls `->chat()`), `src/Plugin/AiShortTermMemory/AgentMemorySummarizer.php`. Look at
`FunctionCallBase` / `FunctionCallInterface` for the full tool contract.
