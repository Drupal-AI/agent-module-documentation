# Eloqua API Redux — manual setup guide

**Eloqua API Redux** (`eloqua_api_redux`) provides the OAuth connection and API
client for **Oracle Eloqua**, Oracle's marketing automation platform. It is
plumbing rather than a feature you see: it holds the OAuth credentials, handles
the token exchange through a callback route, and exposes a shared client that
*other* modules build on to push and pull marketing data — most notably the
[Webform Eloqua](https://www.drupal.org/project/webform_eloqua) module, which
sends form submissions to Eloqua.

Keeping the connection separate from the features that use it is the right shape.
A site usually wants several Eloqua‑touching behaviours — a webform handler, a
contact sync, a tracking call — and if each managed its own credentials you would
end up with three copies of the same client secret. This module gives them one
place to authenticate.

You will need an **Eloqua subscription** for this to do anything; if you do not
have one (or are not getting one), the module has nothing to offer. Both the
settings form and the OAuth callback are gated by the **Administer Eloqua API
settings** permission — correct for an admin‑initiated OAuth flow, where the
person completing the connection is the one who started it. Because the credential
grants access to **contact data** (personal data by any definition), keep the
configuration that stores it out of your config exports and prefer a Key entity
where supported. A submodule, `eloqua_api_auth_fallback`, ships alongside for an
alternative authentication path.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Eloqua OAuth credentials
   and complete the connection.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Eloqua API Redux**
(`/admin/config/services/eloqua_api_redux`), and the OAuth callback lives at
`/eloqua_api_redux/callback`. Both require the **Administer Eloqua API settings**
permission.
