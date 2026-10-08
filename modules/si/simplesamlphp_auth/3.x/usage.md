<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
simpleSAMLphp Authentication lets users authenticate to a remote SAML identity provider via a locally configured simpleSAMLphp service provider — single sign-on against an enterprise or federated IdP.

---

SAML is the enterprise single-sign-on standard: users authenticate at a central identity provider (Azure AD, Okta, Shibboleth, a university federation) and services trust an assertion from it rather than holding passwords. This module is the Drupal side of that, built on the simpleSAMLphp library — it delegates login to the configured IdP, maps the returned SAML attributes onto Drupal accounts, and can auto-provision users on first login.

It is a mature, widely used auth module, and the security-relevant points are about configuration rather than defects. SAML security lives in the assertion trust: the service-provider metadata, the IdP certificate, and how assertions are validated all sit in the simpleSAMLphp configuration outside Drupal, and getting the certificate/entityID and signature-validation settings right is what makes the trust real — a misconfigured SP that does not validate signatures is the classic SAML flaw. The module exposes `administer simplesamlphp authentication` and `change saml authentication setting`, which are high-privilege (they govern how the site authenticates everyone) and belong to trusted administrators only. Its companion `simplesamlphp_custom_attributes` maps additional SAML attributes to user fields.

For any site doing enterprise SSO, this is the standard route. The module is sound; the security is in the simpleSAMLphp configuration and the certificates, which must be set up and maintained carefully.

---

- Authenticate via a SAML IdP.
- Add enterprise single sign-on.
- Delegate login to Azure AD or Okta.
- Join a university SAML federation.
- Map SAML attributes to user fields.
- Auto-provision users on first login.
- Use Shibboleth for login.
- Trust a central identity provider.
- Configure a simpleSAMLphp SP.
- Validate IdP assertions.
- Restrict SAML settings to admins.
- Sync roles from SAML attributes.
- Provide federated login.
- Avoid local passwords.
- Integrate corporate SSO.
- Configure the IdP certificate.
- Map an email attribute to the account.
- Enforce signature validation.
- Support SSO logout.
- Adopt a standard SAML client.
- Govern authentication centrally.
- Change SAML settings carefully.