<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LGMS - agent index

**Library Guide Management System** (LibGuides-style). On-disk dir `lgms`; real machine name **lgmsmodule** (files `lgmsmodule.*`). Version **10.1.2**, core `^10`; depends on `system`, `media`, `media_library`.

- Node bundles guide/guide_page/guide_box + dashboard. Public listing routes use `access content`; dashboard/creation use `access dashboard` / `create guide content`.
- Guide/box/page mutation forms use `_custom_access` handlers that load the node and check `$node->access('update'|'delete')` - access model is sound.
- Settings route `lgmsmodule.admin.config.system.lgmsmodule` (perm `administer site configuration`).
- Category: Content editing experience / Structured content & page building.
