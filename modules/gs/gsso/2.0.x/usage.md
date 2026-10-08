<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group SSO (gsso) maps identity-provider claims coming from an SSO login to Drupal user roles, Group memberships and group roles.
---
The problem it solves: when users authenticate through an external IdP (typically via SimpleSAMLphp), the site still needs to translate the IdP's group/role attributes into Drupal's own authorization model. gsso reads two configured attributes from the SSO assertion — a "group" attribute and a "role" attribute — splits them by a configurable separator, and looks up a `sso_claims` mapping to decide which Drupal roles to grant and which Groups (and group roles) to join.

How it works: gsso does NOT perform authentication itself. It implements `hook_simplesamlphp_auth_user_attributes()` (in `gsso.module`), so it runs only inside SimpleSAMLphp's already-verified login flow — the SAML assertion signing and any CSRF/state protection are the IdP/SimpleSAMLphp module's responsibility. On each login gsso stores the raw claims string in a custom `gsso_claims` table (via the `gsso.gsso` service), and if the claims changed it first strips ALL of the user's roles and Group memberships (`removeUserMemberships`) and then re-adds the mapped ones (`associateUserToGroups`). Because a login fully re-synchronises authorization from the IdP, the mapping config is the single source of truth — a misconfiguration can silently remove access.

Setup: enable the module (requires Group), install/configure SimpleSAMLphp Authentication, then visit `/admin/group/sso` (permission: `administer group`) to set `sso_type` (must be `saml`), the group/role attribute names, the separator, and the `sso_claims` matrix that maps each claim value to roles + groups + group roles.
---
- Grant Drupal roles automatically from an SSO/SAML claim value.
- Add users to one or more Groups based on IdP attributes.
- Assign specific group roles (beyond plain membership) per claim.
- Configure the IdP attribute that carries group information.
- Configure a separate IdP attribute that carries role information.
- Choose the separator (EOL or custom) used to split multi-value claims.
- Re-synchronise a user's roles and memberships on every login.
- Only re-sync when claims change (via the `claims_changes` flag) to reduce writes.
- Persist the last-seen claims per user in the `gsso_claims` table.
- Enable debug logging to trace attribute-to-role/group decisions.
- Centralise authorization so IdP admins control Drupal access.
- Revoke access by removing a claim on the IdP side (next login strips it).
- Map one claim value to multiple roles and multiple groups at once.
- Model a role/group matrix through the `sso_claims` config array.
- Integrate with SimpleSAMLphp Authentication as the auth provider.
- Restrict who can edit the mapping via the `administer group` permission.
- Audit membership changes through the module's `gsso` logger channel.
- Support SAML as the SSO type via the pluggable `SSOType` plugin.
