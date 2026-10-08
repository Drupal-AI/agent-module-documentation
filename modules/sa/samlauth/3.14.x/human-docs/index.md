# SAML Authentication — manual setup guide

**SAML Authentication** (`samlauth`) turns your Drupal site into a SAML 2.0
**Service Provider (SP)**, so people can sign in through an external SAML **Identity
Provider (IdP)** such as ADFS, Azure AD / Entra ID, Okta, OneLogin, Google, or
SimpleSAMLphp. Instead of Drupal checking a local username and password, the login
is delegated to your organization's identity provider, and the validated user is
logged in to Drupal automatically.

Under the hood the module wires the well‑known OneLogin **php‑saml** toolkit into
Drupal and exposes a fixed set of `/saml/*` endpoints: `/saml/login` starts a login,
`/saml/acs` receives and validates the IdP's response, `/saml/sls` handles Single
Logout, and `/saml/metadata` publishes your SP metadata for the IdP to consume. Each
login is keyed to a stable **Unique ID** (a NameID or a named SAML attribute); on a
user's first login the module either links an existing Drupal account or creates a
new one, and can synchronize the username and email from SAML attributes on every
login. Account links are stored via the **External Authentication** (`externalauth`)
module, which SAML Authentication depends on.

Two optional submodules extend attribute handling: **SAML Authentication User
Fields** (`samlauth_user_fields`) maps arbitrary SAML attributes onto user profile
fields, and **SAML Authentication User Roles** (`samlauth_user_roles`) grants or
revokes Drupal roles based on SAML attribute or group values. For safer handling of
the SP private key, the module can read it from a **Key** entity rather than storing
it in configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   php‑saml library and External Authentication), enable it, and pick the submodules
   you need.
2. [Configuration](configuration/index.md) — the two admin forms, field by field:
   SP/IdP entity IDs, endpoints and certificates, plus login behavior and user
   mapping.

## Where it lives in the admin menu

Settings are split across two forms under **Configuration → People → SAML
authentication**:

- **`/admin/config/people/saml`** — login/logout behavior, and how Drupal creates,
  links and synchronizes users from SAML data.
- **`/admin/config/people/saml/saml`** — the SP and IdP entity IDs, endpoint URLs,
  certificates, and message signing/validation (security) settings.

Both require the **Configure SAML** permission. Account links (SAML login ↔ Drupal
user) are managed at `/admin/people/authmap/samlauth`.
