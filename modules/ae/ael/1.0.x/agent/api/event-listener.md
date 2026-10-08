<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using `#[AsEventListener]` (ael)

## Install & enable

```bash
composer require drupal/ael
drush en ael -y
```

No dependencies; core **11.3+**. Enabling the module registers `AelServiceProvider`, which enables the
attribute container-wide. There is nothing to configure.

## How it works

`AelServiceProvider::register()` (`src/AelServiceProvider.php`):

- adds `Symfony\...\AddEventAliasesPass(KernelEvents::ALIASES)` so kernel event aliases resolve;
- calls `$container->registerAttributeForAutoconfiguration(AsEventListener::class, [self::class, 'addEventListenerTag'])`.

`addEventListenerTag()` runs for every **autoconfigured** service whose class or a method carries
`#[AsEventListener]`. It reads the attribute's properties with `get_object_vars()` and adds a
`kernel.event_listener` tag with them. For a method-level attribute it injects `method` = the method
name; declaring `method` on a method-level attribute throws `LogicException`.

## Register a listener in your module

Your service must be autoconfigured. In `yourmodule.services.yml`:

```yaml
services:
  _defaults:
    autoconfigure: true
    autowire: true
  Drupal\yourmodule\EventListener\MyRouteListener: ~
```

### Class as listener (via `__invoke`)

```php
namespace Drupal\yourmodule\EventListener;

use Drupal\Core\Routing\RouteBuildEvent;
use Drupal\Core\Routing\RoutingEvents;
use Symfony\Component\EventDispatcher\Attribute\AsEventListener;

#[AsEventListener(event: RoutingEvents::ALTER)]
class MyRouteListener {
  public function __invoke(RouteBuildEvent $event): void {
    // React to the event.
  }
}
```

### Method(s) as listeners

```php
#[AsEventListener(event: KernelEvents::REQUEST, priority: 100)]
public function onRequest(RequestEvent $event): void { /* ... */ }
```

Repeat the attribute for multiple events, and set `priority:` to order among listeners of the same
event. `dispatcher:` targets a non-default event dispatcher if you use one.

## Notes

- Only **autoconfigured** services are scanned — a manually defined service without autoconfiguration
  won't be tagged.
- The module adds no listeners itself; it is a dependency you require so your own attribute-based
  listeners work. The test submodule `tests/modules/ael_collector_attribute` exercises the mechanism.
- Feature tracked for Drupal core in issue #3376163; this module backfills it for 11.3+.
