# JSON:API Frontend — manual setup guide

**JSON:API Frontend** (`jsonapi_frontend`) makes Drupal's JSON:API genuinely ready
to sit behind a decoupled or hybrid front end by solving the "which resource does
this URL map to?" problem. When someone visits `/about-us` on your headless site,
the front end needs to know which entity that path corresponds to and where to
fetch it from JSON:API. This module provides a reliable **path → resource router**
that resolves aliases, redirects, Views pages, language, and access checks, so the
front end can always fetch the right JSON:API URL.

It adds two things:

- **A resolver endpoint** — `GET /jsonapi/resolve?path=/about-us&_format=json` —
  which takes a front-end path and returns the matching entity and its JSON:API
  URL.
- **A routes feed** — a list of the site's routes for the front end to consume.

Security is handled thoughtfully, which is worth understanding:

- The resolver runs Drupal's normal **access checks**. Restricted or unpublished
  content resolves as "not found", so the endpoint won't hand back content the
  caller isn't allowed to see.
- The **routes feed is protected by a secret** you configure; the module compares
  it in constant time and **fails closed** when no secret is set — meaning the feed
  is not exposed until you deliberately set a secret. Setting that secret is a key
  part of setup.

As always, JSON:API itself still enforces entity and field access on the underlying
data — this module adds routing and a guarded routes feed on top of that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the routes-feed secret and tune
   the endpoints.

## Where it lives in the admin menu

The module's settings sit at **Configuration → Web services → JSON:API Frontend**
(`/admin/config/services/jsonapi-frontend`). The endpoints it serves are
`/jsonapi/resolve` and `/jsonapi/routes`.

## Optional add-ons

Several companion modules extend it — for example **JSON:API Frontend Layout
Builder** (`jsonapi_frontend_layout`) for headless Layout Builder rendering, plus
menu and webform helpers. Install whichever match your front-end needs.
