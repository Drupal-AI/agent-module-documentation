<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Taxonomy Menu (stm) — agent index

Generates **menu links from a taxonomy** vocabulary's term hierarchy. Version **8.x-1.2**, core `^9 || ^10`. No dependencies.

**Shape:** one route `stm.taxonomy_vocabulary.sync_menu_form` → `/admin/structure/taxonomy/manage/{taxonomy_vocabulary}/overview/menu` (local task *Sync To Menu*), form `SyncToMenuForm`. On submit it loads the vocabulary's terms and creates menu-link entities mirroring the parent/child tree. No services/permissions/config.

**Access:** route requirement is `_entity_access: 'taxonomy_vocabulary.view'`.
