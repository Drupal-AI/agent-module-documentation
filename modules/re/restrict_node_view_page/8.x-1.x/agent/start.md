<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Restrict node view page access (restrict_node_view_page) — agent index

**Per-content-type control of the full node view page via hook_node_access.**

- **Version:** 8.x-1.x
- **Core:** ^8.8 || ^9 || ^10
- **Depends:** node
- **Permissions:** `view all content type full node pages`, dynamic `view full node pages of <type>`

**Surface:** `.module` implements `hook_node_access()` (view op → Forbidden unless permission held); `NodePermissions` generates per-bundle permissions. No routes/services.

**Security:** fail-closed for the `view` operation (returns `AccessResultForbidden` without the permission). Minor: access result does not add a `user.permissions` cache context; and because it only governs the node-access `view` grant, code paths rendering teasers/fields outside node access are unaffected. `bypass node access` overrides as normal.
