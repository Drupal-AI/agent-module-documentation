# Google Auth SSO — manual setup guide

**Google Auth SSO** (`google_auth_sso`) extends the **Social Auth Google** module
to make Google single sign-on work the way an organisation running Google Workspace
usually wants it to. It adds two things on top of the standard Google login:

1. An optional **IP allowlist** that restricts *who can start* the Google login —
   the "sign in with Google" route and login block are blocked unless the visitor's
   client IP is in your allowed list.
2. Automatic **role synchronisation from Google Workspace**: on every login, the
   module reads the user's directory profile (the `customSchemas.Drupal.Roles`
   custom-schema field) from the Google Admin Directory API and sets that Drupal
   user's roles to match.

This is powerful for centralising access: your Google Workspace admin can control
who has which Drupal role without touching Drupal. But it is important to understand
the **trust model**, because the blast radius is large — see the caution below and
in [Configuration](configuration/index.md).

Crucially, this module does **not** implement the OAuth flow itself. The redirect
to Google, the `state`/CSRF handling, the token exchange, and matching the Google
account to a Drupal user all live in the **Social Auth Google** / **Social Auth**
dependency. This module only layers the IP restriction and the role sync on top.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Social Auth
   Google dependency with Composer, and enable it.
2. [Configuration](configuration/index.md) — configure the Google OAuth client, the
   directory scope, the IP allowlist, and the Workspace role schema.

## Where it lives in the admin menu

There is no separate settings page. You configure everything on **Social Auth
Google's** own settings form at **Configuration → Social API settings → User
authentication → Google**
(`/admin/config/social-api/social-auth/google`) — this module *adds* a **Restricted
IPs** field there. See [Configuration](configuration/index.md).

## The trust model — read this before deploying

Because roles come straight from Google Workspace, your **Workspace admin
effectively controls Drupal role assignment** for SSO users — potentially including
the `administrator` role. And the sync **replaces** a user's roles on every login:
a user whose Google profile lists no Drupal roles will be stripped of all roles.
This is by design, but it is high-impact — set up the Workspace custom schema
carefully and treat directory access as security-critical.
