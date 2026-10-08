# Add Child Page — agent index

Adds "Add Child Page" links/tabs on menu-linked nodes that redirect to the node add form with the menu
parent pre-selected, plus a "Child Pages" listing. Menu-driven page hierarchy. Requires Token. No Drush,
no plugins. Provides config + one permission.

- **Settings keys, admin route, entry-point placement, routes/tabs, and how the redirect works** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config UI: `add_child_page.configuration_form` = `/admin/config/content/add-child-page`, permission
  `administer content types`. Config object `add_child_page.settings`.
- Content-facing routes require permission `access add child page` **and** custom access
  `AddChildPage::access` (node bundle must be in the configured `node_types`). Child-pages listing routes
  additionally require `administer menu`.
- Main route `node/{node}/child` (`AddChildPage::manage`) → redirects to `node.add/{type}` with
  `?plid=<parent menu-link uuid>&menu=<menu_name>`; `hook_form_alter()` uses those to pre-set the new
  node's Menu settings (enabled, parent, weight).
- Actual node creation goes through core's node add form, so core node-create access still applies; this
  module only adds the entry points and pre-fills the menu parent.
- Permission `access add child page` is not `restrict access: true`, but it only grants the add/list entry
  points — it does not bypass node create/edit or menu access.
