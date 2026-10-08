# OIDC Refresh — manual setup guide

**OIDC Refresh** (`oidc_refresh`) solves a specific, annoying problem: on sites that
use [OpenID Connect Client](https://www.drupal.org/project/oidc) (`oidc`) for login,
an editor can spend a long time filling in a form, and if their OIDC access/refresh
token expires before they submit, they lose their work.

The OIDC module checks whether tokens need refreshing on every request — but if the
user is just typing into a form and not loading new pages, no requests happen, so no
refresh happens. OIDC Refresh fixes that by making a small **AJAX request every *x*
seconds** (configurable), which triggers the OIDC module's normal refresh logic and
keeps the session alive. Optionally, it only fires the request when the user has
actually interacted with the page — mouse move, click, touch, scroll, or keypress —
so a genuinely idle tab doesn't keep a session alive forever.

It's a thin helper: the actual **token and session handling stays entirely inside the
OIDC module**. OIDC Refresh stores no tokens of its own — it only pokes the OIDC
module on a timer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside OIDC.
2. [Configuration](configuration/index.md) — set the refresh interval and the
   interaction‑only option.

## How to use it

Once enabled and configured, OIDC Refresh works in the background for logged‑in OIDC
users — there's nothing for end users to do. Set a sensible interval and, ideally,
turn on the interaction‑only option (see [Configuration](configuration/index.md)).
