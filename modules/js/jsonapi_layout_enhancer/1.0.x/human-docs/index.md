# JSON:API layout enhancer — manual setup guide

**JSON:API layout enhancer** (`jsonapi_layout_enhancer`) makes pages built with
**Layout Builder** far easier to consume from a decoupled front end. It builds on
top of core JSON:API and the [JSON:API Extras](https://www.drupal.org/project/jsonapi_extras)
module and adds two complementary features.

The first is a **layout data enhancer**. When a node's layout field is serialized
over JSON:API, this enhancer walks the layout's components and, for each custom
block (`block_content`) placed in the layout, loads that block by its UUID and
injects its full normalized JSON:API representation inline as `block_content_data`.
The practical payoff is that a front end can fetch a whole layout-built page —
including the data of every block on it — in one request instead of chasing down
each block individually.

The second is a **dynamic alias-to-node route**. Core JSON:API requires you to
know an entity's type and UUID to fetch it, which is awkward when your front end
only knows the URL a visitor is on. This module adds a route,
`/jsonapi/page/{langcode}/{alias}`, that looks up a node by its URL alias (falling
back to the configured site front page when no alias is given) and **redirects** to
that node's canonical `/jsonapi/node/{bundle}/{uuid}` endpoint. So your front end
can turn `example.com/new-page` into `/jsonapi/page/en/new-page` and always reach
the right resource, no matter how many new pages authors create.

Because the alias route only redirects, the actual content is still served by the
standard JSON:API node resource, which enforces its own entity access — restricted
or unpublished nodes are not disclosed by the redirect.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Layout Builder / JSON:API Extras dependencies.

There is **no dedicated settings page** for this module. The enhancer is turned on
per resource in JSON:API Extras (described below), and the alias route works as
soon as the module is enabled.

## Where it lives in the admin menu

You configure the enhancer through JSON:API Extras at **Configuration → Web
services → JSON:API → Settings / Resource types**
(`/admin/config/services/jsonapi/resource_types`). Override the resource whose
layout field you want to enrich, then enable the **layout** field enhancer on that
field.

> **Patch note (from the project):** for the `layout_builder__layout` key to appear
> in JSON:API output at all, the core JSON:API module currently needs a patch. See
> the module's project page for the issue and the patch matching your Drupal
> version.

## How to use it

Once the enhancer is enabled on a layout field and the module is on, fetch a
layout-built page by its alias and language:

```
GET /jsonapi/page/en/new-page
```

This returns the node's JSON:API document in exactly the same shape as the core
JSON:API resource URIs, but with each layout block's data inlined under
`block_content_data`. For your site's home page, set the node path under **System →
Basic site settings → Default front page**; the route uses it as the fallback when
no alias is supplied. A `resourceVersion` query parameter, if present, is passed
through to the redirect target.
