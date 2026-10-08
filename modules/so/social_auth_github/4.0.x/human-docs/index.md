# Social Auth GitHub — manual setup guide

**Social Auth GitHub** (`social_auth_github`) adds **"Log in with GitHub"** to your
Drupal site, letting visitors register and sign in with their GitHub account over
OAuth2. It is part of the Drupal Social Initiative and builds on the **Social
Auth** and **Social API** framework — this module supplies the GitHub provider
client (via the `league/oauth2-github` library) and the settings form for the
GitHub OAuth app's client ID and secret, while the shared Social Auth base module
provides the login/registration machinery. The module can request any GitHub
scopes, so it can also serve tasks that need authenticated access to GitHub
services.

Once configured, a visitor can click the GitHub logo in the **Social Auth login
block**, or follow a link to `/user/login/github` that you place and theme
anywhere on the site. GitHub returns the user to your site, and the module matches
on the GitHub user id or email: if the user has logged in with GitHub before, or
an account already exists with the same email address, they are signed in;
otherwise a new account is created. An existing authenticated user can also link
their GitHub account.

The module needs configuration before use — you register a GitHub OAuth
application and enter its client ID and secret. Its only dependency is the **Social
Auth** base module (which pulls in Social API and the OAuth2 client library), and
there are no submodules.

On security: the OAuth2 authorization‑code flow — including the `state` parameter
used for CSRF protection and the code/token exchange — is handled by the underlying
Social Auth base module and the OAuth2 client library, which is the right place for
it; this module configures and delegates to that flow rather than re‑implementing
it. Store the GitHub **client secret** as a secret, serve the site over HTTPS, and
remember that whether new accounts are auto‑created and how existing accounts are
matched is governed by the Social Auth base configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — register a GitHub OAuth app and enter
   its client ID and secret.

## Where it lives in the admin menu

GitHub is configured at **Configuration → User authentication → GitHub** (the
settings form, config `social_auth_github.settings_form`). That is where you copy
the authorized redirect URI for GitHub and enter the client ID and secret. See
[Configuration](configuration/index.md).

## How to use it

Place the **Social Auth login block** (**Structure → Block layout**) to show the
GitHub button, or add a themed link to `/user/login/github` wherever you want the
login entry point.
