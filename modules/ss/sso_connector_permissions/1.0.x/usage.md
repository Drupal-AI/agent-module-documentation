<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SSO Connector Permissions manages IdP↔SP role mappings and site registrations for the SSO suite.

---

SSO Connector – Permissions manages role/permission mapping for the SSO Connector suite when Drupal acts as the identity provider (IdP) — administrators register service-provider (SP) sites and map this IdP's roles to the roles each SP reports, plus a permissions report, so downstream sites receive the right roles on SSO.

All configuration (role mappings, site registrations) is admin-gated: `administer sso connector permissions`, `manage sso site registrations`, and `view sso permissions report` — restrict these to trusted administrators, as they govern cross-site role assignment. Depends on `sso_connector`, core `user`, and `serialization`; requires Drupal 11.2+.

---

- Map IdP roles to SP roles.
- Register service-provider sites.
- Manage cross-site role assignment.
- Provide a permissions report.
- Support the IdP role of the suite.
- Gate with `administer sso connector permissions`.
- Gate with `manage sso site registrations`.
- Gate the report with `view sso permissions report`.
- Restrict permissions to trusted admins.
- Depend on `sso_connector` and core `user`.
- Depend on core `serialization`.
- Require Drupal 11.2+.
- Configure role mappings.
- Govern SSO roles.
- Support single sign-on.
- Report permissions
- Manage registrations
- Assign SP roles
