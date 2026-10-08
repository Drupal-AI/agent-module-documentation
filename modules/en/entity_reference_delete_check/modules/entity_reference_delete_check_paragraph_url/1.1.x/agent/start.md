<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Delete Check Paragraph Url (entity_reference_delete_check_paragraph_url) — agent index

Submodule of **entity_reference_delete_check**. One event subscriber that supplies a linkable URL for
**paragraph** references shown on a content-entity delete confirm form, by walking up to the
paragraph's host entity. No config, permissions, routes, or plugins. Core `^10.3 || ^11`, PHP `^8.1`,
GPL-2.0-or-later. Version 1.1.0.

- **Details** → [api/paragraph-url.md](api/paragraph-url.md)

## What it actually is (from source)

- `EventSubscriber\ParagraphUrlProvider` subscribes to
  `Drupal\entity_reference_delete_check\Event\DeleteCheckEntityUrlEvent` (method `setUrl`). For a
  `ParagraphInterface` entity it climbs `getParentEntity()` until a non-paragraph host and sets that
  host's `toUrl()`; ignores non-paragraph entities.
- Registered in `entity_reference_delete_check_paragraph_url.services.yml` with the `event_subscriber`
  tag.

## Dependencies

- `paragraphs:paragraphs` and `entity_reference_delete_check:entity_reference_delete_check`
  (from `.info.yml`). No Composer runtime deps of its own; shares the parent project's PSR-4 autoload.
