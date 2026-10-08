<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UIkit Components is the companion module to the UIkit base theme. It gives themers Drupal render-API building blocks for UIkit markup — 11 render elements (`#type => uikit_accordion`, `uikit_alert`, `uikit_card`, and so on) with default Twig templates — plus per-menu UIkit styling, a navbar block alignment option and template suggestions that a theme alone cannot easily provide.

---

A base theme can style existing markup but cannot add new render elements or restructure menus from the backend, which is what this module supplies. It defines render elements in `src/Element/UIkit*.php` (registered as `uikit_<component>` theme hooks by `hook_theme()`) so developers can emit UIkit accordions, alerts, articles, badges, breadcrumbs, buttons, cards, comments, countdowns, description lists and videos from any render array, each with a default template in `templates/components/` and standard Drupal autoescaping. On top of that it lets site builders style any Drupal menu as a UIkit List, Nav or Subnav (choices stored in Drupal state and applied through `hook_theme_suggestions_menu_alter()` and the `menu--uikit-*` templates), tag menu links as navbar headers/dividers, and set a navbar alignment per block. Its settings live at `uikit_components.admin` (`configure` route, permission `administer site configuration`); the one working option, `additional_menu_styles`, toggles the menu-styling feature. There is no Twig function/filter extension here, and no custom permissions or Drush. A bundled `uikit_views` submodule adds UIkit Views style plugins. The module needs the UIkit base theme installed to supply the `uk-*` CSS/JS, and it still carries a legacy `core: 8.x` line beside `core_version_requirement: ^8 || ^9 || ^10 || ^11`, though it remains Drupal 11 compatible.

---

- Emit a UIkit alert box from a controller or block via `#type => uikit_alert`.
- Render a UIkit card with title, media, badge, header and footer.
- Build a UIkit accordion from a render array with component options.
- Output a UIkit breadcrumb trail from a list of items.
- Add a styled UIkit button (link or `<button>`, sizes, states) to output.
- Show a UIkit article layout with title, meta, lead and content.
- Display a UIkit comment block with an avatar image style.
- Add a countdown timer to an ISO-8601 expiry date.
- Render a UIkit description (definition) list, optionally divided.
- Embed a responsive UIkit video from an iframe or multiple sources.
- Style a Drupal menu as a UIkit List (bullet, divider, striped, large).
- Render a menu as a UIkit Nav with default/primary and centered modifiers.
- Render a menu as a UIkit Subnav (divider or pill).
- Wrap a menu in UIkit width classes for layout control.
- Mark a menu link as a navbar header or divider.
- Set left/center/right alignment for a block in the navbar region.
- Add UIkit template suggestions without writing theme code.
- Override any `uikit-<component>.html.twig` template in your theme.
- Alter component variables with `hook_preprocess_uikit_<component>()`.
- Keep UIkit component markup consistent across several subthemes.
- Reduce custom preprocess code in a UIkit-based theme.
- Read the installed UIkit framework version from the admin page.
- Reuse the `UIkitComponents` state helpers to read a menu's chosen style.
- Add UIkit Views style plugins (accordion, grid, list, table, etc.) via the submodule.
- Migrate a UIkit site across Drupal 8, 9, 10 and 11.
