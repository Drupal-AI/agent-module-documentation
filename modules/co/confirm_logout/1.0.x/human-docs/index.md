# Confirm Logout — manual setup guide

**Confirm Logout** (`confirm_logout`) adds a confirmation step before a user is
logged out. Instead of the logout link ending the session the instant it is
clicked, the user lands on an "are you sure you want to log out?" page and has to
confirm — so an accidental click no longer drops someone out of their session
mid‑task. The confirmation title and message are configurable and support
**tokens**, so you can personalise or brand the page (for example greeting the user
by name, or including the site name).

It depends on the **Token** module, provides its own permission for reaching the
settings form, and limits its confirm routes to logged‑in users only. The logout
itself still goes through Drupal's normal user logout flow — this module simply
puts a confirmation in front of it. It supports Drupal 9 and 10.

One thing to be aware of before deploying: this project is **not covered by
Drupal's security advisory policy**. That does not mean it is unsafe, but security
issues in it are not handled through the official process, so weigh that for
public‑facing production sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Token dependency.
2. [Configuration](configuration/index.md) — set the confirmation title and
   message (with tokens).

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → People → Confirm
Logout** (`/admin/config/people/confirm-logout`). The confirm page itself is
served at `/confirm/logout` (and `/confirm-logout`) and is only reachable by
logged‑in users.
