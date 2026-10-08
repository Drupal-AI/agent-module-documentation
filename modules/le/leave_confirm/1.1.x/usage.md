<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Leave Confirm warns a user who navigates away from a form with unsaved changes, using the browser's leave-confirmation prompt.

---

Losing work is the editorial complaint that damages trust fastest, and Drupal's long forms make it easy — a node with dozens of fields and several paragraphs is twenty minutes of work held only in the browser, discarded by one mistaken click with no warning. Leave Confirm guards chosen forms with the browser's `beforeunload` dialog. After enabling the module (`composer require drupal/leave_confirm`), configure it at **Configuration » User interface » Leave confirm configuration** (`/admin/config/user-interface/leave-confirm-points`); access needs the **Administer leave confirm settings** permission. The tricky part to know: **guarding is opt-in per form and every point ships disabled**, so nothing happens until you turn one on. Installation seeds points for the user login/register/password and personal-contact forms, plus one per node type and per webform when those modules are present — all switched off. To protect a form, either **Enable** a seeded point or click **Add leave confirm point** and enter the form's real form ID (e.g. `node_page_form` for adding a page, `node_page_edit_form` for editing, `user_register_form`, `webform_submission_<id>_form`; base form IDs also work). Three constraints are worth knowing because the mechanism is more limited than it looks: the message wording **cannot be customised** (the browser substitutes its own), it **only appears once the user has interacted with the page**, and it **does not fire on JavaScript-driven navigation**, so decoupled or AJAX-heavy flows bypass it. False positives — a widget that rewrites a value on load, a WYSIWYG that normalises whitespace — are what make people dismiss the warning reflexively, so enable it where edits are genuinely at risk rather than everywhere.

---

- Warn before leaving an unsaved node add/edit form.
- Enable a shipped point for the user registration form.
- Protect the personal contact form from accidental loss.
- Guard a long webform against navigation away.
- Add a new form point by its form ID.
- Protect a paragraph-heavy page's in-progress edits.
- Prevent losing twenty minutes of editing to a stray click.
- Warn on an accidental tab close or back gesture.
- Guard a specific content type's form while leaving others alone.
- Restrict who can configure guarded forms via a role permission.
- Protect a translation in progress.
- Guard a media upload form mid-edit.
- Warn on unsaved layout or tabledrag reordering changes.
- Protect a survey or application submission in progress.
- Reduce support requests about lost work.
- Guard a complex configuration or settings form.
- Warn before leaving a comment draft.
- Warn on unsaved profile edits.
- Enable protection only on high-value forms to avoid false-positive fatigue.
- Deploy guarded-form points as config for a repeatable environment.
