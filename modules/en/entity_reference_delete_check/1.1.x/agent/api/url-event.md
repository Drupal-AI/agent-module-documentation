<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# URL resolution event and the paragraph_url submodule

How a link to each referencing entity is resolved for the delete-form notice, and what the optional
submodule adds. Source: `src/Event/DeleteCheckEntityUrlEvent.php`,
`src/EventSubscriber/DeleteCheckEntityUrlEventSubscriber.php`,
`modules/entity_reference_delete_check_paragraph_url/`.

## The event

`Drupal\entity_reference_delete_check\Event\DeleteCheckEntityUrlEvent` (extends
`Drupal\Component\EventDispatcher\Event`):
- `public readonly EntityInterface $entity` — the referencing entity, set in the constructor.
- `private ?Url $url = NULL` with `getUrl(): ?Url` and `setUrl(?Url $url): void`.

The form alter creates one event per referencing entity and dispatches it via the `event_dispatcher`
service. Whatever URL a subscriber sets is used to link the list item; if none is set, the item is
plain text.

## Default subscriber

`EventSubscriber\DeleteCheckEntityUrlEventSubscriber` subscribes to `DeleteCheckEntityUrlEvent` with
method `setUrl()`. It calls `$event->setUrl($entity->toUrl())` inside a try/catch — on any
`\Exception` (e.g. an entity with no canonical link template) it leaves the URL unset and lets another
subscriber try. Registered in `entity_reference_delete_check.services.yml` with the `event_subscriber`
tag.

## Submodule: entity_reference_delete_check_paragraph_url

Separate installable module (`modules/entity_reference_delete_check_paragraph_url/`).
`info.yml` dependencies: `paragraphs:paragraphs` and
`entity_reference_delete_check:entity_reference_delete_check`.

`EventSubscriber\ParagraphUrlProvider` also subscribes to `DeleteCheckEntityUrlEvent::setUrl`. For a
referencing entity that is a `Drupal\paragraphs\ParagraphInterface`, it walks up the parent chain
(`while ($entity instanceof ParagraphInterface) { $entity = $entity->getParentEntity(); }`), then, if a
non-paragraph parent was found, sets the URL to that parent's `toUrl()` (try/catch swallows failures).
This gives a usable link to the page hosting the paragraph, since a bare paragraph has no meaningful
canonical URL. Non-paragraph entities are ignored by this subscriber (early `return`), leaving the
default subscriber's URL in place. Registered via the submodule's own `services.yml` with the
`event_subscriber` tag.

Because both subscribers listen on the same event, the paragraph_url one refines the link only for
paragraph references; there is no configured priority, so any custom subscriber you add can likewise
set a URL for your own entity types.
