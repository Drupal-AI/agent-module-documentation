<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides an Authorization consumer plugin so that provider mappings (LDAP, OAuth, SAML, etc.) can grant users Group memberships and Group roles automatically.

---
The Authorization module has a provider/consumer pattern: a *provider* (e.g. LDAP) supplies proposals about a user, and a *consumer* applies them to some Drupal target. This module adds the `authorization_group` consumer (`GroupConsumer`) whose target is the Group module. In the Authorization profile UI each mapping row lets an admin pick a Group, and optionally a Group role, from a select list built from all groups and their non-global roles.

When a profile is applied, `grantSingleAuthorization()` adds the user as a member of the chosen group (`$group->addMember()`) and, if a role was selected, appends that group role to the membership if not already present. `revokeGrants()` walks the user's memberships and, for groups/roles no longer in the granted set, either strips the roles or deletes the whole membership when the profile's "Remove the user from the Group, if they no longer have any roles" option is enabled. Global (site-wide) group roles are skipped so they are never touched. Anonymous users and empty/`none` mappings are ignored.

There are no routes, endpoints or request-driven code paths — all logic runs inside the Authorization module's grant/revoke lifecycle. Typical setup is: enable Authorization + Group + a provider, create an Authorization profile, choose the Groups consumer, and add mapping rows tying provider values to Group + role.
---
- Provision Group memberships from an LDAP/OAuth/SAML provider.
- Grant a specific Group role based on a provider attribute.
- Map an external group value to a Drupal Group + role.
- Auto-add authenticated users to a Group on login.
- Revoke Group roles when the provider no longer grants them.
- Delete a Group membership when no roles remain (optional).
- Keep global (site-wide) group roles untouched during sync.
- Skip anonymous users during provisioning.
- Choose the Group and role per mapping row in the profile UI.
- Enforce SSO-driven Group access centrally.
- Sync department/team membership from a directory into Groups.
- Add multiple Group+role mappings in one Authorization profile.
- Preserve manually-assigned roles not covered by mappings.
- Show status messages when a Group role is granted or revoked.
- Drive Group access without writing custom code.
- Re-evaluate memberships on each authorization application.
- Combine Group provisioning with other Authorization consumers.
- Toggle "remove from group when no roles" per profile.
- Avoid auto-creating Drupal groups (createConsumerTarget is a no-op).
- Model organisational hierarchy via Groups from external identity data.