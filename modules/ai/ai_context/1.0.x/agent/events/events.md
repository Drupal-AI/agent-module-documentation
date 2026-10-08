<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events

## Prompt injection (subscribes to ai_agents)

`EventSubscriber\AiContextSystemPromptSubscriber` is how context reaches an agent's system prompt:

- `AgentStartedExecutionEvent` (priority 100, `onAgentStarted`) — captures the runner id and loop
  count, caches the agent's `loop_aware` flag.
- `BuildSystemPromptEvent` (`onPreSystemPrompt`) — if push injection is allowed
  (`isInjectionAllowed`), and not a suppressed loop iteration, it resolves the current entity from
  the route or event tokens, builds a request via `requestFactory->fromAgent()`, runs
  `selector->select()`, records usage, then **appends** the rendered text to the prompt wrapped as:

  ```
  <original prompt>

  <context_prefix from ai_context.settings>
  -----------------------------------------------
  - id: 12
    label: Brand voice
    purpose: …
    guidance:
        …content…
  -----------------------------------------------
  ```

Usage tracking also hooks `AgentToolFinishedExecutionEvent`
(`EventSubscriber\AiContextAgentToolSubscriber`, records tool + any created/edited entity) and the
agent-finished event (`AiContextAgentFinishedSubscriber`, flushes tools-used).

## Own events (dispatched by the selector)

Constants on `Event\AiContextSelectionEvents`; both are **mutable** — subscribe to alter selection
or output.

| Event name | Class | When | Alter with |
|---|---|---|---|
| `ai_context.selection.items_selected` | `AiContextSelectionItemsSelectedEvent` | After items are chosen/ordered, before render. | `setSelectedItems(array)`; read `getRequest()`, `getSelectedItems()`, `getCacheableMetadata()`. |
| `ai_context.selection.text_rendered` | `AiContextSelectionTextRenderedEvent` | After render. | `setRenderedText(string)`; read `getRequest()`, `getSelectedItems()`, `getRenderedText()`, `getTokensUsed()`, `getMaxTokens()`, `getTruncatedItems()`, `getCacheableMetadata()`. |

```php
use Drupal\ai_context\Event\AiContextSelectionEvents;
use Drupal\ai_context\Event\AiContextSelectionTextRenderedEvent;

final class MyContextSubscriber implements \Symfony\Component\EventDispatcher\EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [AiContextSelectionEvents::TEXT_RENDERED => 'onRendered'];
  }
  public function onRendered(AiContextSelectionTextRenderedEvent $event): void {
    $event->setRenderedText($event->getRenderedText() . "\n(Reviewed by policy bot.)");
  }
}
```

`Event\SchedulerAiContextItemEvents` defines Scheduler publish/unpublish event names for context
items when the optional `scheduler` module is present.
