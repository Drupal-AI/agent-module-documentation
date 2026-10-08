Display Suite Switch View Mode lets an editor choose, per node on the node edit form, which entity view mode that node is rendered with.

---

This optional Display Suite submodule adds a control to the node form so a single node can override which view mode Display Suite uses to render it, rather than every node of a bundle sharing one display. This is handy when a few pieces of content need an alternate layout — for example a "featured" or "full width" presentation — without creating a separate content type. The available view modes are those defined for the entity, and access to the switcher is gated by dynamic permissions (`src/Permissions.php`) so only trusted roles can change a node's display. It requires the main `ds` module. Because the choice is stored per node, it deploys with content, not configuration.

---

- Render a specific node with a "featured" view mode from the node form.
- Give one landing-page node a wider layout without a new content type.
- Let editors pick a "full width" display for hero articles.
- Switch a promotional node to a card-style view mode inline.
- Allow a role to choose alternate displays only for nodes they edit.
- Present certain news items in an expanded layout while others stay default.
- Test an alternate layout on a single node before rolling it out.
- Offer editors a per-node "compact" vs "detailed" display choice.
- Override the default display for seasonal/campaign pages.
- Restrict view-mode switching to editors via the module's permissions.
- Provide a print-optimized view mode selectable per node.
- Use a distinct display for sponsored content on a per-node basis.
- Curate a homepage feature by switching one node's view mode.
- Give event nodes a special display without duplicating the content type.
- Let authors flag a node for a gallery-style presentation.
