<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Create User Permission adds a single `create users` permission so a role can create new user accounts without being granted the all-powerful `administer users` permission.

---

Out of the box Drupal only lets you open the *Add user* form (`/admin/people/create`, route `user.admin_create`) if you have `administer users`, which also grants editing, blocking, cancelling and role-assigning every account on the site. This module closes that gap with one permission, `create users`. A route subscriber (`RouteSubscriber::alterRoutes()`) rewrites the `user.admin_create` route's requirement to `_permission: 'create users'`, and `hook_entity_create_access()` returns *allowed* for the `user` entity type whenever the account holds that permission, so programmatic and form-based user creation both honour it. `hook_form_user_register_form_alter()` refines the admin *Add user* form for these delegated creators: when the site's `user.settings` register mode is not `visitors`, it forces the new account to be created active (status = 1) with the `administer_users` form value set so the account is saved without extra intervention, and it exposes the "Notify user of new account" email checkbox. The module has no configuration UI, no settings, no config schema, no Drush commands and no plugins — its entire surface is the one permission plus the route/access/form alterations that enforce it. Grant `create users` to any role and its members get delegated account-creation only, following the principle of least privilege.

---

- Let a support or HR role add new user accounts without giving them `administer users`.
- Delegate account creation to a "user manager" role that must not be able to edit or delete existing users.
- Allow front-desk staff to register new members via `/admin/people/create` while an admin keeps full people management.
- Give a partner/reseller role the ability to onboard accounts without site-administration power.
- Grant onboarding staff the right to create accounts and optionally email login details, using the "Notify user" checkbox this module re-enables.
- Enforce least privilege by replacing broad `administer users` grants with the narrow `create users` permission.
- Ensure delegated creators produce active accounts automatically when public registration is admin-only.
- Permit a moderator role to create accounts but leave role assignment and cancellation to real admins.
- Let a custom module create `user` entities on behalf of a low-privilege actor by checking `create users` via `hook_entity_create_access()`.
- Protect the core `user.admin_create` route with a dedicated permission instead of overloading `administer users`.
- Build a tiered People-admin model: some roles create accounts, others manage/administer them.
- Allow a school/club administrator role to enrol new members as Drupal users.
- Give a call-centre role the ability to spin up customer accounts quickly.
- Combine with core registration settings so delegated creators still respect the site's active/blocked defaults.
- Audit which roles can create users by looking for the `create users` permission rather than `administer users`.
- Let an event organiser role create attendee accounts without touching other users.
- Provide account provisioning to an integration/service role without full user administration.
- Reduce risk from a compromised low-privilege editor account by never granting it `administer users`.
- Allow a "membership secretary" to add members and notify them by email on creation.
- Configure a role in *People → Permissions* with just "Create users" ticked under the Create User Permission section.
- Let a franchise-manager role onboard local staff accounts on a multi-team site.
- Support delegated user creation on a decoupled/back-office workflow where an operator only needs to add accounts.
- Grant temporary account-creation ability to a role during a migration or bulk-onboarding window.
- Keep the *Add user* form usable for non-admins while hiding the wider People administration tools.
- Assign `create users` to a role so REST/programmatic user creation by that role's members passes create-access checks.
