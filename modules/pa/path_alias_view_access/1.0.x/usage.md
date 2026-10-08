<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Path Alias View Access provides a single permission, `access path_aliases`, that lets non-admin users view path_alias entities — most usefully when exposing them through JSON:API — without granting the broad `administer url aliases` permission (which would also allow editing every alias).

---

Core treats path_alias entities as admin-only for entity operations, so reading them via JSON:API otherwise requires an over-powered admin permission. This module implements `hook_ENTITY_TYPE_access()` for `path_alias` (via a `#[Hook]` attribute class, `PathAliasViewAccessHooks`, with legacy `.module` shims for core < 11.1). On a `view` operation it returns `AccessResult::allowedIf($account->hasPermission('access path_aliases') && $entity->isPublished())`, cached per permissions and per entity; for any other operation it returns neutral (no opinion), so it never grants create/update/delete. It also implements `hook_jsonapi_ENTITY_TYPE_filter_access()` to allow filtering among published/own aliases for holders of the permission, while leaving "among all" neutral.

The enforcement is genuinely server-side and least-privilege: access is granted only for the `view` operation, only to holders of the dedicated permission, and only for **published** aliases; it adds a cacheable dependency on the entity and caches per permissions. There is no `accessCheck(FALSE)`, no over-broad grant, and no effect on ordinary URL routing (the permission's own description notes it is not required to visit a path that has an alias — it only governs viewing the alias entity itself). Setup is simply enabling the module and granting `access path_aliases` to the appropriate role.
---
- Grant a role read-only access to path_alias entities
- Expose path aliases over JSON:API to non-admin API clients
- Let an integration read aliases without `administer url aliases`
- Avoid handing out alias-editing rights just to read aliases
- Allow a decoupled front end to fetch published aliases via JSON:API
- Filter JSON:API alias collections among published items for permitted users
- Filter JSON:API alias collections among the user's own items
- Keep alias `view` access least-privilege (view only, no mutation)
- Restrict alias visibility to published aliases only
- Give an authenticated API role scoped alias visibility
- Support core < 11.1 via the legacy hook shims
- Cache alias access decisions per permission and per entity
- Audit which role can read path_alias entities
- Combine with JSON:API resource config to publish aliases safely
- Grant service accounts read access to aliases for sync jobs
- Keep the `administer url aliases` permission reserved for true admins
- Provide alias data to a search indexer without admin rights
- Verify unpublished aliases stay hidden from permission holders
- Use the permission with Views or REST exports of path_alias entities
- Model per-role alias read access in your permission matrix
