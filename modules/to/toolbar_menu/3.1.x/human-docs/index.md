# Toolbar Menu — manual setup guide

**Toolbar Menu** (`toolbar_menu`) lets you add any custom menu you've built under
**Structure → Menus** to the Drupal administration **Toolbar** as its own
top-level tab. Click the tab and that menu's links appear in the toolbar tray —
so editors reach the links they use most without digging down through the admin
tree.

Each menu you want in the toolbar becomes a small configuration entity (a
"toolbar menu element") that points at an existing menu and carries a label, a
weight for ordering, and a flag for whether the tab shows its own label or the
underlying menu's label. The module then renders one toolbar tab per element,
ordered by weight, with the menu's link tree pre-built into the tray.

Visibility is controllable per menu: besides the overall administration
permission, every element gets its own generated permission (`view <id> in
toolbar`), so you can show a given tab only to the roles that should see it — a
"Developer tools" tab for developers, a "Commerce" tab for store managers, and so
on. Because the tabs are configuration entities, they export and deploy cleanly
across environments.

It depends only on core's Toolbar module and pairs nicely with
[Admin Toolbar](https://www.drupal.org/project/admin_toolbar) for a richer
experience.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add menus to the toolbar and control
   which roles see each tab.

## Where it lives in the admin menu

Toolbar menu elements are managed at **Configuration → User interface → Toolbar
Menu** (`/admin/config/user-interface/toolbar-menu/elements`).

## How to use it

1. Build (or pick) a menu under **Structure → Menus** with the links you want.
2. Go to **Configuration → User interface → Toolbar Menu** and add an element
   pointing at that menu.
3. Grant the element's `view <id> in toolbar` permission to the roles that should
   see the tab.

See [Configuration](configuration/index.md) for the details.
