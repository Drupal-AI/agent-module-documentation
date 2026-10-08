<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA side: event, action, service, subscriber

The ECA half that computes the verdict for the [core Condition plugin](../plugins/condition.md).
All of it hangs off one event, `ConditionEvent`.

## Event class `Events\ConditionEvent`

`src/Events/ConditionEvent.php` — `extends \Drupal\Component\EventDispatcher\Event implements
TokenReceiverInterface` (uses `TokenReceiverTrait`).

- `const CONDITION_EVENT = 'eca_condition.condition_event'` — the dispatched event name.
- `__construct(string $condition_id, array $arguments = [])`; `getConditionId()` returns the ID.
- `setResult(bool)` / `getResult(): bool` — the verdict. **Defaults to `FALSE`** (`$result = FALSE`),
  so if no action sets it, the condition line is FALSE.

## ECA Event plugin `Plugin/ECA/Event/ECAConditionEvent`

`extends EventBase`, `@EcaEvent(id = "eca_condition", deriver = ECAConditionEventDeriver)`.
`definitions()` declares one derivative:

- key `condition_event` → label **"ECA Condition"**, `event_name = ConditionEvent::CONDITION_EVENT`,
  `event_class = ConditionEvent::class`, `tags = Tag::RUNTIME`.

Full ECA plugin id: **`eca_condition:condition_event`**. `buildConfigurationForm()` shows the help
markup *"This event provides tokens: [condition_id]."*. `defaultConfiguration()` adds a
`condition_id => ''` key when the event class matches. `ECAConditionEventDeriver` (extends
`EventDeriverBase`) just returns `ECAConditionEvent::definitions()`.

## ECA Action plugin `Plugin/Action/SetConditionResultAction`

`extends ConfigurableActionBase`, `@Action(id = "eca_condition_result", label = "ECA Condition: set
result")`. `execute()` gets the current event; if it is a `ConditionEvent` it calls
`$event->setResult($this->configuration['value'])`. The config form (`buildConfigurationForm`) is a
`select` "Condition result" with options `0 => False`, `1 => True` (default `''`). This is how a
model returns TRUE/FALSE to the waiting core condition.

## Service `eca_condition.hook_handler` (`Service\HookHandler`)

`extends BaseHookHandler`, constructed with `@eca.trigger_event`. Method:

```php
condition(string $condition_id, array $arguments = []): bool
```

Calls `$this->triggerEvent->dispatchFromPlugin('eca_condition:condition_event', $condition_id,
$arguments)`; returns `$event->getResult()` (FALSE if the dispatch yields no event). Reached from the
core plugin via the `.module` helper `_eca_condition_hook_handler()`.

## Event subscriber `eca_condition.subscriber`

`EventSubscriber\EcaExecutionEventSubscriber extends EcaExecutionSubscriberBase` (service `parent:
eca.execution.subscriber_parent`). On `EcaEvents::BEFORE_INITIAL_EXECUTION`, if the wrapped event is a
`ConditionEvent`, it calls `$this->tokenService->addTokenData('condition_id',
$event->getConditionId())` — this is what exposes the **`[condition_id]`** token to the model.

## Token

- `[condition_id]` — the condition ID currently being evaluated. Use it in the model to branch when
  one plugin instance lists several IDs.
