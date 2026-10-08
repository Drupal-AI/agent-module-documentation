# Simple Mega Menu example — agent index

Starter-kit submodule of **simple_megamenu**. Enabling it installs a ready-made `megamenu` mega-menu
bundle so you have a working example to copy. Config + one template only; no configure route, no
permissions, no plugins, no Drush. For all runtime behaviour see the parent:
[../../../../2.2.x/agent/start.md](../../../../2.2.x/agent/start.md).

What it installs (config/install):
- **Bundle** `simple_megamenu.simple_mega_menu_type.megamenu` — label "MegaMenu",
  `targetMenu: { main: main }` (attached to the Main navigation menu).
- **Fields** on `simple_mega_menu` bundle `megamenu`: `field_image` (image), `field_image_link`
  (link), `field_image_title` (string), `field_text` (text_long), `field_links` (link).
- **Image style** `simple_megamenu`.
- **Displays/view modes**: form-display default + view-displays `before` / `after` / default
  (the parent module ships the before/after view modes).
- **Template** `simple-mega-menu--megamenu.html.twig` (renders image + title + text in the
  `before` view mode) and a `simple_mega_menu__megamenu` theme hook.

Typical use: enable → inspect/copy the bundle, fields, and template into your own bundle → optionally
disable. It adds nothing at runtime the parent doesn't already provide.
