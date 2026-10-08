Quick Edit lets users edit field content in place, directly on the rendered page, without opening the full node edit form — the contrib continuation of Drupal core's former Quick Edit module.

---

Quick Edit adds front-end, in-place editing: when a permitted user hovers content, contextual "pencil" links let them click a field and edit its value right where it appears, saving via AJAX without a full page reload. It builds on core's Contextual Links, Editor, Field, and Filter modules. Each editable field is matched to an **in-place editor** plugin — plain text for simple string fields, a full WYSIWYG editor for formatted text (via the Editor/CKEditor integration), an image editor, and a generic form-based editor as a fallback for anything else. The module generates per-field metadata describing which editor to use and whether the current user has access, enforced by a dedicated access check and the `access in-place editing` permission. It integrates with Layout Builder so fields placed in layouts remain editable. Developers can add new editor types by implementing the `InPlaceEditor` plugin type and can alter editor selection or field rendering through two hooks. Originally part of Drupal core, it was moved to contrib in Drupal 10.3+, so sites that still want inline editing install this module.

---

- Edit a node's title in place without opening the edit form.
- Inline-edit body/formatted-text fields with a WYSIWYG editor.
- Quickly fix a typo directly on the published page.
- Edit plain-text fields (string, number) in place.
- Replace an image field's image inline.
- Save field edits via AJAX without a page reload.
- Use contextual "pencil" links to enter edit mode.
- Restrict in-place editing to trusted roles via permission.
- Keep fields editable inside Layout Builder layouts.
- Provide a fast content-correction workflow for editors.
- Fall back to a generic form editor for complex fields.
- Respect field-level access when offering inline editing.
- Add a custom in-place editor for a bespoke field type.
- Override the editor used for a field via `hook_quickedit_editor_alter`.
- Customize how a field renders during quick edit via `hook_quickedit_render_field`.
- Restore the inline-editing UX removed from Drupal core.
- Let marketers tweak copy on the live site quickly.
- Edit multiple fields on a page in one session.
- Preserve text format filters when editing formatted text inline.
- Reduce round-trips to the full edit form for small changes.
- Provide a decoupled-free way to edit content contextually.
- Enable inline editing only where contextual links appear.
