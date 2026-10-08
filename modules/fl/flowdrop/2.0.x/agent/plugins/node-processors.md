<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node processors — the `FlowDropNodeProcessor` plugin type

The executable behaviour behind every node is a **`FlowDropNodeProcessor`** plugin.

- Discovery: attribute `Drupal\flowdrop\Attribute\FlowDropNodeProcessor` (`@api`, TARGET_CLASS).
- Manager: `flowdrop.node_processor_plugin_manager`
  (`Drupal\flowdrop\Service\FlowDropNodeProcessorPluginManager`, namespaced under
  `Plugin/FlowDropNodeProcessor`).
- Base class: `AbstractFlowDropNodeProcessor`. Parameters are declared by the plugin's
  `getParameterSchema()` (a FlowDropSchema fragment), not in the attribute; category/tags/visual
  type live on the `flowdrop_node_type` config entity, not the plugin.
- A `flowdrop_node_type` config entity binds a processor plugin to preset config and palette
  metadata, so a site builder can create several configured variants of one processor.

## Capability interfaces (in base module `src/Plugin/FlowDropNodeProcessor/`)

A processor opts into behaviours by implementing marker/capability interfaces:

- `FlowDropNodeProcessorInterface` — base contract; `NodeExecutorInterface` — executes.
- `StartNodeProcessorInterface`, `TerminalNodeProcessorInterface`, `TriggerNodeProcessorInterface`
  — graph role (entry / exit / trigger).
- `BranchingNodeProcessorInterface` — gateway that activates a subset of outgoing edges.
- `NonExecutableNodeProcessorInterface` — decorative/structural (e.g. Note).
- `ResumableNodeProcessorInterface`, `CancellableNodeProcessorInterface` — long-running /
  interruptible execution (pairs with interrupts and StateGraph checkpoints).
- `ExecutionContextAwareInterface` — receives an `ExecutionContextDTO`.
- `HasSideEffectsInterface` — declares the node mutates external state (drives confirmation policy).
- `ToolsAwareInterface` / `ToolsAwareTrait`, `ToolPassthroughInterface` — tool-calling nodes
  (bind a `ToolCollection`, invoke tools with an at-most-once ledger).
- `ConfigEditProviderInterface` — supplies a richer config-edit surface (dynamic schema endpoints).
- `DynamicPortTrait` — ports computed from config rather than static.

Supporting exceptions: `NodeProcessingException`, `RetryableNodeProcessingException`
(`RetryableExceptionInterface`), `WorkflowStopException`, `InvalidNodeConfigurationException`,
`EntityProcessingException`, plus `RefusalCodeInterface`.

## Built-in nodes (`flowdrop_node_processor` submodule)

40+ processors ship here (the project advertises "65+ nodes" counting AI-provider and companion
modules). By area:

- **Input / output / chat:** `TextInput`, `ChatInput`, `ChatOutput`, `TextOutput`, `Messenger`,
  `Logger`, `Note`, `Nop`.
- **Data transform:** `DataMapper`, `DataShaper`, `DataOperations`, `DataExtractor`,
  `DataToJson`, `JsonToData`, `DataToDataframe`, `DataframeOperations`, `MergeNode`, `Range`.
- **Text / markdown:** `TextProcessor`, `TextReplace`, `SplitText`, `RegexExtractor`,
  `MarkdownExtractor`, `MarkdownToHtml`, `HtmlToMarkdown`, `PromptTemplate`, `MessageAssemble`,
  `MessageFromText`, `MessageToData`, `ConversationNormalize`.
- **Control flow / gateways / loops:** `IfElse`, `AorB`, `BooleanGateway`, `SwitchGateway`,
  `Repeat`, `Stop`, `Calculator`, `DateTime`.
- **Entity / Drupal:** `EntityQuery`, `EntitySave`, `EntityContext`, `GetWorkflowData`.
- **HTTP:** `HttpRequest` — makes an outbound request to a workflow-supplied URL. **SSRF-guarded**
  via `OutboundUrlSafetyTrait`: http/https only, rejects private/reserved resolved IPs, pins the
  request to the validated IP (`CURLOPT_RESOLVE`, defeating DNS rebinding), and re-validates every
  redirect hop. An `allow_internal_requests` param can opt into internal targets (workflow-author
  gated).
- **AI / tools:** `Reason` (LLM reasoning via `flowdrop.chat_reasoner`; null until a provider is
  installed), `Idea`, `ToolBox`, `ToolCaller`, `ToolInvoke` (tool calling with the execution
  ledger for at-most-once semantics).

## Expression evaluation inside nodes

Nodes resolve dynamic values through `ExpressionEvaluator` plugins (base module):
`ExpressionLanguageEvaluator` (Symfony ExpressionLanguage), `PropertyPathEvaluator` (symfony
property-access / JSONPath), and `TwigEvaluator` (renders an author-supplied Twig template).
Authoring these expressions requires the **restrict-access** workflow-edit permission — an
intended admin-gated capability, not an open surface.
