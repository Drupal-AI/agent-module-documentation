<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events — alter slider settings before render

The base module defines two events (`Drupal\slider_collection\Event\SliderCollectionEvents`) that
let other modules mutate a slider's option array just before it is JSON-encoded into the container's
`data-*` attribute. The library submodules dispatch them from their preprocess hooks.

| Constant | Event name (string) | Event class | Dispatched from | Carries |
|---|---|---|---|---|
| `SliderCollectionEvents::ALTER_VIEW_SETTINGS` | `slider_collection.alter_view_settings` | `AlterViewSettingsEvent` | Views-style preprocess (`sc_swiper`, `sc_tinyslider`) | `array &$settings`, `Drupal\views\ViewExecutable $view` |
| `SliderCollectionEvents::ALTER_ENTITY_SETTINGS` | `slider_collection.alter_entity_settings` | `AlterEntitySettingsEvent` | Field-formatter preprocess (`sc_swiper` only) | `array &$settings`, `Drupal\Core\Entity\EntityInterface $entity` |

Note: `sc_swiper` dispatches the event on the **raw** options, then calls `formattedSettings()`;
`sc_tinyslider` calls `formattedSettings()` first and dispatches on the **already-formatted**
options. So the settings shape you receive depends on which library fired the event.

### Event class methods

Both event classes hold the settings by reference and expose:

- `getSettings(): array` — current option array.
- `setSettings(array $settings): void` — replace the option array.
- Context accessor: `AlterViewSettingsEvent::getView(): ViewExecutable` /
  `AlterEntitySettingsEvent::getEntity(): EntityInterface`.

### Subscriber example

```php
use Drupal\slider_collection\Event\AlterViewSettingsEvent;
use Drupal\slider_collection\Event\SliderCollectionEvents;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

final class MySliderSettings implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [SliderCollectionEvents::ALTER_VIEW_SETTINGS => 'onViewSettings'];
  }

  public function onViewSettings(AlterViewSettingsEvent $event): void {
    if ($event->getView()->id() === 'promos') {
      $settings = $event->getSettings();
      $settings['effect'] = 'fade';   // Swiper option; keys must match the library.
      $event->setSettings($settings);
    }
  }

}
```

Register it as a service tagged `event_subscriber`. Because each library discards any key not in its
`defaultSettings()` during `formattedSettings()`, subscribing is the supported way to inject
library options (e.g. Swiper `effect`/`fadeEffect`) that have no option-form field.
