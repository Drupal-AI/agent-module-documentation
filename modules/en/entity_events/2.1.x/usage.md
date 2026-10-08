<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Events turns Drupal's entity lifecycle hooks (insert, update, presave, delete, predelete) into dispatched Symfony events, so you can react to entity changes in an event subscriber instead of in a `.module` file's `hook_entity_*` implementations.

---

The module is a small developer API with no configuration, permissions, routes, plugins or UI. It implements the five core entity hooks (via the `Drupal\entity_events\Hook\EntityEventsHooks` autowired service) and, for each, dispatches an `EntityEvent` on the event dispatcher. The event names are constants on `Drupal\entity_events\EntityEventType`: `INSERT = 'event.insert'`, `UPDATE = 'event.update'`, `PRESAVE = 'event.presave'`, `DELETE = 'event.delete'`, `PREDELETE = 'event.predelete'`. Each dispatched `Drupal\entity_events\Event\EntityEvent` carries the affected entity (`getEntity()`) and the event type string (`getEventType()`). To consume them you extend one of the provided abstract subscriber base classes — `EntityEventInsertSubscriber`, `EntityEventUpdateSubscriber`, `EntityEventPresaveSubscriber`, `EntityEventDeleteSubscriber`, `EntityEventPredeleteSubscriber` (or the all-in-one `EntityEventSubscriber`) — implement the matching `onEntity*()` method, and register your class as an `event_subscriber` service in your module's `*.services.yml`. The subscribers fire for every entity type, so your handler typically checks `$event->getEntity()->getEntityTypeId()` (and bundle) before acting. It is a drop-in, decoupled replacement for scattering `hook_entity_insert()`/`update()`/etc. across procedural module files.

---

- React to new content by extending `EntityEventInsertSubscriber` instead of writing `hook_entity_insert()`.
- Run logic before an entity is saved by subscribing to `event.presave`.
- Clean up related data when an entity is deleted via `EntityEventDeleteSubscriber`.
- Perform validation or blocking checks in a predelete subscriber.
- Keep entity-reaction code in a testable service class rather than a `.module` file.
- Centralize cross-cutting entity logic (e.g. cache clearing) in one subscriber.
- Send a notification email whenever a node of a given type is created.
- Sync an external system when a product entity is updated.
- Index or re-index a document in a search service on entity insert/update.
- Stamp computed fields on presave for a specific bundle.
- Log an audit trail entry on every entity update.
- Invalidate a custom cache tag when a taxonomy term changes.
- Enqueue a background job on entity insert using an event subscriber.
- Trigger a webhook to a third party when an entity is deleted.
- Filter by `getEntityTypeId()` so a subscriber only reacts to `node` entities.
- Reuse one `EntityEventSubscriber` subclass to handle several lifecycle stages at once.
- Decouple modules by having them subscribe to entity events rather than depend on each other's hooks.
- Unit-test entity reactions by dispatching an `EntityEvent` to your subscriber directly.
- Prevent deletion of referenced entities by inspecting the entity in a predelete subscriber.
- Update denormalized data on a related entity when the source entity is saved.
- Adjust prioritization of handlers using the subscriber's event priority.
- Replace a legacy `hook_entity_update()` implementation with an event subscriber during a refactor.
- Coordinate multiple reactions to the same entity change through separate, focused subscribers.
- Provide an extension point in a distribution so site builders can react to entity events.
