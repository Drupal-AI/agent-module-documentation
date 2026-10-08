# GSIS OAuth2 Login — manual setup guide

**GSIS OAuth2 Login** (`gsislogin`) lets people sign in to your Drupal site with
their Greek government **GSIS** credentials (the TaxisNet identity used across
Greek public services), over OAuth 2.0. When someone logs in through GSIS, the
module matches them to an existing Drupal account or creates one, logs them in,
and copies the citizen data GSIS returns — tax id (AFM), first and last name,
father's and mother's name, and birth year — onto dedicated fields on the user
account.

The trust model is straightforward: your site is an OAuth **client** of the GSIS
identity provider. GSIS authenticates the person; your site trusts the identity
GSIS asserts and provisions a local account from it. The username of the created
account is the user id GSIS returns. A test‑server toggle lets you validate the
integration against GSIS's staging environment before going live.

Sign‑in is offered in a few ways: an icon is added to the standard login and
registration forms, a dedicated form lives at `/gsis/login`, and a placeable
"Login with GSIS" block is provided for your theme. You can also route users
straight to `/gsis` to start the flow.

One operational caution worth reading before you enable it: **uninstalling the
module deletes the GSIS user fields** (`field_gsis_taxid` and the rest) and the
data they hold. Treat uninstall as destructive for that data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — register the site with GSIS, enter
   the client ID and secret, and place the login button.

## Where it lives in the admin menu

The admin form is at **Configuration → People → GSIS OAuth2 Login**
(`/admin/config/people/gsislogin`), gated by **Administer site configuration**.
The public sign‑in entry points are `/gsis` (starts the flow) and `/gsis/login`
(the login form).

## How the login flow works

1. A user hits `/gsis` (or the login block, or `/gsis/login`). The module
   generates a one‑time OAuth **state** value, stores it in their session, and
   redirects them to GSIS to authenticate.
2. GSIS sends them back with an authorization code and the state value. The module
   **verifies the returned state against the session** before doing anything else
   — this protects the callback against cross‑site request forgery.
3. The code is exchanged with GSIS for an access token, and the user's GSIS
   profile is fetched.
4. The GSIS fields are written to the account, and the matching Drupal user is
   logged in (created first if they are new).
