# JSON:API Page Limit — manual setup guide

**JSON:API Page Limit** (`jsonapi_page_limit`) lets you raise (or lower) the
maximum number of items JSON:API returns in a single response, **per route**. By
default, core JSON:API caps a collection page at 50 items — so a request like
`/jsonapi/node/article?page[limit]=51` still comes back with only 50. This module
makes that cap configurable for the specific paths you choose.

The 50-item ceiling exists for good reasons: an unbounded page size is a
denial-of-service lever and a memory risk, because every item is loaded,
access-checked, and serialized. But a single number applied to every resource is
blunt. A decoupled front end that needs a taxonomy of 200 terms to build a filter
panel has to make four requests for something that should be one, while a resource
with large, expensive items might reasonably be capped even lower. This module lets
you handle those cases individually rather than by raising a global ceiling.

The judgement to make is where the cost lands. A raised limit means more entities
loaded, access-checked, and serialized in one request, so the right ceiling is the
one your slowest resource can serve within its timeout. Raise it for the small,
cheap collections that need it — not globally — and measure rather than assume.

> **Consider `jsonapi_defaults` first.** Similar functionality is provided by the
> `jsonapi_defaults` module (part of JSON:API Extras), which is much more actively
> maintained. The key difference: with `jsonapi_defaults` the increased limit
> becomes the **default** returned unless a request asks for something else,
> whereas with JSON:API Page Limit the default stays 50 and you only get more when
> a request explicitly asks for it via `page[limit]`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. It is configured entirely in
code, via a service parameter, described below — and it does nothing until you add
that configuration.

## Where it lives in the admin menu

JSON:API Page Limit adds no admin page and has no settings form. You configure it
by declaring a service parameter in a custom `services.yml` file (a developer/
site-builder task, not an admin-UI one).

## How to use it

Define a set of paths and their maximum page sizes as the
`jsonapi_page_limit.size_max` service parameter — for example in a
`sites/default/services.yml` file (or a custom module's services file):

```yaml
parameters:
  jsonapi_page_limit.size_max:
    /jsonapi/node/page: 100
    /jsonapi/taxonomy/tags: 75
```

Rebuild the cache after editing the file (`drush cr`). Each listed path can now
return up to the limit you set — but only when a request explicitly asks for it,
for example `/jsonapi/node/page?page[limit]=100`. Paths you do not list keep the
core default of 50.

Remember the performance trade-off: raise a path's limit only as high as that
resource can actually serve within its timeout, and measure the effect before
relying on it in production.
