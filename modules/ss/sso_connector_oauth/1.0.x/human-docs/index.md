# SSO Connector – OAuth 2.0 — manual setup guide

**SSO Connector – OAuth 2.0** (`sso_connector_oauth`) turns an SSO Connector
Identity Provider into a standards-based OAuth 2.0 Authorization Server and OpenID
Provider. External applications can then authenticate their users against your
Drupal site using ordinary OAuth 2.0 / OpenID Connect.

The flow is the standard Authorization Code grant. An external application sends
the user to a CSRF-protected consent form; on approval it receives an
authorization code, exchanges that code at the token endpoint for an RS256 access
token (and an OpenID Connect `id_token` when the `openid` scope is granted), and
reads scope-gated claims from the userinfo endpoint. Tokens are signed with the
RS256 keypair managed by SSO Connector core, and the public key is published as a
JWKS document alongside an OpenID Connect discovery document.

This is a defensively correct implementation. PKCE (S256) is mandatory for public
clients; the consent form is CSRF-protected with no silent auto-approval; the
authorize endpoint validates the client and `redirect_uri` and rejects
unregistered redirect URIs; `state` and `nonce` lengths are bounded; authorization
codes are single-use and atomically consumed; confidential clients are
authenticated with a constant-time secret comparison; access tokens are
audience-bound and carry only minimal claims. The `/oauth/token` endpoint is
public by design — that is normal for OAuth, and it is gated by client credentials
and PKCE rather than by a Drupal permission.

This is a submodule of the SSO Connector suite. It depends on **SSO Connector**
(`sso_connector`, which provides the RS256 keypair), core **User**, and core
**Help**, and requires Drupal 11.2 (or 12). OAuth clients can be defined either
through the optional **Consumers** entity module or through this module's own
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside SSO Connector.

## How to set it up

The main task is registering the OAuth **clients** that are allowed to
authenticate against your site — either as **Consumers** entities (if you install
the optional Consumers module) or through this module's configuration. For each
client you register its allowed **redirect URIs**; the authorize endpoint rejects
any redirect URI that is not registered, so this list is a security boundary —
keep it exact and minimal. Confidential clients also get a client secret, which
you should treat as a secret. Once clients are registered, an external application
can point its OAuth/OIDC library at your site's authorize, token, userinfo, JWKS,
and discovery endpoints to begin authenticating users.
