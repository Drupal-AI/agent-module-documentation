# content_language_access — agent start

Denies **viewing a published node** when the node's language ≠ the currently negotiated
content/site language, unless the pairing is whitelisted or the user has the bypass permission.
Implemented as a single `hook_node_access()` check. Depends on `language` + `node`. Zero config
required to start (deny-by-mismatch is on immediately); the admin form only *loosens* it.

Scope caveat: it is view-only and implements **no node-access grants**, so it does not filter
listings/search/query access.

## Capabilities

- [Configure the language matrix & bypass (admin form + config)](configure/setup.md) — the
  cross-language allow checkboxes, `access_bypass` + `route_list`, config keys/schema, and the exact
  deny logic in `hook_node_access()`.
- [Permissions](permissions/permissions.md) — `administer content_language_access settings` and
  `bypass content_language_access`.
