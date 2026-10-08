<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registration Role automatically grants one or more chosen roles to every newly created user account, optionally including accounts created by an administrator.

---

The module is deliberately tiny: one settings form, one config object and one hook. `registration_role.setting` holds `role_to_select` (a sequence of role ids — the `authenticated` role is never offered) and `registration_mode`, which is either `user` ("User self registration") or `admin` ("Both user self registration and user creation by admin"). The form lives at `/admin/people/registration-role` (route `registration_role.setting.form`, menu item under *People*, task tab on the People screen) and is gated by the module's own permission, `administer registration roles`. At runtime `registration_role_user_presave()` runs on every user save: it grants the configured roles when the account is **new** and either the current user is anonymous (uid 0 and not CLI — a genuine self-registration) or the site is in `admin` mode (someone else, including Drush/CLI, is creating the account). It uses `$user->addRole($rid)` and only for entries whose value is truthy, guarding against the pre-2.0 configuration format in which unselected roles were stored as `0`. That legacy format was a real security bug: `registration_role_update_10001()` strips non-selected roles and logs/warns that users registered between 2023-07-11 and the update may have received *every* role. The module creates no database tables, provides no Drush commands, no plugins, no services and no tokens; the README suggests `autoassignrole` for anything more elaborate (e.g. letting users pick their own role).

---

- Give every self-registered user a "Member" role distinct from plain authenticated users.
- Distinguish people who signed up themselves from accounts created by staff.
- Tag everyone who registers after a launch date with a "Cohort 2026" role.
- Grant a "Regular user" role whose permissions are *not* inherited by editors or admins.
- Assign a role that a content-moderation transition ("Request publication") depends on.
- Feed a role that `required_by_role` uses to make certain fields mandatory for new users only.
- Segment users for Mass Contact or another role-based mailing tool.
- Assign a per-site role when several sites share one user table.
- Give new registrants a role that grants access to a members-only section.
- Apply several roles at once to each new registrant.
- Include admin-created accounts in the assignment by switching to "admin" mode.
- Exclude admin-created accounts by leaving the mode at "user".
- Grant the same role to accounts created by Drush/CLI scripts (CLI counts as admin mode).
- Give new users a role that a Views filter or Rules-style workflow keys off.
- Assign a role used by a paid-membership or registration-token module as a starting state.
- Roll the role out as exported configuration across environments.
- Turn the behaviour off temporarily by clearing the role list.
- Delegate the setting to a non-administrator with the `administer registration roles` permission.
- Provide a role for analytics/reporting on registration cohorts.
- Give registrants a role that grants a higher flood/rate limit.
- Assign a role that a private-file or taxonomy-access module uses.
- Grant a role that unlocks a personalised dashboard or menu link.
- Audit which roles new users get from one screen rather than reading custom code.
- Replace a bespoke `hook_user_presave()` snippet with configuration.
