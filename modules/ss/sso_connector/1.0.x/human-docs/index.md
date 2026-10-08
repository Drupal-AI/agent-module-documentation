# SSO Connector — manual setup guide

**SSO Connector** (`sso_connector`) is the core of the SSO Connector suite. It
gives Drupal a single sign-on foundation built on an Identity Provider (IdP) /
Service Provider (SP) model: one site authenticates users, and many sites trust
it. A single admin form sets each site's role.

The problem it solves is sharing login across a family of Drupal sites without
making each one manage its own credentials. The IdP site mints short-lived,
asymmetric RS256 JSON Web Tokens signed with an RSA private key; every SP site
verifies those tokens using the IdP's public key and enforces the issuer,
audience, expiry, and single-use replay protection. The browser SSO flow runs
through a handful of routes (`/sso/login`, `/sso/return-path`, `/sso/from-idp`,
`/sso/logout`), and there is also a machine-to-machine token endpoint
(`/sso/token`) protected by a dedicated `X-SSO-Key` API key, a CIDR-aware IP
allowlist, and core flood control.

The module is built defensively. After a user logs in at the IdP, it generates a
short-lived token and redirects back to the originating SP — but only after
validating that SP against an allowlist, refusing to mint a token for a site that
is not on it, and using a trusted redirect response with a short token expiry
(around 120 seconds by default). That combination of an SP allowlist, a
short-lived signed token, and a trusted redirect is what prevents the usual
token-leak and open-redirect abuses. Every secret — the RS256 signing key and the
token API key — is read from `settings.php` or State, never from exportable
configuration, so secrets never leak into a `drush config:export`.

The security essentials are straightforward: keep the JWT signing key strong and
secret (a leaked signing key lets an attacker forge SSO tokens for any user), keep
the SP allowlist tight (only sites you control), keep token lifetimes short, and
serve everything over HTTPS.

This is the **mandatory core module** of the suite. It depends on core's **User**,
**Block**, and **Help** modules, requires Drupal 11.2 (or 12) and PHP with the
OpenSSL extension, and pulls in the `firebase/php-jwt` library automatically. The
optional capabilities — OAuth 2.0, SAML SP, social login, 2FA, cross-subdomain
cookie, permissions, cross-site sync, and SSO-aware autologout — are separate
projects you enable per site and per role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and provision the keypair.
2. [Configuration](configuration/index.md) — the single admin form that sets each
   site's IdP/SP role, the allowed service providers, and the signing key.

## Where it lives in the admin menu

A single admin form configures each site's role in the federation (IdP or SP),
the list of allowed service providers, and the signing key. After installing you
also need to generate the IdP keypair and provision the SP with the IdP's public
key — the module's own `README.md` and `docs/BUNDLE.md` walk through that step.
