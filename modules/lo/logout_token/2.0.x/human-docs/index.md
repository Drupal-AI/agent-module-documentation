# Logout Token — manual setup guide

**Logout Token** (`logout_token`) is a developer helper for **decoupled and
headless** Drupal setups. It adds one endpoint that returns the current user's
**logout CSRF token** at any point during their session, so a JavaScript or
mobile front end can perform a proper, CSRF‑protected logout.

Why this exists: Drupal's logout route is protected by a CSRF token, and normally
a front end only receives that token at login time. But the token can be
regenerated during the session — for example when a user resets their password —
after which the front end no longer holds a valid token and can't log the user
out cleanly. This module solves that by exposing an endpoint the front end can
call whenever it needs a fresh, valid logout token.

Once the module is enabled, the front end makes a GET request to:

```
/session/logout/token
```

and receives the logout token for the **current authenticated session**. It then
uses that token to call Drupal's CSRF‑protected logout route. The token is
produced by Drupal's own CSRF token generator and is tied to the current session,
so this **supports** the secure logout flow rather than weakening it.

There is nothing to configure — no settings form, no permissions, and no
dependencies. Enable it and the endpoint is available.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. Its
entire feature is the `/session/logout/token` endpoint, described above.

## Where it lives in the admin menu

Logout Token adds no admin page. It is consumed programmatically by front‑end code
via the `GET /session/logout/token` endpoint.

## How to use it

1. Enable the module.
2. From your decoupled front end, make an authenticated **GET** request to
   `/session/logout/token`.
3. Take the returned logout token and pass it to Drupal's logout route to end the
   session securely — most useful when the previously held token has been
   invalidated (for example after a password reset).
