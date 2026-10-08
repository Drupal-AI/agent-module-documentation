# Protect Views Flood Control — manual setup guide

**Protect Views Flood Control** (`protect_views_flood_control`) rate‑limits the
submissions to a View's **exposed filter form**, using Drupal's Flood API. Public
listing and search Views with exposed filters are a favorite target for scrapers
and AI crawlers that hammer the filters, trying every combination — which can pile
load onto your database or search backend. This module blunts that traffic by
capping how often a visitor can submit a display's exposed form, and optionally how
many filters (or options within a filter) they can apply at once.

When a visitor goes over the limit, well‑behaved scraper bots making normal
(non‑AJAX) requests get an HTTP **429 Too Many Requests** response with a
`Retry-After` header, so they back off. Real people using an AJAX‑driven exposed
form get a friendly "try again later" validation message instead. Importantly, the
limits only apply to actual exposed‑filter submissions — plain page loads and pager
clicks are never throttled, so normal browsing is unaffected.

There's no settings page of its own; you configure protection **per View display**,
in the *Advanced* panel of the Views UI, so you can protect a public search display
while leaving others open, and use different thresholds on different displays. IP
whitelisting (to exempt trusted crawlers and monitors) and blocked‑submission
logging are handled by its parent module, **Protect Form Flood Control**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with its parent
   module) and enable it.
2. [Configuration](configuration/index.md) — enable and tune protection on a View
   display.

## Where it lives in the admin menu

The module has no page of its own. You configure it inside the **Views** UI at
**Structure → Views** (`/admin/structure/views`) — edit a View, open its *Advanced*
panel, and use the **Flood control** section. IP whitelist and logging settings live
on the parent module's settings page (Protect Form Flood Control).

## How to use it

Edit the View display whose exposed form you want to protect, turn on flood control
in the Advanced panel, and set your window and threshold (and, optionally, a
max‑filters cap). See [Configuration](configuration/index.md) for each option.
