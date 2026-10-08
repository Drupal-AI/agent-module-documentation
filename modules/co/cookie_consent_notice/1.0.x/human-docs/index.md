# Cookie Consent Notice — manual setup guide

**Cookie Consent Notice** (`cookie_consent_notice`) shows visitors *exactly where*
content on a page has been hidden because of their cookie settings, and gives them
a one‑click way to change those settings. Its reasoning is simple: when a cookie
manager blocks an embed (a video, a map, a social feed), the visitor often just
sees a blank space with no idea that something is missing. This module detects
those blocked elements and drops a visible notice in their place — a call to action
that lists the exact cookies required and links the visitor to update their choice.

It runs a straightforward script on each page that automatically detects the
elements prevented from displaying, so **no configuration is required** — enable it
and it works. It has been built and tested to work alongside the **Cookiebot**
module, which is the assumed companion, and it requires **jQuery** to run.

Keep the module's role in perspective: it is a **consent‑presentation / UX** tool.
It makes blocked content visible and actionable, but real compliance depends on
your cookie manager actually gating the cookie‑setting scripts — a notice alone
does not stop trackers firing. It has no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it needs no settings. Its
behavior is described under "How it works" below.

## Where it lives in the admin menu

Cookie Consent Notice adds no admin page. Once enabled it works automatically on
the front end.

## How it works

On each page view, the module's script scans for elements that were prevented from
displaying because of the visitor's cookie settings. For each one it shows a
notification in the element's place that:

- tells the visitor that content was blocked by their cookie settings,
- lists the exact cookies required to view that item, and
- provides a link the visitor can click to update their cookie settings.

It has so far been used together with **Cookiebot**; the maintainers hope to add
compatibility with other cookie‑management packages over time. Because it depends
on **jQuery**, make sure jQuery is available on the pages where you rely on it.
