# Extend — alter the redirect via the `r4032login.redirect` event

Just before it builds the redirect response, `R4032LoginSubscriber::on403()` dispatches a
`RedirectEvent`, letting other modules change the target URL or the URL options (query,
`absolute`, etc.). This is the supported extension point — the module exposes no service to
subclass; the subscriber itself is the `r4032login.subscriber` service.

## Event

- Class: `Drupal\r4032login\Event\RedirectEvent`
- Name constant: `RedirectEvent::EVENT_NAME` = `'r4032login.redirect'`
- Payload getters/setters: `getUrl()` / `setUrl($url)`, `getOptions()` / `setOptions(array $options)`
- Constructed as `new RedirectEvent($redirectPath, $options)` where `$options` already contains
  `absolute => TRUE` and, when `redirect_to_destination` is on, `query[destination]` (or the
  overridden parameter). Changes you make here are used to build the final
  `TrustedRedirectResponse` / `CacheableRedirectResponse`.

## Example subscriber

```php
namespace Drupal\mymodule\EventSubscriber;

use Drupal\r4032login\Event\RedirectEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyR4032Subscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [RedirectEvent::EVENT_NAME => 'onRedirect'];
  }

  public function onRedirect(RedirectEvent $event): void {
    // Send to a marketing login landing page instead.
    $event->setUrl('/welcome-login');
    // Adjust options (keep or replace the destination query, etc.).
    $options = $event->getOptions();
    $options['query']['utm_source'] = '403';
    $event->setOptions($options);
  }
}
```

Register it in `mymodule.services.yml`:

```yaml
services:
  mymodule.r4032_subscriber:
    class: Drupal\mymodule\EventSubscriber\MyR4032Subscriber
    tags:
      - { name: event_subscriber }
```

## Notes

- The subscriber's own service definition (`r4032login.services.yml`) injects `config.factory`,
  `current_user`, `path.matcher`, `event_dispatcher`, `messenger`, and `redirect.destination`.
- For simple target/message/status changes prefer the config settings (see
  [../configure/settings.md](../configure/settings.md)); use the event only when the target must
  be computed at request time.
