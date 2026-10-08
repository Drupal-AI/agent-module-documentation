<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — domain menu template suggestions

`domain_menus_theme_suggestions_menu_alter()` adds template suggestions for domain menus so you can
style them differently from ordinary menus.

When a menu's theme hook original starts with `menu__dm` (i.e. an auto-created `dm<domainId>-<name>`
menu), it appends:

- `menu__domain_menu` — a suggestion shared by **all** domain menus.
- `menu__domain_menu__<name>` — where `<name>` is the last `_`-delimited part of the hook (the menu
  name portion), letting you target one named domain menu (e.g. `menu__domain_menu__main`).

So valid template files include:

```
menu--domain-menu.html.twig
menu--domain-menu--main.html.twig
```

These sit alongside the default core `menu.html.twig` suggestions; the more specific
`menu--domain-menu--<name>.html.twig` wins when present.

The module ships no templates or CSS of its own — it only registers these suggestions.
