<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Show Password adds a checkbox on the login form to reveal the typed password, client-side only.

---

Show Password implements `hook_form_user_login_form_alter` to add a 'Show Password' checkbox to the core user login form and attaches a small jQuery library. The JS toggles the `#edit-pass` input's `type` attribute between `password` and `text` when the checkbox changes. It only affects the value the user is currently typing in their own browser — it never pre-fills the field and cannot read stored or other users' passwords. No routes, no permissions, no server-side logic.

---

- Let users reveal the password they are typing.
- Reduce login failures from mistyped passwords.
- Toggle the login password field to plain text.
- Toggle it back to masked when unchecked.
- Improve usability on mobile keyboards.
- Add a single checkbox to the login form.
- Attach behavior via a tiny jQuery library.
- Operate entirely client-side.
- Avoid any server round-trip.
- Never expose stored passwords.
- Never expose other users' passwords.
- Work on Drupal 9 and 10.
- Require no configuration.
- Add no permissions or routes.
- Keep core login submission unchanged.
- Provide an accessibility/UX convenience.
