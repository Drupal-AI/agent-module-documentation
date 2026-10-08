<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Path Alias View Access (path_alias_view_access) — agent index

**Adds an `access path_aliases` permission granting view access to published path_alias entities (notably via JSON:API), without the admin permission.**

- **Version:** 1.0.x  •  core: `^10 || ^11`  •  depends on `path_alias`  •  installed release 1.0.0-beta2.
- **Permission:** `access path_aliases` (permissions.yml).
- **Hooks** (`PathAliasViewAccessHooks`, autowired service; legacy `.module` shims for core < 11.1):
  - `hook_path_alias_access()` — on `view`, allows iff `access path_aliases` **and** `$entity->isPublished()`; neutral for all other operations. Cached per-permissions + entity dependency.
  - `hook_jsonapi_path_alias_filter_access()` — permission holders may filter among **published** / **own**; "among all" stays neutral.
- **Security (access-control module — verified):** enforcement is server-side via core's entity access API. Grants **view only**, permission-gated, **published-only**; no `accessCheck(FALSE)`, no over-broad grant, no create/update/delete opinion. Does not alter normal path routing. **Sound — no security findings.**
