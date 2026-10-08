# Configuration

Menu Item Extras has no single settings screen. Configuration happens in two places:
the Field UI for menu links (to add fields and control how they render) and each
menu's own view‑modes tab. You'll need the **Administer menus and menu links**
permission (an administrator by default).

## What you get automatically

The moment the module is enabled, every menu link becomes a fieldable entity and
gains:

- a default **Body** field, and
- a **view mode** selector on the menu‑link add/edit form, so you can choose how an
  individual link renders.

So even before you configure anything, you can open a menu link at **Structure →
Menus → *[your menu]* → Edit link**, fill in the body, and pick a view mode.

## Add custom fields to menu links

Use the standard Field UI, just as you would for a content type:

1. Go to **Structure → Menu link content**
   (`/admin/structure/menu/menu_link_content/…`).
2. Use the **Manage fields** tab to add fields — images for icon/thumbnail
   navigation, text for taglines, entity references to pull in teasers or featured
   content, and so on.
3. Use **Manage form display** to arrange how those fields appear on the link edit
   form, and **Manage display** to control how they render in the menu.

## Set up per‑menu view modes

Each menu can render its links differently. Every menu exposes a **view‑modes
settings** form:

1. Go to **Structure → Menus → *[your menu]*** and open its **view modes settings**
   tab, or navigate directly to
   `/admin/structure/menu/manage/{menu}/view_modes_settings`.
2. Enable which view modes that menu (and its individual levels) may use. This is what
   lets one menu act as a plain link list while another renders as a multi‑column mega
   menu, or lets the top level of a menu look different from deeper levels.
3. Back on any menu link's edit form, use the **view mode** selector to choose which
   of the enabled view modes that specific link should use.

## Theming the result

Rendering uses dedicated templates (`menu-link-content.html.twig`,
`menu--extras.html.twig`, `menu-levels.html.twig`) and a generous set of theme‑hook
suggestions built from the view mode, menu name, level, and entity ID — for example
`menu-link-content--{menu_name}--{view_mode}.html.twig`. Copy a template into your
theme and name it after the suggestion you need to style just the menus, levels, or
view modes you care about. The `mie_demo_base` submodule (see
[Installation](../installation/index.md)) contains worked examples. For the full list
of suggestions and the menu‑tree render service, see the sibling
[`agent/`](../../agent/start.md) docs.
