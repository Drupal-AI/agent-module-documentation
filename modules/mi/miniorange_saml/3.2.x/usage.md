<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
miniOrange SAML SP turns a Drupal site into a SAML 2.0 Service Provider so users can log in through an external Identity Provider (Okta, Azure AD, ADFS, Keycloak, OneLogin, etc.) using SAML single sign-on.

---

The module registers Drupal as a SAML SP. You configure the external IdP on the Service Provider Setup tab (`/admin/config/people/miniorange_saml/sp_setup`, the `configure` route `miniorange_saml.sp_setup`), which stores the IdP details into the `miniorange_saml.settings` config object: `miniorange_saml_idp_name`, `miniorange_saml_idp_issuer` (IdP entity id), `miniorange_saml_idp_login_url` (SSO URL), optional `miniorange_saml_idp_logout_url`, and `miniorange_saml_idp_x509_certificate`. SP-initiated login is at `/samllogin` (route `miniorange_saml.saml_login`): it builds a deflated SAML AuthnRequest and redirects to the IdP's login URL; the IdP posts the assertion back to the Assertion Consumer Service at `/samlassertion` (`miniorange_saml.saml_response`), which validates it (assertion/response signature against the configured certificate, response Destination, assertion validity window, one-time-use replay store, IdP issuer and SP audience) and logs the user in. SP metadata is served at `/saml_metadata` (add `?download=1` to download); the SP entity id and base URL are also shown on the Service Provider Metadata tab. Attribute/role mapping (Mapping tab) controls which SAML attributes map to the Drupal username/email — `miniorange_saml_username_attribute` and `miniorange_saml_email_attribute` default to `NameID`; the default NameID format is `urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified`. Sign-in settings (`miniorange_saml_enable_login`, `miniorange_saml_auto_redirect_to_idp`, `miniorange_saml_force_auth`, `miniorange_saml_enable_backdoor`, relay state) live on the Signin tab. A SAML login link is auto-added to the user login form and login block once the module is "configured" (login enabled AND an IdP name + issuer are set); the link can additionally be injected onto admin-listed custom form ids. First-time SSO users get a Drupal account auto-created, and when role mapping is enabled (`miniorange_saml_enable_rolemapping`) a default role can be assigned. Diagnostic tabs let admins view the generated SAML request/response (`/showSAMLRequest`, `/showSAMLResponse`) and run the Test Configuration flow. Advanced features (encrypted assertions, custom-generated certificates, multiple IdPs, role/attribute mapping, user provisioning) are gated behind the paid/licensed tiers; the free SP core is fully usable. There are no Drush commands, no plugin types, and access to every admin tab and diagnostic route is gated by core's `administer site configuration` permission (the module ships no permissions of its own); only `/samllogin`, `/samlassertion` and `/saml_metadata` are public.

---

- Let employees sign in to Drupal with their Okta / Azure AD / ADFS / OneLogin / Keycloak account via SAML SSO.
- Configure an external IdP's issuer, SSO login URL, logout URL and x509 certificate on the SP Setup tab.
- Provide SP-initiated login at `/samllogin` that redirects users to the corporate IdP.
- Accept SAML assertions at the ACS endpoint `/samlassertion` and log the user into Drupal.
- Publish the site's SP metadata at `/saml_metadata` (add `?download=1` to download it) to hand to the IdP administrator.
- Map the incoming SAML NameID (or a named attribute) to the Drupal username and email.
- Change the NameID format sent in the AuthnRequest (default `...1.1:nameid-format:unspecified`).
- Force re-authentication at the IdP on each login via `miniorange_saml_force_auth`.
- Auto-redirect visitors straight to the IdP for login (`miniorange_saml_auto_redirect_to_idp`).
- Keep a Drupal-native login "backdoor" available while SSO is on (`miniorange_saml_enable_backdoor`).
- Add a "Login using <IdP>" link to the Drupal login form and login block automatically once configured.
- Also inject the SAML login link onto custom forms via `miniorange_saml_sso_link_on_custom_form` / `miniorange_saml_custom_form_ids`.
- Turn SAML login on or off site-wide with `miniorange_saml_enable_login`.
- Set a default RelayState / post-login redirect for SSO (only local targets are honored).
- Test the SAML configuration end-to-end via the Test Configuration flow (`/testSAMLConfig`).
- Inspect the generated AuthnRequest (`/showSAMLRequest`) and SAML response (`/showSAMLResponse`) for troubleshooting.
- Auto-create Drupal accounts for first-time SSO users.
- Assign a default role to provisioned users when role mapping is enabled (`miniorange_saml_enable_rolemapping`).
- Integrate a Drupal intranet with a company-wide single sign-on system.
- Enable SSO for a membership or education portal using an institutional IdP.
- Give partners federated access to a Drupal site without separate Drupal passwords.
- Inspect/export the SP metadata to register the Drupal SP inside the IdP.
- Store all IdP/SP settings as exportable `miniorange_saml.settings` config for deployment.
- Provide a support/contact tab and a trial-request flow for configuration help within the admin UI.
