# simpleSAMLphp Authentication — manual setup guide

**simpleSAMLphp Authentication** (`simplesamlphp_auth`) lets Drupal users log in
through a remote SAML identity provider — an enterprise directory such as Azure AD,
Okta, ADFS, Shibboleth or a university federation — via a locally installed
simpleSAMLphp service provider. It turns your Drupal site into a SAML service
provider, so users authenticate at the central identity provider and your site trusts
its signed assertion instead of holding local passwords.

Built on the mature simpleSAMLphp PHP library, the module delegates login to the
configured identity provider, maps the SAML attributes it returns onto Drupal
accounts, and can just-in-time provision users on their first login. It supports
automatic role assignment from SAML attributes and a "dual mode" where traditional
Drupal accounts and SAML accounts coexist. Through simpleSAMLphp it can also front a
range of protocols beyond pure SAML (Shibboleth, and others). It depends on core's
**User** module and the contributed **External Authentication** (`externalauth`)
module. Its companion project `simplesamlphp_custom_attributes` maps additional SAML
attributes onto user fields.

**Where the security actually lives.** This is a sound, widely used module, and the
security-relevant work is configuration, not code. SAML security rests on assertion
trust — the service-provider metadata, the identity provider's certificate, and how
assertions are validated — and all of that sits in the simpleSAMLphp configuration
*outside* Drupal. Getting the certificate, entity ID and signature-validation settings
right is what makes the trust real; a service provider that does not validate
assertion signatures is the classic SAML hole. Inside Drupal, the two permissions
this module adds — **Administer simpleSAMLphp authentication** and **Change SAML
authentication setting** — are high-privilege (they govern how everyone logs in) and
belong to trusted administrators only.

> **Maintenance note from the maintainer:** this project is minimally maintained and
> has a complex, version-specific dependency chain (Symfony, Guzzle and more) that can
> be slow to track core and may conflict with `drupal/core-recommended`. The
> maintainer suggests reviewing whether a lighter alternative such as **SAML
> Authentication** meets your needs before adopting it.

This guide is written for a **human** setting SSO up through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies,
   and enable it (with the crucial prerequisite: a working simpleSAMLphp service
   provider).
2. [Configuration](configuration/index.md) — the module's settings form and the
   things you must get right.

## How to use it

Once configured and activated, users reach SAML login through the module's login link
(a "Federated login" link on the user login form) or the SAML login route. The real
setup work is standing up and configuring the simpleSAMLphp service provider itself —
see installation and configuration.
