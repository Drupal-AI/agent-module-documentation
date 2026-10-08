<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UIkit Components (uikit_components) — agent index

Companion module for the **UIkit base theme**. It gives themers Drupal render-API
building blocks for UIkit markup: 11 render **elements** (`#type => uikit_*`) with
default Twig templates, per-menu UIkit styling (List/Nav/Subnav), a navbar block
alignment setting, and template suggestions. Requires core `link` and
`menu_link_content`. There is **no** Twig extension/function/filter here — output is
produced by render elements + `hook_theme()` templates using normal Drupal
autoescaping.

Configure route: `uikit_components.admin` (`/admin/config/user-interface/uikit_components`,
permission `administer site configuration`). No custom permissions. No Drush. Ships
`config/schema`. A `uikit_views` submodule (Views style plugins) exists and is
documented separately.

- **Use the UIkit render elements (accordion, alert, card, …)** → [theme/render-elements.md](theme/render-elements.md)
- **Style a Drupal menu as UIkit List/Nav/Subnav; navbar block alignment** → [theme/menu-styles.md](theme/menu-styles.md)
- **Configure the module (settings form, config, schema)** → [configure/settings.md](configure/settings.md)
- **Call the helper API (UIkitComponents, ImageStyleRenderer, MimeStreamWrapper)** → [api/helpers.md](api/helpers.md)

## Key facts
- Render element `#type`s: `uikit_accordion`, `uikit_alert`, `uikit_article`,
  `uikit_badge`, `uikit_breadcrumb`, `uikit_button`, `uikit_card`, `uikit_comment`,
  `uikit_countdown`, `uikit_description_list`, `uikit_video`
  (classes in `src/Element/UIkit*.php`, `@RenderElement` annotation).
- Theme hooks: `uikit_<component>` (registered for every name in
  `UIkitComponents::getRenderElementList()`), plus `menu__uikit_list`,
  `menu__uikit_nav`, `menu__uikit_subnav`. Templates in `templates/components/` and
  `templates/navigation/`.
- Config object: `uikit_components.settings` → key `additional_menu_styles` (bool,
  default `true`). Placeholder config objects `uikit_components.core` /
  `uikit_components.advanced` (forms currently render empty fieldsets).
- Routes: `uikit_components.admin`, `uikit_components.core`, `uikit_components.advanced`
  (all require `administer site configuration`).
- Service: `uikit_components.route_subscriber` (`RouteSubscriberBase`, currently a no-op).
- Helper class: `Drupal\uikit_components\UIkitComponents` (static methods; menu style
  is stored in Drupal **state**, not config).
- Block third-party setting: `uikit_components.uikit_navbar_alignment` (added to blocks
  in the `navbar` region).
- Menu link option: `menu_item_type` (`normal_menu_item` / `nav_header` / `nav_divider`),
  saved on `menu_link_content` link options.
- Submodule: `uikit_views` (depends on `views`; provides UIkit Views style plugins).
