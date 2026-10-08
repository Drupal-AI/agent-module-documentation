# Unpublished 404 — manual setup guide

**Unpublished 404** (`unpublished_404`) makes an unpublished node return **404 Not
Found** instead of **403 Forbidden** to visitors who aren't allowed to see it. That small
change matters for security: a 403 quietly confirms that *something* exists at a URL,
whereas a 404 looks identical to a page that was never there. It works automatically with
**zero configuration** — enabling the module is the entire setup.

By default, Drupal answers a request for an unpublished node that the current user can't
view with a `403 Access Denied`. A crawler, scraper, or curious visitor probing sequential
`/node/N` URLs can use those 403s to enumerate which node IDs are "taken but hidden" — a
soon‑to‑launch landing page, an embargoed press release, a draft in review. This module
intercepts those 403s: if the current user lacks the *view own unpublished content*
permission, the request resolved to a node, and that node is unpublished, it replaces the
response with a 404. Published nodes, users who legitimately have the permission, and
non‑node 403s are all left untouched.

The whole module is one exception subscriber. There is no settings page, no configuration,
no permissions of its own, no Drush command, and no dependencies beyond core — it's a
drop‑in hardening measure that saves you writing the same event‑subscriber boilerplate
yourself. The behaviour is global once enabled; there's no per‑content‑type toggle or
allowlist.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There is nothing to configure — installing and enabling the module *is* the setup. Once
on, the behaviour applies site‑wide automatically:

- An unpublished node returns **404** to a visitor who can't see it (instead of 403), so
  the node's existence isn't leaked.
- A **published** node behaves normally.
- A user who has the core **view own unpublished content** permission (or a stronger
  bypass) still gets the normal 403/redirect and can reach their own drafts — they do
  **not** get a 404. This is what lets an editorial workflow keep working: give reviewers
  the permission, and the public gets a clean "not found".

Only nodes are affected, and only HTML responses — 403s for other entity types, arbitrary
routes, or JSON/API requests are not converted. To confirm it's working, log out (or use a
role without the permission) and visit the URL of an unpublished node: you should get a 404
page rather than "Access denied".
