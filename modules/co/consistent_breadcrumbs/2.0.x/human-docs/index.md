# Consistent Breadcrumbs — manual setup guide

**Consistent Breadcrumbs** (`consistent_breadcrumbs`) is a **pluggable breadcrumb
API** — a better foundation for building breadcrumbs, in the spirit of the old
Drupal 7 "Crumbs" module. Instead of each part of your site producing breadcrumbs
its own way (or producing none), it installs a breadcrumb manager that assembles a
consistent trail across routes: it resolves each path segment to a real route,
looks up that route's proper **title**, and drops any segment the current user
**cannot access**, so the breadcrumb links are both correctly labelled and safe to
show. It has no dependencies beyond core and supports Drupal 9 and 10.

The important thing to understand is that this is an **API / infrastructure
module**, not a click‑to‑configure feature. It has **no admin page, no settings
form, and no routes of its own**. Enabling it replaces the default breadcrumb
assembly with its manager, and out of the box its built‑in path‑based builder will
generate breadcrumbs automatically. Beyond that, you extend and customise it in
**code** — by writing your own breadcrumb builder plugins — not through the UI.

Under the hood, the manager registers as a high‑priority core `breadcrumb_builder`
and delegates to a collection of tagged `consistent_breadcrumb_builder` plugins,
falling back through a path‑based builder and finally a trivial builder so there is
always a result. Results are cached, and a routing helper resolves titles and
checks access for each segment.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — and see
[`agent/extend/builders.md`](../agent/extend/builders.md) for how to write your own
breadcrumb builder.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — this is an API module. It works on enable via
its path‑based builder, and any customisation is done in code (see "How to use it"
below).

## Where it lives in the admin menu

Nowhere — the module exposes no admin UI, no routes, and no permissions. Once
enabled it simply takes over breadcrumb assembly site‑wide.

## How to use it

- **Just enable it** to replace Drupal's default breadcrumb assembly. The built‑in
  path‑based builder produces breadcrumbs automatically, with titles resolved from
  each route and inaccessible segments removed.
- **Extend it in code** when you need custom logic for particular routes. Register
  a service tagged `consistent_breadcrumb_builder` (with a priority to order it
  among the others) that implements the builder interface and returns breadcrumb
  items with resolved titles. A higher priority lets your builder take over
  specific routes; lower‑priority path‑based and trivial builders remain as
  fallbacks. The step‑by‑step developer recipe is in
  [`agent/extend/builders.md`](../agent/extend/builders.md).
