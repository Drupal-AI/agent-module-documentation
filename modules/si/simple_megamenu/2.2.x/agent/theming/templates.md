# Theming

## Theme hooks (`simple_megamenu_theme()`)

| Hook | Template | Notes |
|---|---|---|
| `simple_mega_menu` | `simple-mega-menu.html.twig` | The mega-menu entity render wrapper (file `simple_mega_menu.page.inc`). |
| `simple_mega_menu_content_add_list` | `simple-mega-menu-content-add-list.html.twig` | The "add" list of bundles. |
| `menu__simple_megamenu` | `menu--simple-megamenu.html.twig` | `base hook: menu` — the default menu rendering that emits the mega menu; the file themers usually override. |

## Suggestions

`hook_theme_suggestions_simple_mega_menu()` adds, in order:

```
simple_mega_menu__<view_mode>
simple_mega_menu__<bundle>
simple_mega_menu__<bundle>__<view_mode>
simple_mega_menu__<id>
simple_mega_menu__<id>__<view_mode>
```

`hook_theme_suggestions_menu_alter()` adds (for menus targeted by a bundle):

```
menu__<menu_name>
menu__simple_megamenu
menu__simple_megamenu__<menu_name>
menu__simple_megamenu__<menu_name>__<mega_menu_type_ids>
```

## How targeted menus get the mega-menu theme

Core renders menus with `#theme = 'menu__MENU_NAME'` from `MenuLinkTree`. To insert its own
suggestions in the right order, `hook_preprocess_block()` resets a targeted menu's `#theme` to the
base `menu`, and `hook_theme_suggestions_menu_alter()` re-adds the specific suggestions above. Net
effect: override `menu--simple-megamenu.html.twig` (or a more specific suggestion) in your theme to
control the markup, and use `has_megamenu()` / `view_megamenu()` inside it (see
[../api/entities-and-twig.md](../api/entities-and-twig.md)).

## Overriding

- Whole mega-menu markup for a menu: copy `menu--simple-megamenu.html.twig` into your theme and edit.
- Per-bundle/per-view-mode entity markup: add `simple-mega-menu--<bundle>--<view_mode>.html.twig`.
- The example submodule adds a `simple_mega_menu__megamenu` theme hook and CSS as a starting point.
