<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extension point: the alter-output event

## What is dispatched

`SinglePageSiteController::render()` dispatches, for every rendered section:

- Event name constant: `Event\SinglePageSiteEvents::SINGLE_PAGE_SITE_ALTER_OUTPUT`
  (string value `single_page_site.alter_output`).
- Event object: `Event\EventSinglePageSiteAlterOutput` (extends
  `Drupal\Component\EventDispatcher\Event`).

Constructor `__construct($output, $current_item_count)`. Accessors:

| Method | Purpose |
|---|---|
| `getOutput()` / `setOutput($output)` | The rendered section output (a string / Markup). Replace it to change what that section shows. |
| `getCurrentItemCount()` / `setCurrentItemCount($n)` | 1-based index of the section currently being rendered (first item = 1). |

The controller takes `$event->getOutput()` back after dispatch and stores it as the section's
`output`. So a subscriber can prepend/append/replace the markup of each section.

## Subscribing (pattern)

```php
// my_module.services.yml
services:
  my_module.sps_alter:
    class: Drupal\my_module\EventSubscriber\MyAlter
    tags:
      - { name: event_subscriber }
```

```php
use Drupal\single_page_site\Event\EventSinglePageSiteAlterOutput;
use Drupal\single_page_site\Event\SinglePageSiteEvents;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyAlter implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [SinglePageSiteEvents::SINGLE_PAGE_SITE_ALTER_OUTPUT => [['alterOutput']]];
  }
  public function alterOutput(EventSinglePageSiteAlterOutput $event): void {
    $event->setOutput($event->getOutput() . '<hr>');
  }
}
```

The bundled **`single_page_site_next_page`** submodule is the reference implementation — it uses
this event to append a "scroll to next page" link. See
[../../../modules/single_page_site_next_page/3.0.x/agent/start.md](../../../modules/single_page_site_next_page/3.0.x/agent/start.md).

Note: `getOutput()` is already-rendered markup — if you concatenate raw HTML and want it treated as
safe, wrap the result in `Drupal\Core\Render\Markup::create()` (as the submodule does), but only
over content you trust.
