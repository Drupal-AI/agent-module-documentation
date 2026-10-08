<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns Entity Links (ui_patterns_entity_links) — agent index

**Turns entity link templates (canonical/edit/delete/...) into Layout Builder blocks rendered by UI Patterns components.**

- **Version:** 8.x-1.x  •  core `^9 || ^10 || ^11`  •  package User interface  •  dep: ui_patterns
- **Block:** `link_block` (deriver `LinkBlockDeriver` → `link_block:<entity_type>:<rel>`, entity + view_mode context).
- **Source plugin:** `entity_link` (`EntityLinkSource`) exposing `url` + `label` fields to UI Patterns.
- **Config (per block):** `pattern`, `pattern_mapping`, `variants`, `pattern_settings`, `label_override`, `absolute_url`.
- **Surface:** no routes/permissions/services/config entities; used via Layout Builder. `LinkBlock` is marked `@internal`.
- **Security:** no anonymous or mutating endpoints; block placement/access controlled by Layout Builder and entity access. Values are entity-derived URLs/labels rendered by UI Patterns. No security findings. See [configure/block.md](configure/block.md).