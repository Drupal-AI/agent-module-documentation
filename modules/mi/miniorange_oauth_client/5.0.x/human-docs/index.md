# miniOrange OAuth Client — manual setup guide

**miniOrange OAuth Client** (`miniorange_oauth_client`) turns your Drupal site
into an OAuth 2.0 / OpenID Connect **client** (a "relying party"), so users can
log in through an external Identity Provider (IdP) — Keycloak, Microsoft
Entra/Azure AD, Okta, Auth0, Google, and others — using Single Sign-On. You
configure one or more IdP connections, map the profile information the provider
returns onto Drupal user accounts, and audit every login attempt.

Each IdP connection you create records the client ID and secret, the provider's
authorize / token / userinfo endpoints, the requested scopes, the grant type,
and whether the connection speaks raw OAuth 2.0 or OpenID Connect. When a user
starts SSO, the module sends them to the provider with an anti-CSRF `state`
value stored in their session; when the provider calls back, the module verifies
that `state`, exchanges the authorization code for a token, fetches the user's
profile, maps the claims (email is required) onto a Drupal account, and logs them
in. The post-login destination is carried securely inside the session-bound
state and constrained to your own site, so it can't be tampered into an open
redirect.

An important thing to know about tiers: the **free (community) build logs in
existing users only**, matched by email. Creating new Drupal accounts on first
login, using a login attribute other than email, and role/group/profile mapping
all require a **paid license** validated against miniOrange's servers. Beyond
that, the module offers a built-in Test Connection tool (to see exactly which
claims your IdP returns before going live), login enforcement options, config
import/export, and login reporting — all under a single administrative
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create an IdP connection, register
   the callback URL, map attributes, and set login behavior.

## Where it lives in the admin menu

Everything is under **Configuration → People → miniOrange OAuth Client**
(`/admin/config/people/mo-oauth-client/…`) and is gated by the single
**miniOrange Administrator Privilege** (`mo_administrator`) permission. The
module does not add a "Configure" link on the modules page; the entry point is
the **Client Configuration** list, where you add connections. Grant that
permission only to fully trusted roles — it exposes IdP client credentials and
controls how everyone authenticates.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Add an IdP connection and copy the **callback (redirect) URL** the module
   shows you into your provider's app configuration.
3. Enter the client ID/secret, endpoints, scope, grant type, and protocol.
4. Run **Test Connection** to confirm the round-trip works and to discover the
   exact claim names your IdP returns.
5. Map the email/login claim to Drupal, enable login, and (optionally) add a
   "Login with <IdP>" button.

Each step is covered in [Configuration](configuration/index.md).
