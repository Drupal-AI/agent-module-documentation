<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SSO Bouncer validates SSO OpenID Connect login data for Keycloak groups, authorizing login based on group membership.

---

SSO Bouncer adds group-based authorization on top of OpenID Connect SSO — it validates SSO login data
(specifically Keycloak group claims) during the OpenID Connect authorization step and **denies login for
users whose group is not authorized** to access this Drupal instance. It implements
`hook_openid_connect_pre_authorize()`, maps a configured `clientId` to allowed groups/roles, and returns an
access-denied (with the message "Your group is not authorized to access this Drupal instance") when the
user's group isn't in the mapping. It depends on the OpenID Connect module, provides Drush commands, and is
in the User authentication package.

Use it to restrict SSO login to authorized Keycloak groups and/or map groups to Drupal roles. This is a
genuine authorization control implemented at the correct hook: it runs *before* the account is authorized
and can **deny** login (fail-closed for unauthorized groups), which is the right pattern for group-gated
SSO. When adopting: configure the client ID and group→role mappings carefully (the mapping decides who gets
in and with what roles — a permissive mapping over-grants), store the OpenID Connect client secret as a
secret, and test that unauthorized groups are actually denied. Configure the SSO Bouncer settings and role
mappings.

---

- Gate SSO login by Keycloak group.
- Deny users whose group isn't authorized.
- Validate OpenID Connect group claims.
- Implement hook_openid_connect_pre_authorize().
- Map clientId to allowed groups/roles.
- Depend on the OpenID Connect module.
- Provide Drush commands.
- Run before the account is authorized (fail-closed).
- Return access-denied for unauthorized groups.
- Configure group->role mappings carefully.
- Avoid over-permissive mappings.
- Store the OIDC client secret as a secret.
- Test that unauthorized groups are denied.
- Map SSO groups to Drupal roles.
- Restrict SSO to authorized groups.
- Configure the client ID.
- Gate login by group.
- Authorize by group membership.
- Deny unauthorized SSO users.
- Configure SSO Bouncer.
