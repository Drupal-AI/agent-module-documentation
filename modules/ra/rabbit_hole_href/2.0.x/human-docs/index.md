# Rabbit Hole href — manual setup guide

**Rabbit Hole href** (`rabbit_hole_href`) is an extension to the
[Rabbit Hole](https://www.drupal.org/project/rabbit_hole) module. Rabbit Hole can
make an entity's own page redirect somewhere else (or return 403/404) — but menus,
Views, and other rendered links still generate the entity's *canonical* URL, so a
visitor clicks the link, lands on the canonical page, and is only *then* bounced to
the real destination. Rabbit Hole href closes that gap: it rewrites the generated
link so it points **directly at the Rabbit Hole redirect target**, saving the extra
hop. That means one fewer redirect for the user and cleaner links for SEO.

Behind the scenes it changes how the entity's link/URI is generated (it swaps the
URI callback and drops the canonical link template), delegating the actual
destination lookup to Rabbit Hole's own behaviour plugins. The behaviour respects
your existing Rabbit Hole configuration and can be turned on or off per bundle like
any other Rabbit Hole setting. Directly visiting a Rabbit‑Hole'd canonical URL still
behaves exactly as before — only *generated links* change.

> **Scope in this release:** the link rewriting is currently wired up for
> **taxonomy terms only**, and the maintainers describe the module as a work in
> progress — they advise against using it in production yet. If you need broader
> entity coverage today, look at the sibling module
> [Rabbit Hole Links](https://www.drupal.org/project/rabbit_hole_links).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Rabbit
   Hole and enable it.

This module has **no settings form and no permissions of its own** — it is
enable‑and‑go. All the redirect behaviour comes from your Rabbit Hole configuration.

## How to use it

1. Install and configure **Rabbit Hole**, and set the **page redirect** behaviour on
   the taxonomy terms you want to redirect.
2. Enable Rabbit Hole href.
3. Links generated for those terms (in menus, Views, fields, breadcrumbs) now point
   straight at the redirect destination instead of the term's canonical page.

A typical use case: taxonomy terms used purely as filters or as redirects to a real
landing page — the term links now jump straight to the destination rather than
loading the term page first.
