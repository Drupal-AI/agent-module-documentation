<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Revision Diff (entity_revision_diff) — agent index

**Adds Diff-module visual revision comparison to Block Content, Media, Taxonomy Term and (optional) Group entities.**

- **Version:** 1.0.x (1.0.0-beta2)
- **Core:** ^10.2 || ^11
- **Requires:** diff (2.0.0-beta4+); optional: group
- **Mechanism:** hook_entity_type_alter attaches Diff's `DiffRouteProvider` + `revisions-diff`/`revision` link templates; `EntityDiffRouteSubscriber` swaps `version_history` to `EntityRevisionOverviewForm`
- **Routes:** per-entity `.revision` view + `*_revision_revert_translation` (all `_entity_access`-gated); Group routes added dynamically when group is installed
- **Permissions:** global `view|revert|delete all {type} revisions` (block_content/media/taxonomy_term static) + bundle-specific + group, via `EntityDiffPermissions`
- **Views:** `entity_revision_diff_current_vid` field

**Security:** Sound access posture — all revision routes require `_entity_access` (view/update on the underlying entity), and revision operations are additionally gated by the module's `view/revert/delete revisions` permissions. No `_access: TRUE`, no anonymous or unguarded mutating endpoints.

See [api/entity_revision_diff.md](api/entity_revision_diff.md)