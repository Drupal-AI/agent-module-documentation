<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
miniOrange SAML Identity Provider makes Drupal act as a SAML 2.0 IdP, so Drupal users can single sign-on into any SAML 2.0-compliant service provider using their Drupal login.

---

miniOrange SAML Identity Provider (miniOrange SAML IdP) makes the Drupal site itself the SAML 2.0
Identity Provider: external SAML Service Providers (SaaS apps, other web apps) trust Drupal for
authentication, and a user logged into Drupal can single sign-on into those SPs. You register each SP
in the module (entity ID, ACS URL, attributes to release), and Drupal issues signed SAML assertions
to them. This is the inverse of a SAML SP module — here Drupal is the authentication authority, not
the consumer.

The security-critical pieces of an IdP are the assertion-signing private key (which must be kept
secret — anyone with it can forge assertions for any SP) and the SP trust configuration (only
intended SPs, with correct ACS URLs, should be registered). Unlike miniOrange's *Security Login
Secure* module, this IdP module was checked and does **not** disable TLS certificate verification on
its outbound calls. As with other miniOrange modules, the admin UI promotes the vendor's paid tiers;
that is a licensing consideration, not a security one. Configure the IdP at
`miniorange_saml_idp.idp_setup`, protect the signing key, and release only the minimum attributes each
SP needs.

---

- Make Drupal a SAML 2.0 Identity Provider.
- Let Drupal users SSO into external SAML service providers.
- Register a service provider (entity ID, ACS URL).
- Issue signed SAML assertions to SPs.
- Release user attributes to each SP.
- Protect the assertion-signing private key.
- Configure IdP metadata for SPs to consume.
- Set up SSO for a SaaS app against Drupal.
- Map Drupal user fields to SAML attributes.
- Register only intended SPs with correct ACS URLs.
- Act as the authentication authority (not an SP).
- Configure the IdP at miniorange_saml_idp.idp_setup.
- Sign assertions so SPs can verify them.
- Release the minimum attributes each SP needs.
- Provide IdP-initiated or SP-initiated SSO.
- Distinguish this from a SAML SP/consumer module.
- Note it does not disable TLS verification (unlike sibling).
- Keep the signing key out of version control.
- Support any SAML 2.0-compliant SP.
- Understand vendor paid-tier promotion in the UI.
