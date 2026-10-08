# Menu Link Weight — agent index

Replaces the numeric menu-link **weight dropdown** with a **tabledrag** widget on the node
edit form's Menu settings (and the menu-link UI), so editors drag items into order. Depends on
`menu_ui` + `node`. Configure route `menu_link_weight.settings`. Uses core permission
`administer site configuration` (no own permissions). No plugins, entities, or Drush.

- **The one setting (`menu_parent_form_selector`), the configure route, and the CSHS override** →
  [configure/settings.md](configure/settings.md)
- **How the tabledrag replacement works (form alter, AJAX reorder, weight recompute)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Only config: `menu_link_weight.settings:menu_parent_form_selector` — `default` or `cshs`.
- `cshs` swaps `menu.parent_form_selector` for `CshsMenuParentFormSelector` **only if** the
  `cshs` (Client-side hierarchical select) module is installed (service-provider alter). A
  config subscriber invalidates the container when the setting changes.
- Configure at `/admin/config/user-interface/menu-link-weight` (permission
  `administer site configuration`).
- Behavior lives in `.module` + three `.inc` files (`node`, `menu_ui`, `reorder`); it hides
  core's `weight` select and injects a tabledrag table of siblings.
