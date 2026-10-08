<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Programmatic API: pulling context

`Service\AiContextRequestFactory` (service **`ai_context.request_factory`**, interface
`AiContextRequestFactoryInterface`) is the canonical entry point. It builds an `AiContextRequest`,
hands it to `Service\AiContextSelector` (`ai_context.selector`), and returns an `AiContextResult`.
The selector itself is agent-agnostic; the factory adds agent/consumer config.

## One-call convenience (non-agent code)

```php
$factory = \Drupal::service('ai_context.request_factory');

// Rendered text ready to drop into a prompt.
$text = $factory->getRenderedContext(
  scopes: ['use_case' => ['working_with_text'], 'tag' => ['5', '7']],
  maxTokens: 2000,
  currentEntity: $node,      // optional, for contextual scope matching
  consumerId: 'my_module',   // optional, for logging
);

// Full result: ids, token usage, cache metadata.
$result = $factory->getResult(['language' => ['en']], 1500, $node, 'my_module');
$ids   = $result->getSelectedItemIds();
$used  = $result->getTokensUsed();
```

`getRenderedContext()`/`getResult()` always use `SELECTION_MODE_MATCH_ALL`. Passing an empty
`$scopes` with no active subscriptions triggers a full-catalogue O(n) scan — pass explicit scopes
on large catalogues.

## Building a request yourself

- `fromAgent(string $agentId, string $task, ?string $entityType = NULL, string|int|null $entityId = NULL): AiContextRequest`
  — merges the agent's saved config (`ai_context.agents`).
- `fromParameters(AiContextRequestParamsData $params): AiContextRequest` — from a typed DTO;
  if it carries `agentId`, the agent config is merged and param-level scope keys override same-named
  agent keys.
- `findAgentConfig(string $agentId): array`, `isLoopAware(string $agentId): bool`,
  `isInjectionAllowed(string $agentId): bool`.

Then `\Drupal::service('ai_context.selector')->select($request)` returns the `AiContextResult`.

## AiContextResult

`getRenderedText()`, `getSelectedItems(bool $fullData = FALSE)`, `getSelectedItemIds()`,
`getTokensUsed()`, `getMaxTokens()`, `getTruncatedItems()`, `getCacheableMetadata()` (plus
`getCacheContexts()/getCacheTags()/getCacheMaxAge()`). Attach the cache metadata to any render
array that embeds the text.

## Supporting services

| Service id | Class | Role |
|---|---|---|
| `ai_context.selector` | `AiContextSelector` | Selects + renders; dispatches selection events. |
| `ai_context.scope_resolver` | `AiContextScopeResolver` | Scope prefilter/match/score (`filterByScope`, `scoreAndSort`, `matchesCurrentContext`). |
| `ai_context.renderer` | `AiContextRenderer` | Token-limited block rendering of published items. |
| `ai_context.subcontext_resolver` | `AiContextSubcontextResolver` | Resolves required/conditional children (LLM-driven for conditional). |
| `ai_context.token_estimator` | `AiContextTokenEstimator` | Tokenizer via `ai.tokenizer` + provider config. |
| `ai_context.usage_tracker` | `AiContextUsageTracker` | `recordUsage()`, `attachEntity()`, `recordToolUsed()`, query helpers. Writes `ai_context_usage` when tracking is on. |
| `ai_context.current_entity_resolver` | `AiContextCurrentEntityResolver` | Resolves the "current entity" from route/request. |

For the agent-facing tool wrappers around this API, see
[function-calls.md](function-calls.md). For the prompt-injection subscriber, see
[../events/events.md](../events/events.md).
