# Node Menus — manual setup guide

**Node Menus** (`node_menus`) lets you control **which menus are available** when
placing a node in a menu. Out of the box, Drupal lets each content type expose a
fixed set of allowed menus, and the node form shows a menu dropdown built from that
set. On a multilingual site where you keep a separate menu per language, that
dropdown can grow long and clumsy — every language's menu links crowd into one
selector. Node Menus tackles that by relating the available menu links to the
node's language, so when you edit or add a node you get a menu dropdown containing
only the links for that language.

The result is a tidier, language‑aware menu‑placement experience: no more oversized
menu dropdowns mixing every language together. This is a site‑structure /
content‑editing feature — it changes the *options* available for menu placement, not
*who* may place nodes, so it has no access‑control role.

It depends on core's **Content Translation** and otherwise uses only core, so no
extra contributed modules are needed. Setup is done per content type on the content
type's own edit form rather than through a central settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

Configuration is per content type rather than on a central settings page — see "How
to use it" below.

## How to use it

1. Enable the module (this installs its required core dependencies).
2. Add the **language(s)** you want to use.
3. Create the **menus** you want to offer — the menu's own language does not matter.
4. Edit the content type (**Structure → Content types → *(your type)* → Edit**) and
   **enable translations** for it.
5. On that same content‑type edit form, tick **Enable language menus** and select
   which menus should be available **for each language**.
6. Display the menus with normal menu blocks (or your own block plugin). When
   editing a node, the menu dropdown now shows only the menus relevant to the node's
   language.
