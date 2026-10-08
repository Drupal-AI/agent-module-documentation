<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Events — agent index

A developer API that re-dispatches core entity lifecycle hooks as Symfony events. **No config,
no permissions, no routes, no plugins, no Drush, no UI.** You react to entity changes by
extending an abstract subscriber base class and registering it as an `event_subscriber` service.

- **Event names, the `EntityEvent` object, and how dispatch works** →
  [api/events.md](api/events.md)
- **The abstract subscriber base classes and how to write + register a subscriber** →
  [extend/subscribers.md](extend/subscribers.md)

Key facts:
- Event name constants on `Drupal\entity_events\EntityEventType`: `INSERT='event.insert'`,
  `UPDATE='event.update'`, `PRESAVE='event.presave'`, `DELETE='event.delete'`,
  `PREDELETE='event.predelete'`.
- Dispatched object: `Drupal\entity_events\Event\EntityEvent` with `getEntity()` and
  `getEventType()`.
- Hooks are implemented in the autowired service `Drupal\entity_events\Hook\EntityEventsHooks`.
- Consume by extending `EntityEventInsertSubscriber` / `…UpdateSubscriber` / `…PresaveSubscriber`
  / `…DeleteSubscriber` / `…PredeleteSubscriber` (or the combined `EntityEventSubscriber`).
- Subscribers fire for **all** entity types — filter on `getEntity()->getEntityTypeId()`.
