<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Frontend makes Drupal JSON:API frontend-ready with client helpers.

---

JSON:API Frontend **makes Drupal JSON:API frontend-ready** for decoupled clients — providing a
`/jsonapi/resolve` endpoint that maps a front-end path to its entity + JSON:API URL, and a `/jsonapi/routes`
feed of the site's routes for the front-end. It depends on core JSON:API and Path Alias, provides its own
permissions, in the Web services package.

Use it to bootstrap a decoupled front-end against JSON:API. It is a decoupled feature and its public endpoints
are **guarded correctly**: `/jsonapi/resolve` is anonymous-reachable but the resolver **checks
`$entity->access('view')`** (and view access) before returning anything, so it won't resolve to content the
caller can't see; `/jsonapi/routes` is protected by a **configured secret** compared with **`hash_equals`**
(constant-time) and fails closed when no secret is set. Set the routes-feed secret, and remember JSON:API itself
enforces entity/field access on the data. It has no access-control role beyond that. Configure the endpoints and
secret.

---

- Make JSON:API frontend-ready.
- Resolve a path to its entity + JSON:API URL.
- Provide a routes feed.
- Depend on core JSON:API and Path Alias.
- Provide its own permissions.
- Serve decoupled clients.
- CHECK entity view access in the resolver.
- Not resolve to unviewable content.
- Protect the routes feed with a secret + hash_equals.
- Fail closed when no secret is set.
- Rely on JSON:API entity/field access for data.
- Configure the endpoints and secret.
- Handle JSON:API frontend.
- Resolve paths.
- Configure the secret.
- Serve routes.
- Handle the integration.
- Bootstrap decoupled.
- Set the secret.
- Provide a JSON:API frontend layer.
