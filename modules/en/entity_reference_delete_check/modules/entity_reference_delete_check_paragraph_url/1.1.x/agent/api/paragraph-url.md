<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ParagraphUrlProvider event subscriber

Source: `modules/entity_reference_delete_check_paragraph_url/src/EventSubscriber/ParagraphUrlProvider.php`,
`entity_reference_delete_check_paragraph_url.services.yml`, `.info.yml`.

## Purpose

The parent module dispatches `DeleteCheckEntityUrlEvent` once per entity that references the item being
deleted, so subscribers can attach a link for the delete-form notice (see the parent module's
`api/url-event.md`). The parent's default subscriber uses the entity's own `toUrl()`, which fails for a
Paragraph (no canonical route). This submodule fills that gap.

## Behaviour

`ParagraphUrlProvider implements EventSubscriberInterface`:
- `getSubscribedEvents()` → `[DeleteCheckEntityUrlEvent::class => 'setUrl']`.
- `setUrl(DeleteCheckEntityUrlEvent $event)`:
  - Reads `$event->entity`. If it is **not** a `Drupal\paragraphs\ParagraphInterface`, returns
    immediately (leaves any URL already set by the default subscriber untouched).
  - Otherwise loops `while ($entity instanceof ParagraphInterface) { $entity = $entity->getParentEntity(); }`
    to climb nested paragraphs up to the first non-paragraph host.
  - If a host was found, `$event->setUrl($entity->toUrl())` inside a try/catch that swallows any
    `\Exception` (leaves the URL unset on failure).

Registered as an `event_subscriber` (no explicit priority). Requires `paragraphs` and the parent
module; uses the parent project's PSR-4 namespace
`Drupal\entity_reference_delete_check_paragraph_url\`. No config, schema, routes, permissions, or
install hooks.
