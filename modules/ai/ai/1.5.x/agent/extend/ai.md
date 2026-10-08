# extend — events & guardrails (there is no hook_ API)

AI Core does **not** ship an `ai.api.php`; you observe and alter requests through Symfony
events (`src/Event/`) and guardrails, not classic Drupal hooks.

## Events

Subscribe in a normal `EventSubscriber` service.

| Event class | When | What you can do |
|---|---|---|
| `PreGenerateResponseEvent` | before the provider is called | inspect/alter the outgoing request (input, model, config, tags) |
| `PostGenerateResponseEvent` | after a (non-streamed) response | inspect/alter the response before the caller sees it |
| `PostStreamingResponseEvent` | after a streamed response completes | act on the fully assembled streamed output |
| `AiProviderRequestBaseEvent` / `AiProviderResponseBaseEvent` | base classes | shared accessors for the above |
| `AiExceptionEvent` | a provider call threw | handle/translate provider errors centrally |
| `ProviderDisabledEvent` | a provider is disabled | react to provider availability changes |

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\ai\Event\PreGenerateResponseEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class TagInjector implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [PreGenerateResponseEvent::EVENT_NAME => 'onPre'];
  }
  public function onPre(PreGenerateResponseEvent $event): void {
    // e.g. add a tag, tweak configuration, enforce a policy.
  }
}
```

(Confirm the exact event-name constant / dispatched string on each class in `src/Event/`;
subscribe to that constant rather than a hard-coded string.)

## Guardrails (declarative alternative to writing a subscriber)

For policy that should apply to requests without custom code, use guardrails instead of
events: create `ai_guardrail` entities, collect them into an `ai_guardrail_set`, and either
attach the set to a specific flow or list it under `ai.settings:global_guardrails` to apply
site-wide. Guardrails are `AiGuardrail` plugins (see [plugins/ai.md](../plugins/ai.md)); the
built-in `RestrictToTopic` is a working example. The `GuardrailsEventSubscriber` /
`GlobalGuardrailsEventSubscriber` services wire them onto the request lifecycle for you.

## Adding a whole new vendor

Implement an `AiProvider` plugin (see [plugins/ai.md](../plugins/ai.md)); extend the base
client (`src/Base/OpenAiBasedProviderClientBase.php`) if the vendor speaks an OpenAI-shaped
API. No event or hook is needed — just declare which operation-type interfaces you implement.
