# JSON:API Cross Bundles — manual setup guide

**JSON:API Cross Bundles** (`jsonapi_cross_bundles`) adds collection endpoints
that span *all* bundles of an entity type at once. Core's JSON:API deliberately
exposes one resource per bundle — `/jsonapi/node/article`, `/jsonapi/node/page`,
`/jsonapi/node/event` — because different bundles have different fields and a
client usually wants to know the shape of what it's receiving. This module fills
the gap for the cases where the bundle genuinely doesn't matter and you want the
whole entity type in one request.

That matters most when you need to page or sort across the combined set. Without a
cross-bundle collection, a client has to fetch each bundle separately and merge
the results itself — which means it must know the full bundle list, must be
updated whenever a bundle is added, and, critically, **cannot produce one correct
page of results** across the types (ten separately-paged lists can't be combined
into a single, correctly-ordered page). Typical uses are a site-wide search result
set, a "latest content" feed, a sitemap generator, an activity stream mixing
types, or a migration reading everything.

Two things to be deliberate about before you adopt it:

- **Access is still per entity, and must stay that way.** A cross-bundle collection
  casts a wider net, so the same access filtering JSON:API applies per resource has
  to apply here too — a bundle the requester isn't allowed to see must not appear
  just because the collection is an aggregate. Confirm this holds for your content.
- **The response carries mixed types.** A client consuming a cross-bundle
  collection has to branch on each item's `type` rather than assume a single
  schema — which is exactly the thing core's per-bundle design was protecting
  against. Make sure that trade-off is one you actually want.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module adds cross-bundle collection
endpoints and has no settings form of its own.

## How to use it

Once enabled, the cross-bundle collection endpoints become available to your
JSON:API consumer. Your decoupled front end calls them the way it calls any
JSON:API collection — with the difference that the results span every bundle of
the entity type, so you can page and sort across the whole set in a single
request. Because each item can be a different type, have your client read each
result's `type` before deciding how to render it.
