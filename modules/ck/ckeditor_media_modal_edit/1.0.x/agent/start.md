<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CkEditor Media Modal Edit (ckeditor_media_modal_edit) — agent index

**Appends an AJAX-modal "Edit this media" link to media-library widget items so editors edit media without leaving CKEditor.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Requires:** media
- **Service:** `ckeditor_media_modal_edit.link_builder` → `MediaEditModalLinkBuilder::addEditLinksToMediaForm()`
- **Hooks:** `hook_form_alter` on `views_form_media_library_widget*` (add links) and `media_*_edit_form` (AJAX save → close dialog)
- **Routes:** none of its own; reuses core `entity.media.edit_form`.

**Security:** Edit link is gated on `$media->access('update')`; no custom routes, permissions or external calls — relies entirely on core media access. No findings.
