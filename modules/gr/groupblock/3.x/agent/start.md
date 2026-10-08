<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Block (groupblock) — agent index

**Adds core custom blocks (`block_content`) to the Group module as a `group_block` relationship so blocks are owned and access-controlled per group.**

- **Version:** 3.x
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** block, block_content, group
- **Plugins:** group relation `group_block` (`GroupBlock` + `GroupBlockDeriver`, one derivative per block_content bundle); relation handler `GroupBlockPermissionProvider`.
- **Routes:** `group/{group}/block/add`, `group/{group}/block/create` (cloned from core group-relationship routes). Group permission `access group_block overview`; shipped view `views.view.group_blocks`.

**Security:** access is delegated to the Group module's per-group permission system (`entity_access = TRUE`); the added routes are clones of core group-relationship routes and keep their access checks. No security findings.

See [configure/groupblock.md](configure/groupblock.md) for enabling the relation and the routes/permissions.
