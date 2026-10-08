# Menu styling & navbar integration

The second major feature (besides render elements) is turning core Drupal menus into
UIkit navigation, and adding UIkit-specific options to menu links and navbar blocks.
It is gated by the `additional_menu_styles` config flag (default `true`; see
[configure/settings.md](../configure/settings.md)).

## Per-menu UIkit style (List / Nav / Subnav)
When `additional_menu_styles` is on, `uikit_components_entity_type_alter()`
(`includes/alter.inc`) swaps the `menu` entity add/edit form class to
`Drupal\uikit_components\Form\MenuEditForm` (extends `menu_ui`'s `MenuForm`). That form
adds these fields to every menu edit page (`/admin/structure/menu/manage/<menu>`):

| Field (form key) | Type | Options / notes |
|------------------|------|-----------------|
| `menu_style` | select | `uk-list`, `uk-list-bullet`, `uk-list-divider`, `uk-list-striped`; `uk-nav`; `uk-subnav`, `uk-subnav-divider`, `uk-subnav-pill` |
| `menu_style_list_large` | checkbox | adds `uk-list-large` (visible only for the `uk-list*` styles) |
| `menu_style_nav_style_modifiers` | select | `uk-nav-default` / `uk-nav-primary` (visible only for `uk-nav`) |
| `menu_style_nav_center_modifier` | checkbox | adds `uk-nav-center` (visible only for `uk-nav`) |
| `menu_style_wrapper_widths` | textfield | space-separated UIkit width classes applied to a wrapper element |

**Storage: Drupal state, not config.** `MenuEditForm::submitForm()` saves the values via
`UIkitComponents::setMenuStyle()` etc., which write to state keys keyed by the menu id:

- `<menu>_menu_style`
- `<menu>_menu_style_list_large`
- `<menu>_menu_style_nav_style_modifiers`
- `<menu>_menu_style_nav_center_modifier`
- `<menu>_menu_style_wrapper_widths`

Read them back with the matching `UIkitComponents::get*()` helpers (see
[api/helpers.md](../api/helpers.md)). The submit handler also calls
`drupal_flush_all_caches()`.

## Template suggestions + templates
`uikit_components_theme_suggestions_menu_alter()` inspects the saved `menu_style` and
adds suggestions so the menu renders with UIkit markup:

| Saved `menu_style` | Suggestions added |
|--------------------|-------------------|
| `uk-list`, `uk-list-bullet`, `uk-list-divider`, `uk-list-striped` | `menu__uikit_list`, `menu__uikit_list__<menu>` |
| `uk-nav` | `menu__uikit_nav`, `menu__uikit_nav__<menu>` |
| `uk-subnav`, `uk-subnav-divider`, `uk-subnav-pill` | `menu__uikit_subnav`, `menu__uikit_subnav__<menu>` |

The three base hooks (`menu__uikit_list`, `menu__uikit_nav`, `menu__uikit_subnav`) are
registered in `uikit_components_theme()` with templates in `templates/navigation/`.
Their `template_preprocess_menu__uikit_*()` functions (`includes/preprocess.inc`) build
`attributes` (adding `uk-list` / `uk-nav` / `uk-subnav` and the chosen modifier
classes) and `wrapper_attributes` (from the width classes), and add `uk-parent` to
items that have children (nav).

## Menu link item type (navbar header / divider)
`uikit_components_form_menu_link_content_form_alter()` adds a **Menu item type** select
to every menu link content form with options `Normal menu item` (`0`),
`nav_header`, `nav_divider`. The submit handler
`uikit_components_menu_link_content_form_submit()` stores the choice as the
`menu_item_type` key inside the menu link's `link` field `options`
(value `normal_menu_item` when empty). This lets a UIkit navbar render empty
header/divider links.

## Navbar block alignment
`uikit_components_form_block_form_alter()` adds a **UIkit navbar alignment** select
(`left` / `center` / `right`) to the block config form **only when the block is placed
in the `navbar` region**. The value is stored as the block's third-party setting
`uikit_components.uikit_navbar_alignment` via the entity builder
`uikit_components_form_block_form_builder()`. Config schema for it:
`block.settings.*.third_party.uikit_components.uikit_navbar_alignment` (integer).

## Notes for integrators
- All of the above hooks live in `includes/alter.inc`, loaded from the `.module` file.
- The menu-style feature depends on the `additional_menu_styles` flag being on; turning
  it off leaves the standard core menu forms/rendering in place.
- Rendering assumes the **UIkit base theme** supplies the `uk-*` CSS/JS; this module
  only emits the classes/markup.
