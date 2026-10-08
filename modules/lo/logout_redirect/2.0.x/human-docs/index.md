# Logout Redirect — manual setup guide

**Logout Redirect** (`logout_redirect`) closes a small but real privacy gap: on
many sites, after you log out and press the browser's **Back** button, the browser
can redisplay a page from the previous authenticated session straight out of its
own cache. On a shared or public computer — a library, a lab, a kiosk — that means
the next person could glimpse content the previous user was allowed to see.

The module attaches a lightweight JavaScript that watches for a **Back**
navigation after logout and, when it detects one, redirects the visitor to the
Drupal login page (or a path you configure) instead of letting the cached
authenticated page show. It records login state in the browser's `localStorage`
and acts only on Back navigation once the user is no longer logged in.

It's deliberately simple: no dependencies, no permissions of its own, and a
single setting — the path to redirect to. If you don't configure a path, it
defaults to `/user/login`.

One thing to understand about its scope: this is a **client‑side** safeguard and a
UX improvement, not a replacement for proper cache‑control on authenticated
responses. Treat it as defence‑in‑depth alongside sensible `Cache-Control`
headers, not as the only line of defence. The redirect target is set by an
administrator (never taken from the URL), so it isn't an open‑redirect risk.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the path visitors are redirected
   to.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Logout Redirect
Configuration** (`/admin/config/logout/redirect/settings`) and requires the
**Access administration pages** permission.
