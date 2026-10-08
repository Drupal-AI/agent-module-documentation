# extend — events & alter hooks

AI Automators is observed/altered mainly through **Symfony events** (documented in
`ai_automators.api.php`) plus two **alter hooks**. Subscribe with a normal
`EventSubscriberInterface`; each event class exposes its name as `EVENT_NAME`.

## Events (`src/Event/`)
| Event class | `EVENT_NAME` | Use it to |
|---|---|---|
| `ShouldProcessFieldEvent` | `ai_automator.should_process_field` | Override the process/skip decision after `checkIfEmpty()`/`postCheckIfEmpty()` normalization — call `setShouldProcess(TRUE/FALSE)`. |
| `ProcessFieldEvent` | `ai_automator.process_field` | Hook into a field being processed. |
| `ValuesChangeEvent` | `ai_automator.change_value` | Inspect/alter the generated values before they are written to the field. |
| `AutomatorConfigEvent` | `ai_automator.automator_config` | React to / adjust an automator's config as it is used. |
| `RuleIsAllowedEvent` | `ai_automator.rule_is_allowed` | Allow/deny a rule from running in a given context. |
| `VerboseInformationEvent` | `ai_automator.verbose_information` | Add verbose debug output during a run. |

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\ai_automators\Event\ShouldProcessFieldEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

final class MyAutomatorSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [ShouldProcessFieldEvent::EVENT_NAME => 'onShouldProcess'];
  }

  public function onShouldProcess(ShouldProcessFieldEvent $event): void {
    if ($event->getEntity()->bundle() === 'article') {
      $event->setShouldProcess(TRUE);
    }
  }

}
```

Non-`RuleBase` rules can implement `AiAutomatorPostCheckIfEmptyInterface` (return `[]` to force
the value to be treated as empty) to influence the should-process decision before the event
fires; `RuleBase` rules override `postCheckIfEmpty()` for the same effect.

## Alter hooks
| Hook | Alters |
|---|---|
| `hook_ai_automator_type_alter(&$definitions)` | the discovered `AiAutomatorType` (rule) plugin definitions |
| `hook_ai_automator_process_alter(&$definitions)` | the discovered `AiAutomatorProcessRule` (worker type) plugin definitions |

To add a whole new rule or worker type, write a plugin instead — see
[../plugins/ai_automators.md](../plugins/ai_automators.md).
