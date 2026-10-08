Menu Condition adds a "Menu position" condition plugin so blocks (or anything using core's condition system) can be shown based on whether a chosen menu link — and its children — is in the current page's active menu trail.

---

The module provides a single core Condition plugin, `menu_position` ("Menu position"), and nothing else — no config entity, no settings form, no route, no services, no permissions. In a block's *Visibility* settings it adds a "Menu parent" select (built from the core menu parent form selector) listing every menu and menu link. The stored value is a single string `menu_parent` in the form `"<menu_name>:<link_plugin_id>"` (e.g. `main:standard.front_page`), or `"<menu_name>:"` when a whole menu is selected. At evaluation time the plugin loads the active trail for that menu (`menu.active_trail` service) and returns TRUE when the selected link id is in the active trail — i.e. the block shows on that menu item *and all its descendants*. Selecting a whole menu returns TRUE whenever any item of that menu is in the trail; an empty value evaluates TRUE (no restriction). The plugin also declares proper cacheability: it adds the `route.menu_active_trails:<menu>` cache context and the `config:system.menu.<menu>` cache tag. Because it is an ordinary `ConditionPluginBase`, it works anywhere Drupal evaluates conditions, most commonly the Block layout visibility UI.

---

- Show a block only within a section of the site defined by a parent menu item and its children.
- Display a contextual sidebar block on a top-level menu item and everything beneath it.
- Restrict a promotional block to pages under a specific "Products" menu link.
- Show secondary navigation only when the visitor is somewhere in the Main navigation trail.
- Reveal a "In this section" block across a whole documentation branch of the menu.
- Hide a block everywhere except under a chosen menu parent.
- Target block visibility by menu structure instead of by path patterns.
- Show a footer call-to-action only on pages belonging to a particular menu.
- Drive Layout Builder / block visibility from the active menu trail.
- Display a landing-page banner on a menu item and all its sub-pages.
- Show a help block on every page under an "Account" menu parent.
- Combine with other block conditions (roles, content types) to fine-tune where a block appears.
- Negate the condition to hide a block within a given menu branch while showing it elsewhere.
- Show region-specific navigation that follows the site's information architecture.
- Present a "You are here" widget only inside a chosen menu subtree.
- Apply the condition to a whole menu to gate a block on any menu-driven page.
- Avoid brittle URL-pattern visibility rules by keying off the menu hierarchy instead.
- Reuse the condition plugin programmatically in custom code via the plugin.manager.condition service.
- Keep block cacheability correct automatically (active-trail cache context + menu cache tag).
- Show breadcrum-like helper blocks scoped to a menu branch.
- Display different sidebar content per top-level menu section using several placements.
- Control visibility of a menu-block or menu-tree block by the current trail.
- Scope editorial callouts to a campaign menu and its children.
- Show onboarding tips only while a user is navigating a specific menu section.
