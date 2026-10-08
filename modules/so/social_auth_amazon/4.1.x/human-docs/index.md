# Social Auth Amazon — manual setup guide

**Social Auth Amazon** (`social_auth_amazon`) adds **"Login with Amazon"** to your
Drupal site, letting visitors register and sign in with their Amazon account over
OAuth 2.0. It is part of the Drupal Social Initiative and builds on the **Social
Auth** and **Social API** framework — this module contributes the Amazon‑specific
network and authentication‑manager plugins, while the shared Social Auth base
module does the heavy lifting of the redirect, callback, and user handling.

Once configured, the module adds a `user/login/amazon` path that sends the visitor
to Amazon to authenticate. When Amazon returns them, the module matches on the
Amazon user id or email address: if an account already exists with that email, or
the user has logged in with Amazon before, they are signed in; otherwise a new
account is created. An existing authenticated user can also link their Amazon
account. Login can be started from the **Amazon** button in the Social Auth block,
or from a link to `user/login/amazon` that a site builder places and themes
anywhere on the site.

The module is not usable on enable alone — you must register an application with
Amazon and enter its client ID and secret before login will work. Its only
dependency is the **Social Auth** base module. There are no submodules.

A note on security, from the module's own docs: this module has **no callback
controller of its own**, so the OAuth flow — including the `state` (CSRF)
validation on the round‑trip — is handled by the Social Auth base module's
controller, meaning it inherits the framework's standard CSRF‑protected flow
rather than re‑implementing it. Store the Amazon **client secret** as a secret
(through the framework's settings or the Key module), serve the site over HTTPS,
and review which accounts are allowed to auto‑register.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — register an Amazon application and
   enter its client ID and secret in the Social Auth settings.

## Where it lives in the admin menu

Amazon is configured as a network under the **Social Auth** framework, at
**Configuration → Social API settings → User authentication → Social Auth**
(the Amazon network settings form). Access is gated by the `administer social api
authentication` permission. See [Configuration](configuration/index.md) for the
step‑by‑step.

## How to use it

Place the **Social Auth block** (Structure → Block layout) to show the Amazon
login button, or add a themed link to `user/login/amazon` wherever you want the
login entry point to appear.
