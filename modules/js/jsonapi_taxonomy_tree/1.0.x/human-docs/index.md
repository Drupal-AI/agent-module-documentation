# JSON:API Taxonomy Tree — manual setup guide

**JSON:API Taxonomy Tree** (`jsonapi_taxonomy_tree`) exposes a whole taxonomy
vocabulary as a nested tree over JSON:API. Core JSON:API returns taxonomy terms as
a flat list, leaving a decoupled front end to reassemble the parent/child
hierarchy itself. This module instead adds a dedicated endpoint that returns the
vocabulary already structured as a tree, so a headless site can fetch a
category menu, a faceted navigation, or any hierarchical term list in one
structured response.

Once enabled it adds a GET endpoint at **`/api/taxonomy_tree/{taxonomy_vocabulary}`**
(where `{taxonomy_vocabulary}` is the machine name of the vocabulary you want).
It honours the usual JSON:API query parameters — `include`, `filter`, `fields`,
and so on — and it plays nicely with companion modules such as JSON:API Extras
and JSON:API Include. There is no admin settings form; the endpoint works as soon
as the module is enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

This module has **no configuration page** — it exposes an endpoint and has no
settings form.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. From your front end, request
   `/api/taxonomy_tree/{taxonomy_vocabulary}` — for example
   `/api/taxonomy_tree/tags` for a vocabulary whose machine name is `tags`.
3. The response is a JSON:API document with the terms arranged as a
   parent/child tree. Add standard JSON:API query parameters (`include`,
   `filter`, `fields`) as needed to shape the payload.

Term visibility follows the normal taxonomy access rules, so the tree only
contains terms the requesting user is allowed to see.
