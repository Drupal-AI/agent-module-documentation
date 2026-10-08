<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
miniOrange User Provisioning provides provisioning and de-provisioning of users and groups between Drupal and external identity providers (e.g. Okta, Keycloak).

---

miniOrange User Provisioning synchronizes Drupal users (and groups) with external identity providers
— provisioning and de-provisioning accounts to/from systems such as Okta and Keycloak — so account
lifecycle can be managed centrally in an IdP and reflected in Drupal (or vice versa). Its admin screens
(all gated by the `administer site configuration` permission) configure the target provider, mappings
and provisioning actions; it is configured at `user_provisioning.overview`.

Use it in SSO/identity-managed environments that need Drupal accounts kept in sync with an IdP. The
security-relevant points are: the IdP API credentials it uses should be stored as secrets (not in
plaintext), the admin routes are correctly restricted to site administrators, and its outbound API
calls were checked and do **not** disable TLS verification (unlike some other miniOrange modules
reviewed in this campaign). As is common with miniOrange modules, the admin UI promotes the vendor's
paid tiers/trial — a licensing consideration, not a security one.

---

- Provision Drupal users to an IdP.
- De-provision users from Drupal.
- Sync users with Okta/Keycloak.
- Manage account lifecycle centrally.
- Provision groups too.
- Configure at user_provisioning.overview.
- Gate admin routes to administrators.
- Store IdP API credentials as secrets.
- Map Drupal users to IdP.
- Keep accounts in sync with an IdP.
- Note it does not disable TLS (checked).
- Use in SSO environments.
- Reflect IdP changes in Drupal.
- Understand vendor paid-tier promotion.
- Provision to SCIM-style APIs.
- Handle de-provisioning securely.
- Sync user attributes.
- Manage users across systems.
- Restrict provisioning config to admins.
- Integrate identity management.
