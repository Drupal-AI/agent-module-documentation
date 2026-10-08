# OpenID ClaveUnica — manual setup guide

**OpenID ClaveUnica** (`openid_claveunica`) lets people sign in to your Drupal
site with **ClaveÚnica**, Chile's national digital identity used by public
institutions. It builds on the contrib **OpenID Connect** module, adding a
ClaveÚnica client and a **complete‑profile** step for new users so they can fill
in any details ClaveÚnica doesn't supply before their account is finalised.

The important thing to understand about how it's built is that the OAuth/OIDC
mechanics — redirecting to the provider, the `state` parameter that protects
against login CSRF, exchanging the authorization code for tokens, and mapping the
returned identity to a Drupal user — are handled by the **OpenID Connect base
module**, not reimplemented here. This module supplies the ClaveÚnica‑specific
endpoints and the extra complete‑profile flow. That flow is access‑controlled: the
complete‑account route (`claveunica/complete-account/{user}/{client}/{hash}`) is
gated by a custom access check, and the form validates a per‑user hash before it
calls Drupal's `user_login_finalize()` — so a new user can only finish their own
profile.

Two operational essentials: store your ClaveÚnica **client ID and secret as
secrets** (environment‑backed, never committed to configuration), and keep the
**OpenID Connect** module updated, since its `state` handling is your login‑CSRF
defence.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in OpenID
   Connect, and enable the module.
2. [Configuration](configuration/index.md) — set up the ClaveÚnica client and its
   credentials in OpenID Connect.

## Where it lives in the admin menu

You configure the ClaveÚnica client through the OpenID Connect module at **People
→ OpenID Connect** (`/admin/config/people/openid-connect`). See
[Configuration](configuration/index.md).

## How to use it

Once the ClaveÚnica client is configured with valid credentials, a ClaveÚnica
login option appears for your users. New users are routed through the
complete‑profile step before their account is finalised; returning users are
logged straight in.
