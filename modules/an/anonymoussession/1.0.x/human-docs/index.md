# Anonymous session toolkit — manual setup guide

**Anonymous session toolkit** (`anonymoussession`) is a developer building block,
not a feature you configure and use in the UI. It provides a service that gives
**anonymous (logged‑out) visitors a reliable session**, so custom code can store
and read per‑visitor data for people who are not logged in — think anonymous
shopping carts, saved preferences, or the state of a multi‑step wizard.

Under the hood it wraps Drupal's core `SessionManager` to establish and use an
anonymous session, which means session security is handled by core. On its own the
module does nothing visible; it exists so that other code can depend on it when it
needs anonymous per‑visitor state. It has no access‑control role.

There is one important trade‑off to understand before enabling it: **giving
anonymous users a session disables the anonymous page cache for those requests.**
Drupal will not serve a cached page to an anonymous user who has a session, so use
this only where the stateful behaviour is genuinely worth the caching cost, and
scope it to the paths that actually need it.

This module has no settings page — it is used from code — so there is no separate
configuration guide.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — it provides no admin pages, permissions, or blocks. It is a service that
custom code calls.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) — usually as a
   dependency of a custom module that needs anonymous session state.
2. From your own code, use the toolkit's session service to read and write
   per‑visitor data for anonymous users.
3. Keep in mind the page‑cache impact and limit its use to the relevant paths.
