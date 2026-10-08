<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Removes the "Preview" button from forms you name, using a `hook_form_alter` that matches form IDs by prefix string or by regular expression. Despite the name/description mentioning the contact form, it works on any form.

---

Hide Preview has a single job: strip the preview action from selected forms. You enter one form-name pattern per line at `/admin/config/hide_preview` (route `hide_preview.settings`, gated by the core `administer site configuration` permission). At form build time `hide_preview_form_alter()` walks each stored pattern: if the pattern is a valid regular expression it runs `preg_match($pattern, $form_id)` and removes the button on any capture; otherwise it treats the pattern as a plain string and matches when `$form_id` merely *contains* it (`strpos`). Matching forms have their preview element unset from the common locations — `$form['actions']['preview']`, `$form['actions']['preview_draft']`, and the Gin admin theme's `$form['meta']['preview']` / `$form['top']['meta']['preview']`. Settings are stored as the array `hide_preview.settings:hide_preview.form_names`. There is no config schema, no permissions of its own, and no submodules; the whole module is one `.module` file plus a config form. The submit form validation rejects a line only when it contains non-word characters yet is not a valid regexp.

---

- Hide the preview button on all contact form submission forms (e.g. regexp `/contact_message_*/`).
- Hide preview on a single named form by giving its exact `form_id` prefix.
- Hide preview on every node edit form by matching the `node_` / `_node_form` prefix pattern.
- Remove the preview button that the Gin admin theme renders in the form `meta` region.
- Strip the "Preview draft" button (`preview_draft`) added by some workflow/moderation setups.
- Match a whole family of forms with one regular expression rather than listing each ID.
- Match forms by a simple substring when you do not want to write a regex.
- Prevent editors from using preview on custom entity forms whose IDs share a prefix.
- Disable preview on webform submission forms by matching their form-ID prefix.
- Hide preview on comment forms to force direct submission.
- Enforce a "no preview" editorial policy across several content types at once.
- Turn off preview on forms where the preview render is broken by a contrib module.
- Reduce confusion on simple public forms by removing an unused preview action.
- Apply different patterns per line to cover several unrelated forms in one config.
- Quickly test which forms are affected by adding/removing a pattern line and re-saving.
- Keep preview enabled everywhere except a specific problematic form.
- Hide preview on media add/edit forms by matching their form IDs.
- Remove preview from user-facing forms while leaving admin forms untouched.
- Use a catch-all regex to hide preview site-wide (matching most form IDs).
- Combine string and regex patterns freely across multiple lines.
