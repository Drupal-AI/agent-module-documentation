# Agent lifecycle events

ai_agents dispatches events (in `src/Event/`) around every agent run — subscribe to
observe, log, or influence a run. No `*.api.php` hooks are provided; use events.

| Event | Fires |
|---|---|
| `AgentRequestEvent` | before a request is sent to the model |
| `AgentResponseEvent` | after the model responds |
| `AgentStartedExecutionEvent` / `AgentFinishedExecutionEvent` | around the overall agent run |
| `AgentTool*Event` (start/finish) | around each tool call |
| `BuildSystemPromptEvent` | while assembling the system prompt (alter it) |

```php
// mymodule.services.yml: tag an event subscriber
// services:
//   mymodule.agent_events:
//     class: Drupal\mymodule\EventSubscriber\AgentEvents
//     tags: [{ name: event_subscriber }]

public static function getSubscribedEvents(): array {
  return [\Drupal\ai_agents\Event\BuildSystemPromptEvent::class => 'onBuildPrompt'];
}
```

Live run status is also exposed via `ai_agents.agent_status_poller` (+ private tempstore) —
used by the Explorer submodule to poll a running agent. Check exact event class names in
`web/modules/contrib/ai_agents/src/Event/` before subscribing.
