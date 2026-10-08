# Write an EventSubscriber for a hook event

Replace a `hook_*()` function with a Symfony event subscriber. Three parts: a subscriber
class implementing `EventSubscriberInterface`, an `event_subscriber`-tagged service, and a
`getSubscribedEvents()` map of event-name constants to methods.

## Example — react to entity insert/update instead of hooks

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\Core\Entity\FieldableEntityInterface;
use Drupal\core_event_dispatcher\EntityHookEvents;
use Drupal\core_event_dispatcher\Event\Entity\EntityInsertEvent;
use Drupal\core_event_dispatcher\Event\Entity\EntityPresaveEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyEntitySubscriber implements EventSubscriberInterface {

  public function onPresave(EntityPresaveEvent $event): void {
    $entity = $event->getEntity();            // typed getter, no untyped hook args
    if ($entity instanceof FieldableEntityInterface) {
      $entity->set('some_field', 'value');    // mutate before save
    }
  }

  public function onInsert(EntityInsertEvent $event): void {
    // react to a newly created entity
  }

  public static function getSubscribedEvents(): array {
    return [
      EntityHookEvents::ENTITY_PRE_SAVE => 'onPresave',
      EntityHookEvents::ENTITY_INSERT   => 'onInsert',
    ];
  }
}
```

Register it in `my_module.services.yml`:

```yaml
services:
  my_module.entity_subscriber:
    class: Drupal\my_module\EventSubscriber\MyEntitySubscriber
    tags:
      - { name: event_subscriber }
```

That's it — no `hook_entity_presave()` / `hook_entity_insert()` needed. The submodule
implements the real hook and dispatches your event.

## How dispatch works (why this replaces the hook)

Each submodule's `.module` implements the hook and does, e.g.:

```php
$manager = \Drupal::service('hook_event_dispatcher.manager');
$event = new ThemeEvent($existing);
$manager->register($event);       // dispatches under $event->getDispatcherType()
return $event->getNewThemes();
```

`HookEventDispatcherManager::register()` forwards the event to core's `event_dispatcher`.
The base module also decorates `module_handler`. You never call `register()` yourself — you
only subscribe.

## Event naming

- Every event name is a string constant prefixed with `hook_event_dispatcher.`
  (`HookEventDispatcherInterface::PREFIX`), e.g. `hook_event_dispatcher.entity.insert`.
- Don't hard-code the string — reference the constant on the subsystem's `*HookEvents`
  class. Constants map 1:1 to core hooks and document the source hook in `@see`.
- The event class you type-hint lives in `Drupal\<submodule>\Event\...`.

### Which `*HookEvents` class / submodule provides which hooks

| Subsystem hooks | Enable submodule | Constants class(es) |
|---|---|---|
| Entity, form, theme, block, file, menu, token, language, page, options, core (`hook_entity_*`, `hook_form_alter`, `hook_theme`, `hook_block_*`, `hook_file_*`, `hook_menu_*`, `hook_token*`, `hook_language_*`, `hook_page_*`, `hook_options_*`, `hook_cron`…) | `core_event_dispatcher` | `EntityHookEvents`, `FormHookEvents`, `ThemeHookEvents`, `BlockHookEvents`, `FileHookEvents`, `MenuHookEvents`, `TokenHookEvents`, `LanguageHookEvents`, `PageHookEvents`, `OptionsHookEvents`, `CoreHookEvents` |
| Field widget/formatter/info hooks | `field_event_dispatcher` | `FieldHookEvents` |
| Media source/info hooks | `media_event_dispatcher` | `MediaHookEvents` |
| Path / alias hooks | `path_event_dispatcher` | `PathHookEvents` |
| `template_preprocess_*` / `hook_preprocess_HOOK` | `preprocess_event_dispatcher` | (per-template preprocess events) |
| User hooks (login, cancel, format name…) | `user_event_dispatcher` | `UserHookEvents` |
| Views data/query hooks | `views_event_dispatcher` | `ViewsHookEvents` |
| Toolbar hooks | `toolbar_event_dispatcher` | `ToolbarHookEvents` |
| JSON:API hooks | `jsonapi_event_dispatcher` | `JsonApiHookEvents` |
| Webform hooks | `webform_event_dispatcher` | `WebformHookEvents` |

## Alter- and return-style hooks

Event objects expose getters/setters so you can mutate the hook's data (e.g.
`FormAlterEvent`, `EntityViewEvent::getBuild()` by reference). Hooks that must return a value
use events implementing `HookReturnInterface` — set your value and the submodule feeds
`getReturnValue()` (or a specific getter like `ThemeEvent::getNewThemes()`) back into the
hook return. Use Symfony subscriber priorities and `$event->stopPropagation()` to order or
short-circuit handlers.
