# JSON:API Book — manual setup guide

**JSON:API Book** (`json_api_book`) teaches Drupal's JSON:API about core's **Book**
module. Normally, when you fetch a node over JSON:API, the response tells you
nothing about where that node sits in a book's outline. This module extends the
JSON:API output so that a node which belongs to a book also carries its **book
structure** — the hierarchy and navigation information from core's Book module — in
the same JSON stream.

That makes it especially useful for **headless / decoupled** sites: a front‑end
application (React, Vue, a mobile app) can retrieve a book page and, in the same
request, learn about the book it belongs to and how to navigate it, without extra
round‑trips or custom endpoints.

There's nothing to configure — enable the module and the extra book data appears
in the relevant JSON:API responses. As with all JSON:API output, the exposed data
respects JSON:API's own access control and does not bypass entity access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core's JSON:API and Book modules.

There is **no configuration page** for this module — it works automatically once
enabled.

## How to use it

1. Make sure core's **Book** module is enabled and you have at least one node that
   belongs to a book.
2. Request that node through JSON:API (for example
   `/jsonapi/node/{type}/{uuid}`).
3. The response now includes the node's book structure alongside its usual fields —
   your decoupled front end can read it directly to build book navigation.
