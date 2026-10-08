<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media auto publication (media_auto_publication) — agent index

**On the transition of a host entity to published, auto-publishes any unpublished media it references.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends on:** field, media
- **Service:** `media_auto_publication.publish_associated` → `PublishAssociated`.
- **Hook:** `hook_entity_presave` (ordered last via `hook_module_implements_alter`); triggers when entity implements `EntityPublishedInterface`, is now published, and was new or previously unpublished.
- **Mechanism:** scans `entity_reference` fields with `target_type: media`, calls `setPublished(TRUE)->save()` on unpublished referents.
- **Moderation note:** no routes, permissions, or admin UI. The publish is unconditional on that transition — it calls `setPublished(TRUE)->save()` directly (`src/PublishAssociated.php`, `publishReferencedMedias()`) without consulting content_moderation, so referenced media in a draft/unpublished moderation state is published alongside the host. This is the module's intended behaviour but can publish media an editor intended to keep unpublished.