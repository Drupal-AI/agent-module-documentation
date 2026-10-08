# Alter a CSP policy at runtime

The built policy is dispatched for alteration just before it becomes a header.

## Modules: subscribe to `CspEvents::POLICY_ALTER`
Event name `csp.policy_alter`; listener receives `\Drupal\csp\Event\PolicyAlterEvent`
with `getPolicy(): Csp` and `getResponse(): Response`.

```php
use Drupal\csp\CspEvents;
use Drupal\csp\Event\PolicyAlterEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyCspSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [CspEvents::POLICY_ALTER => 'onPolicyAlter'];
  }

  public function onPolicyAlter(PolicyAlterEvent $event): void {
    $policy = $event->getPolicy();
    // Only add the host if the directive (or a fallback) is already enabled.
    $policy->fallbackAwareAppendIfEnabled('img-src', 'https://example.com');
  }
}
```
The module's own behaviour is built from such subscribers (`SettingsCspSubscriber`,
`LibrariesCspSubscriber`, `ReportingCspSubscriber`, `CoreCspSubscriber`, …).

## Themes: `hook_csp_policy_alter()`
Themes can't register services, so they use the hook (see `csp.api.php`):
```php
function mytheme_csp_policy_alter(\Drupal\csp\Csp $policy, \Symfony\Component\HttpFoundation\Response $response): void {
  $policy->appendDirective('img-src', 'https://example.com');
}
```
Modules should use the event, not this hook.

See [api/policy.md](../api/policy.md) for the `Csp` object's mutation methods.
