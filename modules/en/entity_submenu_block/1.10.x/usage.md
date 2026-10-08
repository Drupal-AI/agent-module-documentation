Entity Submenu Block provides a derivative block (one per menu) that shows the current page's child menu items as fully rendered content entities in a chosen view mode, instead of a plain list of links.

---

The module defines a single block plugin, `entity_submenu_block`, derived per menu (like core's System Menu Block, which it extends). When placed, the block looks at the active menu trail for its menu, takes the menu level at the end of the trail, loads the enabled child links at that level, and for each link that routes to a content entity it renders the entity with a configurable per-entity-type view mode (e.g. render child `node` links as teasers). Links that are not entity routes (or external links) are optionally rendered as simple `<a>` links when the *Display non-entities* option is on. Block settings (schema `block.settings.entity_submenu_block:*`, extending `block.settings.system_menu_block:*`) are: `view_modes` (a map of entity-type → view-mode; select "- None -" to skip a type), `display_non_entities` (bool), `only_current_language` (bool, skip entities not translated in the current language), and `show_if_empty` (bool, render the wrapper even with no items — useful for a template placeholder). Output goes through the `entity_submenu` / `entity_submenu_item` theme hooks and is cached per menu active trail. There is no global config page or permission of its own — blocks are added and configured at *Structure → Block layout* (core's `administer blocks`). Requires core `block`. Two update hooks migrate legacy settings (`show_if_empty` default, and old `view_mode_*` keys into the `view_modes` map).

---

- Show a page's submenu as rendered node teasers instead of a bare link list.
- Build a "section landing" block that previews the current section's child pages as cards.
- Render child menu items of any menu (main, footer, or a custom menu) as entities.
- Choose a different view mode per entity type (e.g. `node` → teaser, `taxonomy_term` → default).
- Disable rendering for specific entity types by selecting "- None -" for that type.
- Mix rendered entities with plain links by enabling *Display non-entities*.
- Render external or non-entity routed menu links as simple `<a>` links.
- Restrict output to entities translated in the current interface/content language.
- Keep an empty block visible (with a placeholder wrapper) via *Show the block, even if empty*.
- Hide the block entirely when the current page has no child menu items (default behavior).
- Place the block only in a region/section that should surface contextual subnavigation.
- Use core Block layout visibility conditions (pages, roles, content types) to scope the block.
- Provide a sidebar "In this section" widget driven by the site menu structure.
- Surface teaser images/summaries of child pages automatically as the menu changes.
- Reuse the `entity_submenu__<menu>` template suggestion to theme a specific menu's block.
- Override `entity-submenu.html.twig` / `entity-submenu-item.html.twig` for custom markup.
- Give each menu its own derived block (admin label shows the menu name + "(Entity Submenu Block)").
- Cache-correctly render submenus that vary by the active menu trail and route.
- Replace a hand-built "related pages" view with menu-driven, always-in-sync output.
- Combine with a custom view mode to control exactly which fields appear in the submenu.
