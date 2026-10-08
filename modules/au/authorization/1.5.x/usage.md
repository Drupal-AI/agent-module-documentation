<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Authorization is a framework that maps data from an external identity provider (such as LDAP groups) onto Drupal-side authorizations (such as roles), through configurable "authorization profiles" that pair one **provider** plugin with one **consumer** plugin and a list of mappings between them.

---

Authorization is a generic mapping engine, not a login mechanism: it sits on top of `externalauth` and, at user login (`hook_user_login`), asks each enabled `authorization_profile` config entity to reconcile a user. A profile wires together exactly one **provider** plugin (an `@AuthorizationProvider` such as LDAP, which returns a list of *proposals* about the user — e.g. their group memberships) and one **consumer** plugin (an `@AuthorizationConsumer` such as the bundled Drupal Roles, which grants a Drupal-side target). Between them sits a table of **mappings**: provider mappings say which incoming proposals to match (a group name, or a regex), and the paired consumer mappings say what to grant when they match (which role). The service (`authorization.manager`, class `AuthorizationService`) fetches proposals from the provider, filters them through each mapping, then calls the consumer to grant matched targets and — if the profile's synchronization actions enable it — revoke previously provisioned targets that no longer apply. Each profile is evaluated in isolation. Synchronization is governed by two per-profile settings groups: `synchronization_modes` (when to act, e.g. `user_logon`) and `synchronization_actions` (whether to create missing consumer targets and whether to revoke grants the module previously made). Providers are shipped by integration modules (e.g. `ldap_authorization`); the only consumer that ships in-project is `authorization_drupal_roles`. The recommended setup is one profile per provider/consumer combination, configured through the admin form at `/admin/config/people/authorization/profile`.

---

- Map LDAP/Active Directory group memberships to Drupal roles at login
- Automatically grant editor/admin roles to users who belong to a specific directory group
- Revoke roles when a user is removed from the corresponding external group (de-provisioning)
- Provide a single, pluggable abstraction so provider modules (LDAP) and consumer modules (roles, groups) don't need to know about each other
- Configure one authorization profile per provider/consumer pairing for clean separation
- Use a regular expression to dynamically map *any* matched external group straight to a like-named role ("Source" wildcard)
- Create Drupal roles on the fly from external group names (consumer target creation)
- Keep role assignments in sync on every login so directory changes propagate automatically
- Grant roles based on a fixed mapping table (group "cn=admins" → role "administrator")
- Let an external identity system remain the single source of truth for authorization
- Surface a status message to users after their authorizations are processed at login
- Build a custom provider plugin to feed proposals from a non-LDAP source (SAML, API, CSV)
- Build a custom consumer plugin to grant a non-role target (Organic Groups, flags, entity access)
- Evaluate each profile independently so different directories drive different targets
- Restrict role provisioning so only roles the module granted are ever revoked (leave manual roles alone)
- Stage complex directory-to-role policies as exportable config entities managed in code
- Audit which profile granted which role to a user (per-profile grant tracking)
- Disable a profile to pause its provisioning without deleting its mapping configuration
- Provide turnkey "join group X → get role Y" onboarding for enterprise SSO deployments
- Combine with `ldap_authorization` as the provider to deliver dynamic, directory-driven role management
