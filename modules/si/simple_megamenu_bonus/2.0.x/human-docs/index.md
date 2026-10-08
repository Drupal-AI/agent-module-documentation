# Simple megamenu bonus — manual setup guide

**Simple megamenu bonus** (`simple_megamenu_bonus`) is an add‑on that extends the
**Simple Megamenu** module with extra flexibility for building mega‑menu layouts. On
its own it does nothing — it layers enhancements on top of Simple Megamenu, so you
need that module in place first. It affects how mega menus are built and displayed,
not access control.

Its main additions are practical layout improvements. It extends mega‑menu item
entities with a **view mode selector**, so you can choose a different view mode for
every single mega‑menu item — and it provides a Twig function,
`view_megamenu_bonus(menu_item, menu_item_below_rendered)`, that renders each item in
its selected view mode. It also adds the (optional) child menu items below a parent
entry as a **computed field**, which removes Simple Megamenu's dependency on separate
"before"/"after" view modes and lets you move those below‑items freely within the
mega‑menu field display — or disable their output entirely. This makes mega‑menu item
layouts far more flexible to arrange. It additionally carries a temporary theme‑
suggestion fix that will be dropped once the corresponding patch lands in Simple
Megamenu.

The module targets **Drupal 10.3 and 11**. A note from the maintainer: it is
minimally maintained with no further development planned, and it exists as an optional
extension in the hope that its ideas might one day merge into Simple Megamenu itself.
Because setup involves copying a Twig template into your theme and arranging field
displays, it is best suited to site builders comfortable working with Simple
Megamenu's display configuration — read Simple Megamenu's own documentation alongside
this guide, since this module simply extends its logic.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Simple Megamenu)
   with Composer and enable it.

## How to use it

Setup builds directly on Simple Megamenu, so have it working first, then:

1. **Install both modules** — Simple Megamenu and Simple megamenu bonus.
2. **Copy the template.** Copy
   `simple_megamenu_bonus/templates/menu--simple-megamenu.html.twig` into the
   `templates` directory of your theme.
3. **Clear caches** so Drupal picks up the new template.
4. **Read Simple Megamenu's documentation** — this module extends its logic, so the
   base concepts come from there.
5. **Configure your mega‑menu type(s) and field displays** — for example at
   `admin/structure/simple_mega_menu_type/megamenu_default/edit/display`. Move the
   **"Submenu (menu items below)"** field display to where you want it shown, or
   disable it to hide the below‑items, and arrange your custom fields.
6. **Create the view modes** you want to render items in — or just keep **default** if
   one is enough. (You can delete Simple Megamenu's "before"/"after" view modes if you
   do not need them; leaving them in place does no harm.)
7. **Create your mega‑menu items** (for example at `admin/content/simple_mega_menu`)
   and select the view mode to render each item in.

The result is per‑item control over how each mega‑menu entry renders, with the
below‑items freely placeable in your display.
