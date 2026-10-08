<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lets editors open a media entity's edit form in a modal dialog directly from the media library widget used by CKEditor.

---

When embedding media through CKEditor, the media library widget normally only lets you select existing media; editing a media item means leaving the editor. This module alters any `views_form_media_library_widget*` form and, for each selectable media item, appends an "Edit this media" link that opens the media edit form in an AJAX modal. A form_alter also intercepts `media_*_edit_form` requests made over AJAX so that saving closes the dialog (via a custom submit handler and a `CloseDialogCommand` AJAX callback) instead of doing a full-page redirect.

The edit link is only rendered when `$media->access('update')` returns TRUE, so per-entity update access is enforced before the link is shown — the module does not bypass Drupal's media access. The one service (`MediaEditModalLinkBuilder`) uses the entity type manager and renderer; there are no routes, permissions or external calls of its own — it reuses core's `entity.media.edit_form` route which keeps its own access checks. Setup is simply enabling the module; the behavior applies wherever the media library widget appears.

---
- Edit a media item in a modal without leaving CKEditor
- Add an inline pencil edit link to media-library items
- Update alt text / metadata of an embedded image quickly
- Fix a media entity's fields during content authoring
- Close the media edit modal automatically on save
- Keep editors in the WYSIWYG flow while correcting media
- Respect per-media update access before showing edit links
- Speed up captioning workflows for image media
- Correct a wrong media reference inline
- Provide a modal edit affordance in the media library widget
- Attach the module's styling library for the inline edit icon
- Use AJAX save so the editor state is preserved
- Apply to any media type editable via the media library
- Streamline media metadata governance for editors
- Avoid full-page reloads when editing embedded media
- Combine with core Media Library for richer editing
