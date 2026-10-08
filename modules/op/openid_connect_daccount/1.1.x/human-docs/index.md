# d ACCOUNT OpenID Connect Client — manual setup guide

**d ACCOUNT OpenID Connect Client** (`openid_connect_daccount`) lets people sign
in to your Drupal site with **d ACCOUNT connect** — the "d ACCOUNT" identity
provider. It's a client plugin for the contrib **OpenID Connect** module, focused
on **Business d ACCOUNT**. You could achieve Business d ACCOUNT login using OpenID
Connect's generic client, but this module does the same thing while adding the
Business d ACCOUNT‑specific settings, so you don't have to piece the details
together yourself.

What matters for security is how the work is divided. The OAuth/OIDC protocol
mechanics — the **`state` parameter that protects against login CSRF**, the
code→token exchange, and mapping the returned identity to a Drupal user — are all
handled by the **OpenID Connect base module**, not reimplemented here. This module
simply supplies the d ACCOUNT provider's endpoints, claims, and settings. That's a
sound arrangement, and it means your login‑CSRF defence is OpenID Connect's
`state` handling: keep that module updated.

Two operational essentials: store your d ACCOUNT **client ID and secret as
secrets** (environment‑backed, never committed to configuration), and serve the
site over **HTTPS** so credentials and tokens are never sent in the clear.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in OpenID
   Connect, and enable the module.
2. [Configuration](configuration/index.md) — set up the d ACCOUNT client and its
   credentials in OpenID Connect.

## Where it lives in the admin menu

You configure the d ACCOUNT client through the OpenID Connect module at
**Configuration → People → OpenID Connect**
(`/admin/config/people/openid-connect`). See
[Configuration](configuration/index.md).

## How to use it

Once the d ACCOUNT client is configured with valid credentials and endpoints, a d
ACCOUNT login option appears for your users. Signing in redirects to d ACCOUNT and
back, and OpenID Connect maps the returned identity to a Drupal account.
