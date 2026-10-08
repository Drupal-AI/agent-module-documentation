<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A developer framework that implements a core Access Policy granting Drupal permissions to users based on their external (non-Drupal) roles.

---

External Roles extends Drupal's role-based access control through core's Access Policy API (Drupal 10.3+). It lets you drive Drupal permissions from roles that come from outside Drupal — the roles an SSO or OpenID Connect identity provider reports, or roles from any other external system — without creating a matching Drupal role for each one. A user's external roles are stored in an unlimited-cardinality string base field on the user entity (`external_roles`, table `user__external_roles`) and are read or changed in code through the lightweight `ExternalRolesUser` wrapper. When core calculates a user's permissions, the tagged `access_policy.external_roles` policy (`ExternalRolesAccessPolicy`) contributes the permissions mapped to that user's external roles. The role→permission mapping is resolved by a swappable repository: the default `ExternalRolesRepository` reads it from `$settings['external_roles']` in `settings.php`, and any consuming module can override the `external_roles.repository` service to load definitions from a YAML file, config, or a remote source instead. This is developer plumbing — there is no admin UI, no route, and no config form; you write the definitions and assign roles from your own business logic (typically a user-presave or SSO login hook). It depends only on core's User module.

---

- Grant Drupal permissions to users based on roles that originate outside Drupal.
- Map roles reported by an SSO / OpenID Connect identity provider onto Drupal permissions.
- Extend role-based access control via core's Access Policy API without adding Drupal roles.
- Define a role→permission mapping in `settings.php` (`$settings['external_roles']`).
- Store a user's external roles in the `external_roles` base field (table `user__external_roles`).
- Assign external roles to a user from `hook_user_presave()` using the `ExternalRolesUser` wrapper.
- Assign external roles from an OpenID Connect user-info save hook after validating provider roles.
- Add, remove, check, or reset a user's external roles in code via `ExternalRolesUser`.
- Provide an `external_roles` service to resolve a user's external roles and their permissions.
- Contribute external-role permissions to permission calculation through `ExternalRolesAccessPolicy`.
- Swap the default repository to source role definitions from a YAML file shipped with a module.
- Swap the repository to load role definitions from config, a database, or a remote system.
- Vary computed permissions correctly with the `user.external_roles` cache context.
- Keep the role→permission definition in server-side code rather than a click-through admin form.
- Bridge an existing external identity system's authorization model into Drupal permissions.
- Give integration modules a small, documented contract (`ExternalRolesRepositoryInterface`) to implement.
- Layer external-role permissions on top of a user's normal Drupal role permissions.
- Drive per-user permissions from group/team/tenant membership tracked in an upstream system.
- Migrate legacy application roles into Drupal permissions without recreating each role in Drupal.
- Let business logic decide a user's authorization at login/save time and persist it on the account.
- Rebuild caches after changing external-role definitions so permission calculation stays current.
