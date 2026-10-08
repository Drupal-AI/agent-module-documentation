# Speculative Loading — manual setup guide

**Speculative Loading** (`speculative_loading`) makes navigation on your Drupal
site feel near-instant by using the browser's modern **Speculation Rules API** to
**prefetch** or **prerender** the pages a visitor is likely to click next, before
they click. When the visitor does navigate, the page is already fetched (or fully
rendered) and appears immediately.

It works out of the box with no code: once enabled it automatically adds the
necessary markup to standard front-end pages. You can choose between two modes —
lightweight **prefetch**, or full-page **prerender** (faster, but heavier) — and
pick an **eagerness** level (Conservative, Moderate, or Eager) to balance speed
against resource use. You can exclude specific links by adding a `no-prerender`
CSS class, and there is a hook API and plugin system for excluding URL patterns or
extending the rules programmatically. It depends only on core's System module and
is part of the DXPR ecosystem.

**Two things to weigh.** Prerendering fetches pages **in the background**, so it
can trigger work — and analytics, and any other side effects — for pages the
visitor never actually visits. Prerender only safe, **idempotent** pages, and be
cautious with anything that has side effects on a GET request. And prefetching
increases bandwidth. Used judiciously on likely-next pages, it is a real
perceived-performance win. Note also that the Speculation Rules API is currently
supported in Chromium-based browsers (Chrome, Edge, Opera); other browsers simply
ignore the rules with no ill effect.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choosing prefetch vs prerender, the
   eagerness level, and excluding links.

## Where it lives in the admin menu

Once enabled it works immediately with sensible defaults. Its settings live at
**Configuration → Development → Performance → Speculative Loading**.
