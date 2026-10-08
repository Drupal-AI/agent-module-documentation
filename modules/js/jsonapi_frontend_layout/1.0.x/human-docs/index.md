# JSON:API Frontend Layout Builder — manual setup guide

**JSON:API Frontend Layout Builder** (`jsonapi_frontend_layout`) is an optional
add-on for [JSON:API Frontend](https://www.drupal.org/project/jsonapi_frontend)
that brings **true headless Layout Builder rendering** to decoupled sites. Instead
of keeping Layout Builder pages Drupal-rendered (the common "hybrid" compromise)
or writing a bespoke per-site API, it exposes a **normalized layout tree** — the
page's sections and components as structured JSON — so your front end can render
the layout itself.

It adds one endpoint, `GET /jsonapi/layout/resolve?path=/about-us&_format=json`,
which reuses JSON:API Frontend's alias, redirect, language negotiation, and access
checks. When the requested page uses Layout Builder, the response returns the
layout tree (sections and components) alongside the normal resolver contract. Its
current component support (the MVP) covers **field blocks and inline blocks**,
returning JSON:API references for block content where possible — so your front end
can fetch the referenced resources and render each piece.

Because it builds directly on JSON:API Frontend, the same access behaviour applies:
resolution runs Drupal's access checks, and the underlying entity data is still
served and access-controlled by core JSON:API. This module adds the layout
structure on top; it introduces no access control of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   JSON:API Frontend / Layout Builder dependencies, then enable it.

There is **no configuration page** for this module. Setup is a matter of enabling
Layout Builder on the bundles you want exposed and then calling the endpoint, as
described below.

## Where it lives in the admin menu

The module adds no admin page of its own. The one Drupal-side step is enabling
Layout Builder per bundle at that bundle's **Manage display** — for example
**Structure → Content types → *(type)* → Manage display**, where you tick **Use
Layout Builder**.

## How to use it

1. Install and enable this module together with **JSON:API Frontend** and core
   **Layout Builder** (see [Installation](installation/index.md)).
2. Enable Layout Builder for a bundle's display: on the bundle's **Manage
   display**, turn on **Use Layout Builder**, then lay out the page.
3. From your front end, request
   `GET /jsonapi/layout/resolve?path=/your-page&_format=json`.
4. Use the returned layout tree to render the sections and components, and fetch
   any referenced JSON:API URLs it hands back (for block content).

The maintainers publish example renderers — Next.js and Astro starters, and a
TypeScript client helper — to consume this endpoint; see the project page if you
want a reference front-end implementation.
