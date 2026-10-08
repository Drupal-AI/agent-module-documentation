# Social Auth Apple — manual setup guide

**Social Auth Apple** (`social_auth_apple`) adds **"Sign in with Apple"** to a
Drupal site. It is a network plugin for the Social Auth framework: once configured,
visitors can register and log in with their Apple ID, and an Apple button appears in
the Social Auth Login block alongside any other providers you offer (Google,
Facebook, and so on). It also lets an already-logged-in user associate their Apple
account with their existing Drupal account. If you publish an iOS app, Apple's App
Store rules require you to offer Sign in with Apple wherever you offer other social
logins — this module is how you satisfy that on the Drupal side.

It builds on the **Social Auth / Social API** stack, so it depends on
`social_auth` (which supplies the login and callback plumbing, CSRF *state*
validation, user matching/creation, and the `administer social api authentication`
permission). Under the hood it wraps the `patrickbussmann/oauth2-apple` League
OAuth2 provider, which Composer installs for you.

Apple's authentication is unusual in a way that shapes the whole setup, so it is
worth being honest about up front. You do **not** paste in a static client secret.
Instead you supply four pieces of Apple Developer data — a **Service ID** (used as
the "Client ID"), a **Team ID**, a **Key File ID**, and the path to a downloaded
**`.p8` private key file** — and the module mints the short-lived client-secret JWT
from that key on the fly. The standard "Client secret" field is hidden and cleared
on save. That `.p8` file is a real credential: keep it out of the webroot and out of
version control. There is genuine configuration to do here (and matching setup in
the Apple Developer portal) before the button will work — nothing happens on enable
alone.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   Apple OAuth2 library) and enable the module.
2. [Configuration](configuration/index.md) — the settings form field by field, plus
   the Apple Developer portal steps and where to put the `.p8` key.

## Where it lives in the admin menu

Its settings form is at **Configuration → Social API Settings → User authentication
→ Apple** (`/admin/config/social-api/social-auth/apple`), reachable by users with
the **Administer social api authentication** permission. The login flow adds
`/user/login/apple` (the redirect that starts sign-in) and
`/user/login/apple/callback` (where Apple returns the user).

## How to use it

The overall flow: install the module, register a Service ID and a Sign in with
Apple Key in the Apple Developer portal, download the `.p8` key, then fill in the
Service/Client ID, Team ID, Key File ID, and key file path on the settings form
(copying the "Authorized redirect URL" it shows back into Apple's config). Once
saved, the Apple button appears in the Social Auth Login block and users can sign
in. See [Configuration](configuration/index.md) for the full walkthrough.
