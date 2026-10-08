Only One for Admin Toolbar is a bundled glue submodule that keeps the Admin Toolbar Tools "Add content" menu in sync with the content types configured as Only One — labelling those that already have a node with "(Edit)".

---

This submodule has **no configuration of its own**. It reacts to the parent Only One module's
config (`onlyone.settings`). Via `hook_menu_links_discovered_alter()` it rewrites the Admin
Toolbar Tools *Add content* menu: for each content type in `onlyone.settings.onlyone_node_types`
that already has a node, its link title gets a **" (Edit)"** suffix, and when
`onlyone_new_menu_entry` is on, its link is moved under the *Add content (Only One)* parent.
It provides a small service `onlyone.admin_toolbar` (`rebuildMenu($content_type)`) called from
`hook_entity_insert/update/delete` on nodes to rebuild the menu when a configured type's node
count changes, plus an event subscriber on `onlyone.content_types_updated` that rebuilds routes
when the restricted-types list changes. It requires the `admin_toolbar_tools` and `onlyone`
modules and is meant for sites that use Admin Toolbar. Enabling it needs no setup — just install
and it works.

---

- Show "(Edit)" next to a singleton content type in the Admin Toolbar *Add content* menu when its node exists.
- Keep the Admin Toolbar "Add content" flyout consistent with Only One's restrictions.
- Move restricted content types under an "Add content (Only One)" toolbar entry when that option is on.
- Rebuild the toolbar menu automatically when a restricted type's only node is created.
- Rebuild the toolbar menu automatically when that node is deleted (so it reads "Add" again).
- Update the menu when a node of a configured type is edited.
- Rebuild routes when the list of Only One content types changes (via the event subscriber).
- Give editors a one-click path to edit the existing singleton node from the toolbar.
- Avoid duplicate "Add" links for content types that can only hold one node.
- Integrate Only One cleanly with the popular Admin Toolbar module.
- Provide the `onlyone.admin_toolbar` service for programmatic menu rebuilds.
- Ship the integration as an optional submodule so non-toolbar sites can skip it.
- Ensure the toolbar's create/edit affordance matches the actual content state.
- Keep the menu labels in the current interface language.
- Let a site use Only One with Admin Toolbar without writing custom menu-alter code.
- React to Only One configuration changes without any of its own settings.
