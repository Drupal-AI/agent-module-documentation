# Menu Manipulator — manual setup guide

**Menu Manipulator** (`menu_manipulator`) improves how Drupal renders menus in
two practical ways: it can **filter each menu's links by the current interface
language**, and it can **render an icon next to each link**. Both are configured
centrally on a single settings page, so you don't need custom theme code.

The headline feature is multilingual menus without duplication. Normally, to show
different links per language you would maintain a separate menu for each language.
Menu Manipulator instead hooks into core menu rendering and, for the menus you
choose, removes at render time any links that don't belong to the current
language — so one main menu can serve every language. A link's language can be
resolved either from the link's own translation or from the entity it points to,
and the module adds a language selector to the menu‑link edit form so you can
assign a language to a link explicitly. Access checks on each link stay intact
while filtering happens.

Separately, the module can attach an icon to each link in the menus you select,
drawing from a central list of available icons you maintain. Everything —which
menus are language‑filtered, which menus get icons, how language is resolved, and
the icon list — is driven from one settings form. The module depends on core's
Language module.

This guide is written for a **human** setting it up through the admin UI. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which menus are
   language‑filtered, how language is resolved, and which menus show icons.

## Where it lives in the admin menu

Once enabled, its settings form sits at **Configuration → User interface → Menu
Manipulator** (`/admin/config/user-interface/menu-manipulator`), gated by the
*Administer site configuration* permission. It also adds a language selector to
each menu link's edit form.

## How to use it

Open the settings form, turn on language filtering, and tick the menus that
should be filtered (for example the main and footer menus). Decide whether a
link's language comes from its own translation or from its linked entity. If you
want icons, turn icons on, tick the menus that should show them, and fill in the
list of available icon names. Then assign languages (and icons) to individual
links from the menu‑link edit form. See [Configuration](configuration/index.md)
for the field‑by‑field walkthrough.
