# Entity Events — manual setup guide

**Entity Events** (`entity_events`) is a small developer module that turns
Drupal's entity lifecycle hooks into dispatched Symfony events. Instead of
scattering `hook_entity_insert()`, `hook_entity_update()`, and friends across a
`.module` file, you react to entity changes in a proper event subscriber class —
testable, injectable, and decoupled from other modules.

It listens for the five core entity hooks — **insert**, **update**, **presave**,
**delete**, and **predelete** — and, for each, dispatches an `EntityEvent` that
carries the affected entity and the event type. You consume those events by
extending one of the module's ready-made abstract subscriber base classes,
implementing the matching method, and registering your class as an event
subscriber service.

There is nothing to configure. The module has no settings form, no permissions, no
routes, no plugins, and no UI — it is purely an API for developers. This is the
kind of module you install because another module or your own custom code depends
on it, not something a site builder switches on for a visible feature.

This guide is written for a **human** developer. If you want terse, token-cheap
references for an AI coding agent — including the exact event constants and base
classes — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — Entity Events has no admin pages or settings. Once enabled, it simply
dispatches events that your code subscribes to.

## How to use it

After enabling the module, react to entity changes in three steps.

1. **Write a subscriber** by extending the base class for the lifecycle stage you
   care about — `EntityEventInsertSubscriber`, `EntityEventUpdateSubscriber`,
   `EntityEventPresaveSubscriber`, `EntityEventDeleteSubscriber`, or
   `EntityEventPredeleteSubscriber` (or the all-in-one `EntityEventSubscriber` to
   handle several stages in one class). Implement the matching `onEntity*()`
   method:

   ```php
   namespace Drupal\mymodule\EventSubscriber;

   use Drupal\entity_events\Event\EntityEvent;
   use Drupal\entity_events\EventSubscriber\EntityEventInsertSubscriber;

   class NodeCreatedSubscriber extends EntityEventInsertSubscriber {
     public function onEntityInsert(EntityEvent $event) {
       $entity = $event->getEntity();
       if ($entity->getEntityTypeId() !== 'node') {
         return;
       }
       // Your reaction: log, notify, enqueue a job, sync an external system…
     }
   }
   ```

2. **Register it** as an `event_subscriber` service in your module's
   `*.services.yml`:

   ```yaml
   services:
     mymodule.node_created_subscriber:
       class: Drupal\mymodule\EventSubscriber\NodeCreatedSubscriber
       tags:
         - { name: event_subscriber }
   ```

3. **Rebuild the container** (`drush cr`). Your subscriber now fires on the next
   matching entity operation.

Two things to keep in mind: subscribers fire for **every** entity type, so almost
always filter on `$event->getEntity()->getEntityTypeId()` (and bundle) before
acting; and on *presave* of a brand-new entity the ID is not yet assigned, so use
the *insert* event if you need the saved ID.
