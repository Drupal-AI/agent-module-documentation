<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Publishes unpublished media referenced by an entity the moment that entity becomes published.
---
When editors upload media into an unpublished node, the media entities often stay unpublished; after the node is published its images/videos can then appear broken or access-denied to anonymous visitors. This module fixes that by publishing the referenced media automatically. `hook_entity_presave` (moved to run last via `hook_module_implements_alter`) calls the `media_auto_publication.publish_associated` service (`\Drupal\media_auto_publication\PublishAssociated`).

`PublishAssociated::publish()` fires only when the saved entity is transitioning **to** published — i.e. it implements `EntityPublishedInterface`, is now published, and either is brand new (`original === NULL`) or its previous revision was unpublished. It then scans the entity's field definitions for `entity_reference` fields targeting `media`, iterates the referenced entities, and calls `setPublished(TRUE)->save()` on any that are still unpublished. There is no admin UI or configuration — installing it (with core `field` and `media`) enables the behaviour for all fieldable publishable entities. Operational note: it publishes referenced media unconditionally on that transition, without a separate access/moderation check — see the security posture in start.md.
---
- Auto-publish images when their host node is published.
- Ensure referenced media isn't broken/denied after publishing a page.
- Publish media referenced by any entity_reference→media field.
- Handle newly created published entities (no prior revision).
- Publish media when a draft node transitions to published.
- Avoid manually publishing each media item.
- Keep media publication in step with content publication.
- Cover multiple media reference fields on one entity.
- Skip already-published media (no redundant saves).
- Work across nodes, paragraphs, or any publishable fieldable entity.
- Reduce editor workload on media-heavy content.
- Prevent 403s on media files for anonymous users post-publish.
- Run last in the presave chain to catch final field values.
- Apply to custom content entities implementing publish state.
- Standardise media publishing across content types.
- Integrate without configuration (zero-config behaviour).
- Publish media referenced through a media library widget.
- Ensure galleries go live with their parent article.