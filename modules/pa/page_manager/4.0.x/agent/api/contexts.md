# Contexts & the context event

Variants and their blocks/selection criteria run against a set of **contexts**. Page Manager
gathers them via event subscribers and one dispatched event.

## Built-in contexts (event subscribers, `src/EventSubscriber/`)
- `CurrentUserContext` — the logged-in user (`@user.current_user`-style context).
- `RouteParamContext` — each typed route parameter declared in the page's `parameters`
  (e.g. `{node}` upcast to a node entity via `Context\EntityLazyLoadContext`).
- `LanguageInterfaceContext` — the current interface language.
- Static contexts defined on the page_variant (`static_context`).

## Add contexts in code
Subscribe to `PageManagerEvents::PAGE_CONTEXT` (`src/Event/PageManagerEvents.php`). The
`PageManagerContextEvent` carries the `Page` entity; add contexts to it:

```php
use Drupal\page_manager\Event\PageManagerEvents;
use Drupal\page_manager\Event\PageManagerContextEvent;

class MyContextSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [PageManagerEvents::PAGE_CONTEXT => 'onContext'];
  }
  public function onContext(PageManagerContextEvent $event): void {
    $page = $event->getPage();
    $page->addContext('my_context', new Context(
      new ContextDefinition('entity:node', 'My node'), $node
    ));
  }
}
```

Register the subscriber with the `event_subscriber` tag. Added contexts become available to
every variant, block, and selection/access condition on the page.

Related services: `page_manager.context_mapper` (maps stored static-context config to real
contexts), `Context\ContextDefinitionFactory` (builds definitions for parameters).
