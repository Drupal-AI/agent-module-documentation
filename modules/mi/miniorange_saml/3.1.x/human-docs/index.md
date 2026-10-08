# miniOrange SAML SP — manual setup guide

**miniOrange SAML Service Provider (SP)** (`miniorange_saml`) turns your Drupal site
into a SAML 2.0 **Service Provider**, so users can sign in through an external
**Identity Provider (IdP)** — Okta, Azure AD / Entra ID, ADFS, Keycloak, OneLogin, and
similar — using SAML single sign-on. Instead of a separate Drupal password, people
authenticate at your corporate or institutional login and are logged into Drupal.

Setting it up is a two-sided exchange, which is normal for SAML. You give your IdP
some details about Drupal (the SP), and you tell Drupal some details about the IdP.
On the Drupal side you enter the IdP's issuer/entity ID, its SSO login URL, and its
signing certificate. On the IdP side you register Drupal using the SP metadata the
module publishes. Once both sides trust each other, Drupal offers SP-initiated login
at `/samllogin`, receives the IdP's signed assertion at the Assertion Consumer
Service endpoint `/samlassertion`, and logs the matching user in — mapping the SAML
NameID (or a named attribute) to the Drupal username and email.

Enabling the module does not switch on SSO by itself — you must enter the IdP details
first. Once the module counts as "configured" (login enabled, plus an IdP name and
issuer set), it automatically adds a "Login using [your IdP]" link to the standard
Drupal login form. The free SP core covered here is fully usable; some advanced
features (encrypted assertions, custom SP certificates, role mapping, automatic user
provisioning) are gated behind the paid tiers. The module has no Drush commands, no
submodules, and defines no permissions of its own — its admin tabs are gated by
core's **Administer site configuration** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the SP/IdP setup tabs, the SAML
   endpoints, attribute mapping, and the sign-in options.

## Where it lives in the admin menu

The module's tabs live under **Configuration → People → miniOrange SAML**
(`/admin/config/people/miniorange_saml/…`), all guarded by **Administer site
configuration**. The **Service Provider Setup** tab is where you enter the IdP
details; the **Identity Provider Setup** tab shows the SP metadata to hand to your
IdP admin. The public SAML endpoints are `/samllogin` (start login), `/samlassertion`
(receive the assertion), and `/saml_metadata` (the SP metadata XML).
