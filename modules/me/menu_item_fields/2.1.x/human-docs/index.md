# Menu Item Fields — manual setup guide

**Menu Item Fields** (`menu_item_fields`) makes Drupal's custom menu links
(`menu_link_content`) **fieldable and renderable**, so you can attach real fields — an
icon or image, a short description, a "featured" flag, a call-to-action label — to
individual menu items and display a menu with those fields. This is the foundation for
mega menus and other rich navigation, where each menu item is more than just a text
link.

Out of the box, core treats menu links as entities but gives them no field UI and no
view modes, so there is nowhere to add fields and no way to render them. This module
fixes both: it makes the menu link's built-in fields (link, title, description, weight,
enabled, expanded) display-configurable, adds a template and view-mode rendering for
menu items, and ships a block — **"Menu with fields"** — that renders a chosen menu
through a view mode you pick. It can even let individual items override that view mode
via a dedicated field (so most items render compact but a few render as full mega-menu
panels), and it supports per-menu **form modes** so the Main menu and the Footer menu
can expose different edit fields.

To actually add fields you enable the companion **Menu Item Fields UI**
(`menu_item_fields_ui`) submodule, which switches on Drupal's Field UI for menu links —
just like core's Field UI, you can turn it off in production once the fields exist. The
module itself has **no settings page, permission, or Drush command**; the whole setup
is done through Field UI, view modes, and block placement. It depends only on core's
Menu Link Content module, and pairs well with the optional **Link Attributes** module
for adding `rel`/`target` options to menu links.

This guide is written for a **human** building fieldable menus in the admin UI. If you
want terse, token-cheap references for an AI coding agent — the block plugin, the
view-mode override field, and the theming internals — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and enable the UI submodule to build fields.

## Where it lives in the admin menu

There is no dedicated settings page. You work in a few existing places:

- **Fields on menu links** live under the **Menus** admin area
  (**Structure → Menus**, `/admin/structure/menu`) once the UI submodule is enabled,
  via the standard Manage fields / Manage form display / Manage display screens.
- **View modes** for menu links are created at **Structure → Display modes → View
  modes** (`/admin/structure/display-modes/view`).
- The **"Menu with fields" block** is placed like any block, at **Structure → Block
  layout** (`/admin/structure/block`).

## How to use it

1. **Enable the UI submodule.** Run `drush en menu_item_fields_ui -y` (or enable
   **Menu Item Fields UI** on the Extend page). This turns on Field UI for menu links.
   Like core Field UI, you can disable it again in production once your fields exist.
2. **Add fields to menu links.** From **Structure → Menus**, use the **Manage fields**
   screen for menu links to add the fields you want — an image/icon, a description, a
   boolean "featured" flag, a taxonomy reference, and so on. Menu links are a
   single-bundle entity, so the fields you add apply to every menu.
3. **Create a view mode (optional).** If you want a distinct rendering — for example a
   `mega` view mode for mega-menu panels — add it at **Structure → Display modes →
   View modes**, then arrange the fields for it on the menu link's **Manage display**
   screen.
4. **Place the "Menu with fields" block.** At **Structure → Block layout**, place the
   **Menu with fields** block for the menu you want (it is derived per menu, like
   core's system menu block). In the block's settings, choose the **view mode** used
   to render every item.
5. **Allow per-item overrides (optional).** If you added a field that stores a
   view-mode id (for example a list field whose value is `mega`), set it as the
   block's **view-mode override field** so individual items can render differently
   from the block default. You create that field yourself.
6. **Different fields per menu (optional).** To edit, say, Main-menu links with a
   different set of fields than Footer links, create and enable a menu-link **form
   mode** whose machine name matches the menu's machine name (with dashes replaced by
   underscores, e.g. `main`). The module automatically uses it when editing that
   menu's links.

To render extra fields in your theme you may need a `menu.html.twig` template; the
module ships one that themes without their own inherit. For the block plugin details
and theming, see the [`agent/`](../agent/start.md) docs.
