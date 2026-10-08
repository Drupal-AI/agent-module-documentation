# Execute tools programmatically & extend the pipeline

## Instantiate and run

```php
/** @var \Drupal\tool\Tool\ToolManager $manager */
$manager = \Drupal::service('plugin.manager.tool');

$tool = $manager->createInstance('greeting_tool');     // optional 3rd arg: invoker id
$tool->setInputValue('name', 'Ada');                   // runs ToolInputTransformEvent
$tool->setInputValue('greeting', 'Hi');

if ($tool->access()) {                                  // delegates to the tool's checkAccess()
  $tool->execute();
  $ok      = $tool->getResultStatus();                  // bool
  $message = $tool->getResultMessage();                 // TranslatableMarkup
  $outputs = $tool->getOutputValues();                  // ['message' => 'Hi, Ada!']
}
```

`ToolManager::createInstance($id, $configuration = [], ?string $invoker = NULL)` sets the invoker on
the instance when provided. `getDefinitions()` returns `ToolDefinition` objects (label, description,
`getOperation()`, `isDestructive()`, input/output definitions, `getProvider()`).

## Result objects

- `getResult(): ExecutableResult` — raw success/failure + message + context values. Throws
  `BadMethodCallException` if `execute()` hasn't run; use `hasResult()` / `hasExecuted()` to guard
  (they differ: `setFailureResult()` records a result without executing).
- `getFormattedResult(): FormattedExecutableResult` — runs `ToolOutputTransformEvent` per output
  (e.g. entity → handle downcast), memoized per execution; carries transformed values + "hints".
- `setFailureResult(TranslatableMarkup)` — record a failure before execution (for callers that read
  the result unconditionally).

## Invokers

An **invoker** is a string identifying the calling context (AI agent, MCP server, deterministic
caller). Set via `createInstance(..., $invoker)` or `$tool->setInvoker($id)`. It is carried on the
input/output transform events so subscribers can apply per-caller transformations. Example id:
`ToolAiConnectorInvoker::ID` (`'tool_ai_connector'`).

## Events (subscribe to transform inputs/outputs/definitions)

| Event class | Fires | Use |
|---|---|---|
| `Event\ToolInputTransformEvent` | on every `setInputValue()` | rewrite an incoming value (e.g. resolve a handle string → entity) based on name/invoker/definition. |
| `Event\ToolOutputTransformEvent` | in `getFormattedResult()` per output | rewrite an output value + attach hint messages (e.g. entity → handle). |
| `Event\ToolInputDefinitionNormalizeEvent` | when serializing input definitions | rewrite how a definition is advertised (e.g. entity input described as a handle string). |
| `Event\ToolOutputDefinitionNormalizeEvent` | when serializing output definitions | same, for outputs. |

Core subscribers: `RecursiveToolValueTransformSubscriber` (recurses into list/map values),
`InputTypeCoercionSubscriber` (coerces scalars to declared types).

## Entity handle store

Service `tool.handle_store` (`ToolHandleStore`, backed by `tempstore.private` + `uuid`) and
`tool.entity_handle_transformer` (`EntityHandleTransformer`) implement opaque **handles**: an entity
output is downcast to a short handle string (so a caller such as an LLM never receives raw,
possibly-unviewable entity data), which can later be passed back as an input and upcast to the
entity. Handles are per-user/session (private tempstore). The AI connector wires this via its
`ToolAiConnectorEntityHandleTransformSubscriber`.

## Serialize definitions to JSON Schema

`tool.definition_serializer` (`ToolDefinitionSerializer`) → `normalizeInputSchema($tool)` /
`normalizeInputDefinition($tool, $name, $definition)` produce JSON-Schema arrays (dispatching the
normalize events), which function-calling consumers (the AI connector) turn into provider tool specs.

## Alter discovered tools

```php
function my_module_tool_info_alter(array &$definitions): void {
  // $definitions are ToolDefinition objects keyed by plugin id.
}
```
