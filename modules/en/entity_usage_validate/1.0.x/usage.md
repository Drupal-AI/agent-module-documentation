<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Usage Validate shows a warning message to authors when a published node is re-saved while referencing media entities that are still unpublished.

---

It targets a common editorial trap: a node is live but an image or video it embeds is unpublished, so the media does not render for the public. The module implements `hook_entity_update()` and, via `hook_module_implements_alter()`, reorders itself to run *after* Entity Usage has recorded the current revision's relationships. For published nodes only, it asks the `entity_usage.usage` service for the `media` targets of the node's current revision, loads them, and adds a `messenger` warning naming each item that is unpublished (title + ID). Because it hooks `hook_entity_update()` (not `hook_entity_insert()`), the check fires when an *existing* published node is saved again, not on the very first save that creates the node. It is advisory only — it never blocks the save, never changes the node, and requires no configuration.

The warning is shown only to the editor performing the save, who already has edit access to the node being saved; it never reaches anonymous users. It reads relationships through the Entity Usage API rather than querying entities directly, and only reports the label and ID of referenced media. It works on any content type whose nodes reference media, and requires the Entity Usage module (`drupal/entity_usage ^2.0`).

---

- Warn an editor that a published node references unpublished media.
- Surface the media title and ID that still needs publishing.
- Catch broken or empty media embeds before visitors see them.
- Run after Entity Usage so the relationship data is current.
- Check only the current revision of the node being saved.
- Restrict the check to published nodes.
- Skip the check entirely for unpublished nodes.
- Skip nodes that reference no media at all.
- Iterate every referenced media item and flag each unpublished one.
- Give authors an actionable reminder without blocking the save.
- Fire on re-saves of an existing published node (hook_entity_update).
- Rely on the Entity Usage API rather than manual entity queries.
- Help maintain content quality on media-heavy editorial sites.
- Prevent missing images or videos on go-live.
- Work across nodes of any content type that reference media.
- Integrate transparently with no configuration required.
- Support Drupal 8.9 through 11.
- Complement Entity Usage's tracking with a publish-time reminder.
- Keep the fix obvious by naming each offending media item.
- Add zero routes, permissions, or settings to maintain.
