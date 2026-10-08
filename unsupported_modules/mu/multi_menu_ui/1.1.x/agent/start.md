<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multi Menu UI (multi_menu_ui) — agent index

**Lets a node have multiple menu links by extending the core Menu settings sidebar.** Project machine name: `multimenuui`.

- **Version:** 1.1.x (1.1.0)
- **Core:** ^10 || ^11 || ^12
- **Depends:** link, menu_link_content, menu_ui, node
- **Mechanism:** `hook_form_node_form_alter` adds an AJAX multi-link UI; primary link stays with core menu_ui; extras stored in `field_additional_menu_links` (`AdditionalMenuLinkItem`).
- **Service:** `multi_menu_ui.sync_service` (`AdditionalMenuLinkSyncService`) mirrors extras to `menu_link_content` entities.
- **Enable per type:** node-type third-party setting `multi_menu_ui.enabled` (auto-creates the field).
- **Security:** no routes, permissions or public endpoints; works through node-form alters and entity CRUD, so access follows normal node-edit permissions; safe to disable (primary link preserved).

See [configure/enable.md](configure/enable.md).
