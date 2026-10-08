<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Edit Protection warns editors before they navigate away from an unsaved node add/edit form, so in-progress content is not lost to a stray click or the back button.

---

The module is a tiny, zero-configuration JavaScript enhancement. A `hook_form_alter` attaches the `node_edit_protection/node_edit_protection` library to any form whose `#attributes['class']` contains `node-form` — i.e. Drupal's node add and edit forms. The library's behavior (`Drupal.behaviors.nodeEditProtection`) marks the form "dirty" when the user blurs any input inside `.node-form`, lets genuine submit buttons through (it tags them `node-edit-protection-processed` and records a click), and registers `window.onbeforeunload` to return the message *"You will lose all unsaved work."* whenever the form is dirty and the user is not submitting. It also detects unsaved CKEditor changes via `CKEDITOR.instances[i].checkDirty()`. There is no settings form, config, permission, Drush command, or plugin — enabling the module is the entire setup. The library depends only on `core/jquery` and `core/drupal`. To protect a non-node form you attach the same library (or add the `node-form` class) yourself.

---

- Warn authors before they leave a half-written article without saving.
- Prevent accidental loss of a long body edited in CKEditor when clicking a menu link.
- Guard against the browser back button discarding an in-progress node edit.
- Catch an accidental tab/window close on a node edit form.
- Reduce "I lost my work" support tickets from content editors.
- Protect long-form content entry (blog posts, landing pages) on node forms.
- Give a native browser "Leave site?" confirmation only when there are real unsaved changes.
- Allow normal submit/save buttons to work without triggering the warning.
- Detect unsaved rich-text (CKEditor) changes, not just plain input changes.
- Provide the safety net with zero configuration — just enable the module.
- Keep the guard scoped to node forms so other admin pages are unaffected.
- Extend protection to a custom form by attaching `node_edit_protection/node_edit_protection` to it.
- Add the guard to a custom entity form by giving its form the `node-form` class.
- Improve editorial UX on sites with slow-to-fill node forms.
- Avoid losing unsaved changes when an editor clicks an external link mid-edit.
- Pair with autosave-less workflows where losing the form means retyping everything.
- Protect translation edits performed on the node edit form.
- Reassure infrequent editors that navigating away is caught.
- Ship a consistent unsaved-changes experience across all content types automatically.
- Use as a lightweight alternative to heavier form-state/autosave modules.
- Keep dependencies minimal (only core jQuery and Drupal JS).
