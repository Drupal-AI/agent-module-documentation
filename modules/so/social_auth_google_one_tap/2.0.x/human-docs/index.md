# Social Auth Google One Tap — manual setup guide

**Social Auth Google One Tap** (`social_auth_google_one_tap`) adds Google's
frictionless **One Tap** sign‑in prompt to your Drupal site. Instead of clicking a
"Sign in with Google" button and leaving the page, an anonymous visitor sees the
One Tap prompt and can log in or sign up with a single click without navigating
away. It works alongside the standard Google OAuth2 login: a user who signs in via
One Tap ends up with exactly the same Drupal session and account as if they had
used the traditional button.

This is an enhancement of the **Social Auth Google** module and reuses its
configuration — in particular the Google Client ID — so there is no duplicate
credential setup. For anonymous users the module loads Google's Identity Services
(GSI) JavaScript, which shows the prompt; when the user signs in, Google returns a
signed **ID token (JWT)** to the browser, and the module's JavaScript posts it to a
Drupal endpoint (`/user/login/google/one-tap-callback`). The backend then hands the
verified profile to the core Social Auth user authenticator (using the
`social_auth_google` plugin), which finds or creates the account and establishes
the session. It also prevents an immediate automatic One Tap login right after a
user explicitly logs out, respecting their intent.

The module depends on **Social Auth Google** (and through it Social Auth), and
requires the **`google/apiclient`** PHP library, installed via Composer. It needs
configuration — a correctly configured Social Auth Google client ID plus a Google
Cloud setting — before the prompt appears. See
[Configuration](configuration/index.md).

On security, this module does the important thing correctly, and it is worth
knowing why. The backend controller **verifies the Google ID token server‑side**
using the official Google API client, which validates the JWT's signature against
Google's public keys and checks the audience (your client ID), issuer, and expiry,
and it logs the user in only when a valid payload is returned (mapping the verified
`sub` claim to the account). A forged or unsigned token is rejected — so it avoids
the classic One Tap pitfall of trusting a token supplied by the browser. Serve the
site over HTTPS and store your Google credentials appropriately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the
   `google/apiclient` library with Composer, then enable it.
2. [Configuration](configuration/index.md) — configure the Social Auth Google
   client ID and your Google Cloud authorized JavaScript origins.

## How to use it

Once configured, the One Tap prompt appears automatically for anonymous visitors —
there is no block to place. Signing in through it logs the user into the same
account they would get from the standard "Sign in with Google" flow.
