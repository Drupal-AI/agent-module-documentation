# Recurring Events — the `event_instance_creator` plugin type

Controls *how* `eventinstance` entities are created/updated when a series is saved. The site picks the
active plugin via `recurring_events.eventseries.config` → `creator_plugin` (default
`recurring_events_eventinstance_recreator`).

- Manager: `plugin.manager.event_instance_creator` = `EventInstanceCreatorPluginManager`
  (`src/EventInstanceCreatorPluginManager.php`).
- Attribute: `#[EventInstanceCreator(id, description, deriver?)]`
  (`src/Attribute/EventInstanceCreator.php`); legacy annotation `@EventInstanceCreator`
  (`src/Annotation/EventInstanceCreator.php`) also exists.
- Base class: `Drupal\recurring_events\EventInstanceCreatorBase`
  (interface `EventInstanceCreatorInterface`).
- Discovered under `src/Plugin/EventInstanceCreator/`.

## Implement one
```php
namespace Drupal\my_module\Plugin\EventInstanceCreator;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\recurring_events\Attribute\EventInstanceCreator;
use Drupal\recurring_events\EventInstanceCreatorBase;

#[EventInstanceCreator(
  id: 'my_smart_creator',
  description: new TranslatableMarkup('Only recreate instances whose dates actually changed.'),
)]
final class MySmartCreator extends EventInstanceCreatorBase {
  // Override the base creation/update logic (e.g. processInstances()).
}
```
Then set it site-wide: `drush cset recurring_events.eventseries.config creator_plugin my_smart_creator`.

## Override per series at runtime
Implement `hook_recurring_events_event_instance_creator_plugin_alter(&$active_plugin, $manager, $series)`
to swap the plugin for specific series (see [hooks/hooks.md](../hooks/hooks.md)).
