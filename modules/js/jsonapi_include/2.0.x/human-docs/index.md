# JSON:API Include — manual setup guide

**JSON:API Include** (`jsonapi_include`) rewrites Drupal's JSON:API responses so that
related entities you `include` are merged directly into the parent entity's fields,
instead of being split off into a separate top‑level `included` array. In plain terms:
it flattens the response, so a decoupled front end (or a Migrate source) can read
entity‑reference data inline without stitching linkage pointers back together itself.

Out of the box, core JSON:API returns a "compound document": the main resource only
carries `{type, id}` pointers under `relationships`, and the full related resources sit
in a sibling `included` array that your client has to cross‑reference by ID. This module
adds a response subscriber that runs over any JSON:API response and inlines each
referenced resource's attributes onto the matching field of the parent — recursively,
following whatever `?include=` paths the request asked for. So `?include=uid.user_picture`
gives you the author and the author's picture nested right where you'd expect them.

By default it transforms **every** JSON:API response. A single toggle lets you switch to
opt‑in mode, where only requests carrying `jsonapi_include=1` in the query string are
flattened — useful when you have existing consumers that expect the raw compound shape.
The module needs only core's JSON:API module (plus User) and pairs nicely with JSON:API
Extras for declaring automatic includes. Developers can customise the transformation by
overriding the parse service or subclassing `JsonapiParse`.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — the one setting (flatten everything vs.
   opt‑in) and how caching handles the two shapes.

## Where it lives in the admin menu

The single settings form sits under **Configuration → Web services → JSON:API** as a task
tab, at `/admin/config/services/jsonapi/include` (it requires *Administer site
configuration*). There is nothing else to click — once enabled, the flattening happens
automatically on your JSON:API endpoints.
