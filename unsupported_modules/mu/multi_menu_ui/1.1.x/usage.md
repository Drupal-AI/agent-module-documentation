<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Multi Menu UI extends the core `menu_ui` "Menu settings" sidebar so a node can have more than one menu link, while the primary link stays managed by core for full backwards compatibility.
---
The primary menu link (index 0) is handled by core `menu_ui`; additional links (index 1+) are stored in a per-content-type field (`field_additional_menu_links`, an `AdditionalMenuLinkItem` field type) and rendered in the same sidebar with an AJAX "Add another menu link" button and dynamic parent selection. A sync service (`AdditionalMenuLinkSyncService`) keeps the additional field values mirrored to real `menu_link_content` entities. Enabling it per content type is opt-in: a third-party setting (`multi_menu_ui.enabled`) on the node type, set from the content-type form, auto-creates the field.

Disabling the module is safe — the primary link remains intact and no data is lost. There are no routes, permissions or public endpoints of its own; it operates entirely through node-form alters and entity CRUD, so access follows normal node edit permissions. Setup: enable the module, edit a content type, tick "Enable additional menu links" under Menu settings, then add extra links when editing nodes of that type.
---
- Give a node more than one menu link.
- Add a node to several menus at once.
- Keep the primary menu link managed by core menu_ui.
- Enable additional menu links per content type.
- Add another menu link via an AJAX button on the node form.
- Choose a different parent for each additional link.
- Sync additional links to `menu_link_content` entities automatically.
- Place a page under multiple navigation sections.
- Preserve existing single menu links (backwards compatible).
- Safely disable the module without losing the primary link.
- Auto-create the `field_additional_menu_links` field on opt-in.
- Manage extra menu links from the standard Menu settings sidebar.
- Remove an additional menu link when editing a node.
- Support nodes appearing in both a main and a footer menu.
- Reorder or reparent additional links per node.
- Keep menu links in sync when a node is updated.
