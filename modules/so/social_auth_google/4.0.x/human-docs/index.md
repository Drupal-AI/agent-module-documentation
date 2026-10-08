# Social Auth Google — manual setup guide

**Social Auth Google** (`social_auth_google`) lets visitors register and log in
to your Drupal site with their **Google account**. It plugs Google's OAuth2 into
the **Social Auth** framework, so you get a "Log in with Google" button without
writing any authentication code — faster signup for consumer sites, one‑click
single sign‑on for an intranet, and fewer password‑reset support requests.

This module is a **provider** for the Social Auth framework: it adds the Google
specifics (the OAuth network plugin, a manager service, and a settings form),
while all the shared work — the login/callback routing, matching returning users
to existing Drupal accounts, and creating new accounts from Google profile
data — is handled by the base **Social Auth** and **Social API** modules. That
means you install those alongside it, and this module just teaches them how to
talk to Google.

Setup has two halves: create an **OAuth 2.0 client** in the Google Cloud console
(which gives you a Client ID and Client Secret and where you register your site's
callback URL), then paste those credentials into the module's settings form. The
`openid`, `email`, and `profile` scopes are always requested; you can add extra
scopes and API endpoints, and you can restrict sign‑in to a single Google
Workspace domain so only your organization's accounts may log in.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the Social Auth dependency.
2. [Configuration](configuration/index.md) — create the Google OAuth client and
   enter the credentials.

## Where it lives in the admin menu

The settings form appears as the **Google** tab under the Social Auth
integrations, at **Configuration → Social API settings → User authentication →
Google** (`/admin/config/social-api/social-auth/google`).

## How to use it

Create a Google OAuth client, set its authorized redirect URI to your site's
Social Auth Google callback, and paste the Client ID and Secret into the settings
form. The Social Auth framework then shows a Google login option in the
login/registration flow, and returning users are matched to their Drupal account
by email. See [Configuration](configuration/index.md) for the step‑by‑step.
