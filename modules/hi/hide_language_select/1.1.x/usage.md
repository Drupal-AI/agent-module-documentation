<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hide Language Select conditionally hides the user language selector unless a permission is held.

---

Hide Language Select hides the language-select field on the user profile/registration form, revealing it only for users who hold the `show language select permission`. It's useful when most users shouldn't change their interface language but a subset (e.g. staff) should.

It's a form-visibility utility gated by a permission; note this controls form display of the field, not underlying language capabilities. Supports Drupal 9, 10, and 11.

---

- Hide the user language-select field.
- Reveal it with a permission.
- Gate with `show language select permission`.
- Control who can change UI language.
- Hide for most users.
- Show for staff/subset.
- Act as a form-visibility utility.
- Control form display, not capability.
- Support Drupal 9, 10, and 11.
- Simplify the user form.
- Manage language visibility.
- Apply per role.
- Hide language options.
- Configure via permission.
- Reduce form clutter.
- Restrict language changes visually.
- Show language select selectively.
- Support multilingual sites
