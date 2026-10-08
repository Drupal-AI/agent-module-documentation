<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Machine Name (emn) — agent index
**Adds a read-only "Machine name" column to the content-type, vocabulary, role and block-layout admin tables.**

- **Version:** 1.0.x
- **Core:** ^8.8.0 || ^9 || ^10
- **Mechanism:** `hook_entity_type_alter` swaps `node_type` list builder to `src/ContentListBuilder.php`; `hook_form_FORM_ID_alter` for `block_admin_display_form`, `taxonomy_overview_vocabularies`, `user_admin_roles_form` (see `emn.module`).
- **Routes/permissions/services:** none.
- **Security:** no routes or permissions of its own; columns appear only on core admin pages already gated by their administer permissions. Read-only, no mutation.