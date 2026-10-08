# JSON:API Auto Include — manual setup guide

**JSON:API Auto Include** (`jsonapi_auto_include`) is a small convenience for
decoupled development. Normally, to have JSON:API embed related resources in a
response, you list them in the `include` query parameter by hand — which means
knowing every relationship a resource type exposes. This module lets you skip that
bookkeeping: add `jsonapi_auto_include=1` to any JSON:API request and it fills in
the `include` parameter for you, with every relationship on the matched resource
type, recursively, up to three levels deep.

It's implemented as a single request subscriber that runs just before JSON:API
resolves the request. It looks at the resource type for the path, collects its
relationship fields, and sets `include` to the full list (skipping relationships
you've disabled in JSON:API Extras and avoiding infinite loops on circular
relationships). Then it hands control back to core JSON:API — it never loads or
renders entities itself.

Two things are worth knowing:

- **It does not change access control.** The module only rewrites the `include`
  query parameter; core JSON:API still runs its normal per-resource access checks
  on every included entity. An anonymous or low-privilege client receives only the
  related resources it was already entitled to see — unauthorised includes are
  simply omitted by core. It is a convenience wrapper, not a way around
  permissions.
- **The real cost is performance.** Auto-including an entire relationship graph to
  depth 3 can produce very large, query-heavy responses. Treat it as a
  developer/prototyping aid — great for exploring an unfamiliar site's content
  model — and prefer explicit `include=a,b.c` lists in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module works the moment you enable it and
has nothing to configure. It only acts when the `jsonapi_auto_include=1` flag is
present on a request, so it stays out of the way otherwise.

## How to use it

Append `jsonapi_auto_include=1` to any JSON:API request, on either a collection or
an individual resource:

```
GET /jsonapi/node/article?jsonapi_auto_include=1
GET /jsonapi/node/article/<uuid>?jsonapi_auto_include=1
```

The response comes back with every relationship on that resource type included
(up to three levels deep). If you use JSON:API Extras with a custom base path, the
module respects your configured path prefix (default `/jsonapi`) and honours the
relationships you've disabled there. Leave the flag off for ordinary requests —
nothing changes unless it's present.
