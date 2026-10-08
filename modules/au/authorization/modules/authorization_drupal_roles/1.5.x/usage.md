<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Authorization that provides the `authorization_drupal_roles` **consumer** plugin: it grants (and revokes) Drupal roles to a user based on the proposals a provider matches in an authorization profile.

---

`authorization_drupal_roles` is the one consumer that ships inside the Authorization project. It registers a single `@AuthorizationConsumer` plugin, id `authorization_drupal_roles` (label "Drupal Roles"), so an `authorization_profile` can select **Drupal Roles** as its consumer. Each consumer mapping row is a single `role` value: a role machine name, the special value `none` (map to nothing), or `source` (a wildcard that maps any matched proposal straight to a like-named role — used with caution). When a profile grants, the plugin adds the role to the user (`$user->addRole()`), remembering per-profile which roles it granted (via the `authorization_drupal_roles.manager` service) so it can later revoke only its own grants; it can also create missing roles on the fly (`createConsumerTarget()` is allowed) and sanitizes arbitrary group names into valid role ids by transliterating to lowercase `[a-z0-9_.]`. It has no settings of its own ("There are no settings for Drupal roles"). It intentionally refuses to map the reserved names `none` and `source` as literal roles.

---

- Grant a Drupal role to users matched by an authorization profile
- Revoke roles when the matching provider proposal disappears (de-provisioning)
- Map an LDAP group directly to a specific role via a mapping row
- Use the `source` wildcard to turn any matched group into a like-named role automatically
- Auto-create roles from external group names that don't yet exist in Drupal
- Keep the module's own grants isolated so manually assigned roles are never revoked
- Sanitize messy directory group names into valid Drupal role machine ids
- Skip a mapping row by selecting `none` when a matched group should grant nothing
- Pair with an LDAP provider to deliver dynamic, directory-driven role assignment
- Provide the consumer half of a one-provider/one-consumer authorization profile
- Grant an `editor` role to everyone in an LDAP "editors" group at login
- Assign multiple roles to a user by adding several mapping rows to one profile
- Let a directory group named "Site Admins" become a role automatically via the wildcard
- Ensure role changes in the external directory propagate to Drupal on the next login
- Remove a role automatically when the user leaves the corresponding external group
- Track, per authorization profile, exactly which roles this consumer granted
- Keep two different profiles granting different roles without interfering with each other
