<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Visibility keeps public files belonging to a publicly-inaccessible entity in the private filesystem until the entity becomes available for public, closing the unpublished-entity file-leak gap.

---

File Visibility closes a well-known information-leak gap: a file (e.g. an image) attached to an
unpublished/inaccessible entity, when stored in the public filesystem, is directly downloadable by URL
even though the entity itself is not viewable. File Visibility keeps such files in the **private**
filesystem while the entity is not publicly accessible, and moves them to public only when the entity
becomes available — so file access follows entity access. It computes access via Drupal's access system
(returning AccessResult) and physically relocates files between public/private accordingly. It depends on
core File and ships a `file_visibility_track_usage` submodule.

This is a positive security feature — it makes attached-file visibility track the entity's publish/access
state, preventing the classic "unpublished node's public image is still fetchable" leak. When adopting:
ensure the private filesystem is configured and served through Drupal's access-checked file delivery, and
verify the access mapping matches your intent (which entity states count as "public"). It provides
file-access enforcement, so test it against your content workflow. Configure the tracked entity types/
fields.

---

- Keep unpublished-entity files private.
- Prevent public-file leaks of hidden entities.
- Move files public only when the entity is public.
- Make file access follow entity access.
- Compute access via Drupal's access system.
- Relocate files between public/private.
- Depend on core File.
- Use the file_visibility_track_usage submodule.
- Close the unpublished-node image leak.
- Serve private files through access-checked delivery.
- Verify which states count as public.
- Configure tracked entity types/fields.
- Apply a positive security control.
- Test against your content workflow.
- Protect attached files.
- Follow publish state for files.
- Enforce file visibility.
- Prevent direct file download of hidden content.
- Track file usage.
- Harden file access.
