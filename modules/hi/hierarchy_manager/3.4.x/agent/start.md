# Hierarchy Manager — agent index

Replaces core's draggable-table UI for taxonomy terms and menu links with a scalable
drag-and-drop JS tree (jsTree), and provides two plugin types so any entity/library can
plug in. Config UI: `hierarchy_manager.hm_config_form`
(`/admin/config/user-interface/hierarchy_manager/config`). Provides config schema; no
Drush; no own permissions (reuses core `administer site configuration`, `administer menu`,
`administer taxonomy` / `edit terms in <vid>`).

- **Set up display profiles, enable setup plugins, bind to bundles/menus, JSON endpoints & access** →
  [configure/config.md](configure/config.md)
- **The two plugin types (`hm_setup_plugin`, `hm_display_plugin`), how to add an entity or a display library** →
  [plugins/plugins.md](plugins/plugins.md)

Key facts:
- Shipped plugins: setup `hm_setup_taxonomy`, `hm_setup_menu`; display `hm_display_jstree`.
- Display profile = config entity `hm_display_profile` (`plugin`, `config` JSON, `confirm` bool).
- Tree data/updates via routes `hierarchy_manager.taxonomy.tree.{json,update}` (CSRF token + per-term
  `update` access) and `hierarchy_manager.menu.tree.{json,update}` (`administer menu`).
- jsTree 3.3.15 / jsoneditor 9.9.2 load from cdnjs unless self-hosted under `/libraries/…`.
