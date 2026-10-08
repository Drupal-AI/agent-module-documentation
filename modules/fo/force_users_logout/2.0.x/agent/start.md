<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Force Users Logout — agent index

Three admin forms that **destroy other users' sessions** (individual user / by role / all
non-admins). No permissions of its own, no config schema, no services, no plugins, no Drush.
Everything ends in `session_manager->delete($uid)`, i.e. a `DELETE` from the `sessions` table.

- **The routes, tabs, forms and their exact behaviour (incl. who is excluded)** →
  [configure/admin-forms.md](configure/admin-forms.md)
- **Doing the same thing from code/drush, and the module's quirks** →
  [api/force-logout.md](api/force-logout.md)

Key facts:

- `configure` route = `force_users_logout.individual_user_form` → `/admin/config/force-users-logout/individualuser`
  (menu: *Configuration → Development → Force users logout settings*).
- **Every** route requires the core permission `administer users`; the module defines none.
- Its `ConfigFormBase` subclasses declare editable config names
  (`force_users_logout.individual_user_form`, `…rolebased_logout_form`,
  `…allotherusers_logout_form`) but the forms are **actions, not settings** — nothing
  meaningful is persisted and no schema exists for those names.
