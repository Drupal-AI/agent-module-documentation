<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# social_media — events

This module extends via **Symfony events**, not Drupal `hook_*` alter hooks. Each event
carries a `Drupal\social_media\Event\SocialMediaEvent` whose `getElement()` /
`setElement()` expose the array being altered. Subscribe with a normal
`EventSubscriberInterface` service; a worked example ships in `social_media.api.php`.

| Event name | When | `element` payload | Use it to |
|---|---|---|---|
| `social_media.add_more_social_media` | building the admin form's network list | associative array `network_key => Label` | register a **new** network so it appears in settings |
| `social_media.pre_execute` | start of block `build()`, before sort/render | the full `social_media.settings` config array | tweak per-network config (weight, url, enable) at render time |
| `social_media.pre_render` | end of block `build()`, before theming | the assembled `elements` array (text/api/attr/img) | alter final rendered elements (relabel, drop, restyle) |

## Example subscriber

```php
namespace Drupal\my_module\EventSubscriber;

use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySocialSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents() {
    return [
      'social_media.add_more_social_media' => ['addNetwork', 0],
      'social_media.pre_render'            => ['tweakRender', 0],
    ];
  }

  // Add a "Reddit" option to the settings form.
  public function addNetwork($event) {
    $element = $event->getElement();
    $element['reddit'] = 'Reddit';
    $event->setElement($element);
  }

  // Relabel Facebook Messenger just before render.
  public function tweakRender($event) {
    $element = $event->getElement();
    if (isset($element['facebook_msg'])) {
      $element['facebook_msg']['text'] = 'Message us';
    }
    $event->setElement($element);
  }
}
```

Register it in `my_module.services.yml`:

```yaml
services:
  my_module.social_subscriber:
    class: Drupal\my_module\EventSubscriber\MySocialSubscriber
    tags:
      - { name: event_subscriber }
```

> The event name string is what you subscribe to (e.g. `social_media.pre_render`); the
> dispatched object is always `SocialMediaEvent`. `social_media.api.php` in the module
> shows the same three subscriptions in one class.
