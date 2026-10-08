<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Subrequests — agent index

Adds one route, `/subrequests`, that accepts a JSON array of "subrequest" objects (a
**blueprint**) and executes them all against Drupal's own kernel, returning one combined
207 Multi-Status response. No settings form, no configure route (`configure: null`), no
config schema, no Drush commands. Its only configurable surface is a single permission.

- **Write/read a blueprint document — keys, actions, `waitFor` sequencing, the
  `{{requestId.body@$.jsonpath}}` token, response formats** →
  [api/blueprint-format.md](api/blueprint-format.md)
- **Call it from PHP / understand the services that parse and execute a blueprint
  (`BlueprintManager`, `SubrequestsManager`, `JsonPathReplacer`, `FrontController`)** →
  [api/services.md](api/services.md)
- **Who can call the endpoint — the `issue subrequests` permission, route, and supported
  auth providers** → [permissions/access.md](permissions/access.md)

Key facts: the endpoint is `/subrequests` (GET or POST), gated by the `issue subrequests`
permission; a blueprint is a JSON array, each item needs at minimum `uri` and `action`;
independent items run in parallel, items sharing a `waitFor` dependency run sequentially in
batches; the default response is `multipart/related`, add `?_format=json` for a single JSON
object keyed by `requestId`.
