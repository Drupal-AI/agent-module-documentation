# Entity Submenu Block — agent index

A per-menu derivative block that renders the current page's child menu items as full content
entities (in a chosen view mode) rather than links. Extends core `SystemMenuBlock`. No global
config page (`configure` null) and no permissions of its own — placed/configured via *Block layout*
(`administer blocks`). Requires core `block`. Provides a config schema.

- **Block id, derivatives, every setting, build logic, theme hooks, Drush placement** →
  [configure/block.md](configure/block.md)

Key facts:
- Block plugin id `entity_submenu_block`, deriver `Plugin/Derivative/EntitySubmenuBlock` → one derivative per menu; admin label `"<Menu> (Entity Submenu Block)"`.
- Settings (schema `block.settings.entity_submenu_block:*`): `view_modes` (map entity_type→view_mode, "" = skip), `display_non_entities` (bool), `only_current_language` (bool), `show_if_empty` (bool).
- Renders child links at the active trail's current level; entity-routed links → `getViewBuilder()->view($entity, $view_mode)`; other links → `entity_submenu_item` theme (only if `display_non_entities`).
- Theme hooks `entity_submenu` (wrapper) + `entity_submenu_item` (plain link); suggestion `entity_submenu__<menu_name>`. Cached by `route.menu_active_trails:<menu>` + `route`.
