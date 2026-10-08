<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable Author

Removes the "Authoring information" (author) fieldset from node add/edit forms for users whose roles are configured as disallowed, to simplify the editing UI for those roles.

- Choose which roles should not see the author fieldset.
- Applied to any node form via `hook_form_alter`.
- Purely a form-UI hide (`#access = FALSE`).

---

## Installation & configuration

- Enable; settings at `/admin/config/disable_author/settings` (perm `administer site configuration`).
- Select the roles for which the author fieldset should be hidden (`disallowed_roles`).
- Config object: `disable_author.settings`.
- Applies whenever the current user has any of the disallowed roles.
- No custom permissions are defined by the module.
- Works on standard node forms (detected via the `node-form` class).

---

## Usage & behaviour / security

- `disable_author_form_alter` checks the node-form class, loads the current user, and intersects their roles with `disallowed_roles`.
- If matched, it sets `$form['author']['#access'] = FALSE`, hiding the fieldset.
- IMPORTANT: this only hides the field in the UI; it is a display/UX convenience, not an access-control guarantee — do not rely on it to prevent authorship changes through other channels (REST, other forms, programmatic edits).
- Users retain whatever node edit permissions they already have; only the widget is hidden.
- No data is exposed; the change is subtractive (removes a form element).
- No routes beyond the admin settings form; the settings form requires `administer site configuration`.
- No DB queries, external calls, or SSRF.
- Useful to reduce clutter for editor roles that should not reassign authorship.
- Combine with proper permissions if you need to actually forbid changing the author.
- The settings form lives in `src/Form/ConfigForm.php`.
- Legacy release line `8.x-1.7` (normalized `8.x-1.x`), still marked compatible with modern core.
- Multilingual/UI-only; no content is altered.
- Uninstall restores the default node form.
- To hide for more roles, edit the settings and add roles.
- Read: `disable_author.module`, `src/Form/ConfigForm.php`.
