# Menu Parent Select Filter — manual setup guide

**Menu Parent Select Filter** (`menu_parent_select_filter`) adds a small text filter
box directly above the **Parent link** dropdown on menu‑link forms. As you type, the
dropdown's options are filtered live, so you can jump to the parent item you want
instead of scrolling through a huge list.

The problem it solves is a familiar annoyance: on a site with a big menu, the parent
selector on the node add/edit page (and the menu‑link form) becomes a mile‑long list
of every link in the tree. Typing a few characters narrows it instantly. It's a
lightweight, client‑side usability tweak — nothing about your menus or their access
changes.

The module works the moment you enable it, with no configuration and no per‑link
setup. It has no dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings page** for this module — it works automatically once enabled.

## How to use it

Just enable the module. From then on, whenever you edit a node's menu settings or add
a link at **Structure → Menus** (`/admin/structure/menu`), a filter text box appears
above the **Parent link** dropdown. Start typing and the dropdown narrows to the
matching options.
