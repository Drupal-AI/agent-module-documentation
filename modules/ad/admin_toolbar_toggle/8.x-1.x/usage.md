<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin Toolbar Toggle lets authenticated users hide/show the admin toolbar via a keyboard shortcut.

---

Admin Toolbar Toggle adds a small front-end convenience: a keyboard shortcut that hides or shows the Drupal admin toolbar while viewing the site. This helps admins/editors preview pages without the toolbar occupying screen space, then bring it back without navigating away.

It is a UI-only enhancement on top of the core `toolbar` module and carries no content or access role beyond a settings permission (`administer admin toolbar toggle settings`). Safe to grant to roles that already see the toolbar.

---

- Toggle toolbar visibility from the front end.
- Bind the toggle to a keyboard shortcut.
- Hide the toolbar to preview pages.
- Show the toolbar again without navigating.
- Enhance the core toolbar UX.
- Requires core `toolbar`.
- Gate settings with a dedicated permission.
- Carry no content/access role.
- Support Drupal 9.2+, 10, and 11.
- Help admins preview clean layouts.
- Improve editor screen real estate.
- Configure the shortcut key.
- Apply per authenticated user.
- Keep the enhancement lightweight.
- Grant safely to toolbar-seeing roles.
- Avoid page reloads.
- Complement Admin Toolbar.
- Work on any admin theme.
- Persist the toggle preference.
- Provide a quick UI convenience.
