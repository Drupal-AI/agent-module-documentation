<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dynamic Menu Item maintains a single admin-configured menu link that editors repoint to a node by ticking a checkbox on the node edit form.

---

Dynamic Menu Item (machine name `dynamic_menu_item`) provides one "dynamic" menu link whose display attributes — title, description, parent menu/item, and weight — are set once by an administrator at `/admin/structure/menu/dynamic_menu_item`. The administrator also picks which content types expose the feature. On the edit form of a node of an enabled content type, the module adds a checkbox (labelled with the configured "option title"). When an editor ticks the box and saves the node, the module creates or updates a `menu_link_content` entity so that this one menu link now points at `internal:/node/<nid>` — the node just saved. Because the same link (matched by its configured title and weight) is reused, only one node is ever the target at a time: the link always tracks the most recently flagged node. The module depends on core `menu_ui` and `menu_link_content`, ships an admin form (`DynamicMenuItemAdminForm`), a settings config object (`dynamic_menu_item.settings`), a `hook_form_node_form_alter()` integration, and two permissions. It provides no entities, plugins, services, or Drush commands.

---

- Keep a "Featured page" menu link that editors can retarget to a new landing node without touching the menu UI.
- Maintain a "Latest announcement" nav item that always points at the most recently published announcement node.
- Let a marketing team swap the destination of a prominent header link by editing a node instead of asking a site admin.
- Provide a "Current campaign" menu link that jumps to whichever campaign node is flagged this month.
- Point a "Home"-style link at a chosen node of a specific content type and change it later from the node form.
- Configure the dynamic link's parent so it nests under an existing menu item in the main navigation.
- Restrict the dynamic-item checkbox to a single content type (e.g. `landing_page`) so only those nodes can claim the link.
- Enable the feature on multiple content types so editors of articles or pages can both retarget the link.
- Set a descriptive menu link title and description once, centrally, and let editors control only the destination node.
- Give the dynamic link a specific weight so it sorts predictably among sibling menu items.
- Rename the node-form checkbox label (the "option title") to something meaningful for editors, e.g. "Set as featured page".
- Use it to keep a footer link (in a custom menu) pointed at a rotating policy or notice node.
- Preconfigure the target node by entering a Node ID directly in the settings form (the "Node ID" field) instead of via a node save.
- Delegate day-to-day menu-target changes to content editors while reserving menu structure/config to administrators.
- Repoint the link simply by opening any enabled-type node, ticking the box, and saving — no menu administration needed.
- Track the "most recent" of a category (e.g. events) by having editors tick the box on the newest node.
- Restrict the settings/administration screen to trusted roles via the `administer dynamic menu item` permission.
- Grant editors the `edit dynamic menu item` permission to signal who is intended to change the link target.
- Attach the dynamic link to any menu available on the site (main, footer, or a custom menu) through the parent selector.
- Combine with core menu blocks so the retargeted link appears wherever that menu is rendered.
- Avoid maintaining a redirect or a hardcoded path when the destination node changes frequently.
