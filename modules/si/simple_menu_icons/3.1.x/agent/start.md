<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Menu Icons — agent index

Lets editors upload an icon per **menu link** (Menu UI). The icon is stored in the menu
link's `link` options (`menu_icon`), and the module generates a CSS file that paints each
icon as a `background-image` on the matching menu item. **No config entity, no settings
page (`configure: null`), no permission, no plugin, no Drush, no config schema.**

- **How to add/store an icon on a menu link, the form field, allowed file types, and where the
  data lives** → [configure/menu-icons.md](configure/menu-icons.md)
- **How icons get rendered: the generated CSS file, the `menu-icon-<mlid>` classes, the theme
  hook and the State suffix** → [theming/output.md](theming/output.md)

Key facts: the upload widget is `icon_upload` (a `managed_file`) added to
`menu_link_content_form`; the chosen file id/uri are saved under
`$menu_link->link->first()->options['menu_icon']` (`fid`, `uri`). Generated CSS lives at
`public://simple_menu_icons_css/menu_icons_<suffix>.css`; the suffix is in State key
`simple_menu_icons_css_suffix`. Only `menu_link_content` (custom) menu links are supported —
the icon metadata rides on that entity's link options.
