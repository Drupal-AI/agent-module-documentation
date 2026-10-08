<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group JSON:API Create Access (group_jsonapi_create_access) — agent index
**Restores JSON:API create access for `group_relationship` entities by rebuilding group context from the request body.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Depends on:** group, jsonapi
- **RouteSubscriber:** swaps `_entity_create_access` → `_group_jsonapi_create_access` on JSON:API `group_relationship--*` POST routes
- **AccessCheck:** reads `data.relationships.gid.data.id`, loads the group, then defers to Group's own `createAccess($bundle, $account, ['group'=>$group], TRUE)`
- No config; no permissions of its own.

**Security:** does NOT over-grant — it only reconstructs `$context['group']` and then calls Group's real create-access handler; denies (`forbidden`) when no valid group resolves from the body; JSON decode errors are caught and denied. Reviewed: sound.
