# SSO Connector – Social Login — manual setup guide

**SSO Connector – Social Login** (`sso_connector_social`) lets anonymous visitors
log in or register with social and identity providers over OAuth 2.0 and OpenID
Connect. It ships provider plugins for Google, Microsoft (Entra ID), Okta, GitHub,
LinkedIn, GitLab, Facebook, Discord, and Twitter/X, plus a configurable generic
OAuth2/OIDC provider.

Beyond the login itself, it handles account linking and unlinking, an optional
themeable login block for anonymous users, optional auto-registration, and
optional avatar and display-name synchronisation. Each visitor signs in with the
provider of their choice through that provider's connect and callback endpoints.

Security is handled carefully throughout. Every OAuth callback validates the CSRF
`state` before finalising login, which is proper protection against login-CSRF.
For providers that issue an OpenID Connect `id_token` — Google, Microsoft, Okta,
and the generic provider when an issuer is configured — the token's signature is
verified against the provider's JWKS along with the issuer, audience, expiry, and
nonce; providers that do not issue an `id_token` (GitHub, LinkedIn, GitLab,
Facebook, Discord, Twitter/X) fall back to the provider's userinfo endpoint over
TLS. PKCE is used with every provider that supports it. Email verification is never
assumed — GitHub, for example, is treated as verified only when the primary email
is confirmed via its API. Account linking requires a password-confirmation step
and a short-lived, server-side pending link, and the optional avatar sync uses an
SSRF-guarded, size-capped, HTTPS-only fetch. Provider client secrets should be
stored securely — env-backed rather than in exportable configuration.

The module's permissions cover administration
(`administer sso connector social`) and self-service
(`manage own social accounts`).

This is a submodule of the SSO Connector suite. It depends on **SSO Connector**
(`sso_connector`), core **User**, **Block**, **Help**, **File**, and **Image**,
pulls in the `firebase/php-jwt` library automatically, requires PHP 8.1 or newer,
and runs on Drupal 11.2 (or 12).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside SSO Connector.

## How to set it up

For each provider you want to offer, register an OAuth application with that
provider (Google, Microsoft, GitHub, and so on) to obtain a **client ID** and
**client secret**, then configure those credentials in the module — storing the
secret securely (env-backed) rather than in exportable configuration. You can then
enable the optional social login block for anonymous users, and decide whether to
turn on auto-registration and avatar/display-name syncing. Grant
`administer sso connector social` to administrators and `manage own social
accounts` to users who should be able to link and unlink their own social
accounts.
