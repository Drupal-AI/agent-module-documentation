<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable Multi Menu UI for a content type

No dedicated admin route — configuration is a per-node-type opt-in.

1. Go to **Structure → Content types → [type] → Edit**.
2. Under **Menu settings**, find the **Multi Menu UI** section.
3. Tick **Enable additional menu links** and save.
4. The module stores third-party setting `multi_menu_ui.enabled = TRUE` on the node type and auto-creates `field_additional_menu_links`.

Then, editing a node of that type:
- The primary menu link uses the normal core menu_ui checkbox (index 0).
- Use **Add another menu link** (AJAX) to add extra links (index 1+), each with its own title and parent.
- On save, `AdditionalMenuLinkSyncService` creates/updates the matching `menu_link_content` entities.

Disabling the module leaves the primary link and stored field data intact. Access is governed by standard node edit permissions; there are no module-specific permissions.
