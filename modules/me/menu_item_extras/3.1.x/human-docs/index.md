# Menu Item Extras — manual setup guide

**Menu Item Extras** (`menu_item_extras`) makes Drupal's menu links fully
fieldable — so you can build mega menus and rich navigation using standard Drupal
fields and view modes, without creating separate content entities. Core menu links
only hold a title, URL, and description. This module upgrades them into first‑class
fieldable entities: it adds a default **body** field and a **view mode** selector to
every menu link, and lets you attach any other fields (images, text, entity
references, blocks) through the normal Field UI.

Each menu also gets its own **view‑modes settings** form, so different menus — or
different levels within one menu — can render their links differently. Rendering is
handled by dedicated templates plus a rich set of theme‑hook suggestions keyed by
menu name, level, entity ID, and view mode, giving themers granular control. A cache
context and active‑trail handling keep the enriched menus cacheable. The result is a
native way to build mega menus, image‑driven navigation, promotional menu panels, and
multi‑column dropdowns. It depends on core's **Block**, **Menu Link Content**, and
**Text** modules.

The module starts working the moment you enable it — menu links immediately gain a
body field and a view‑mode selector — but the interesting results come from adding
your own fields and configuring per‑menu view modes. An optional **`mie_demo_base`**
submodule ships a worked mega‑menu example you can study. A Drush command is provided
to clear the extra data (useful before uninstalling).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally turn on the demo submodule.
2. [Configuration](configuration/index.md) — add fields to menu links and set up
   per‑menu view modes.

## Where it lives in the admin menu

There is no single global settings page (`configure` is null). You manage the fields
on menu links at **Structure → Menu link content**
(`/admin/structure/menu/menu_link_content/…`) using the standard Manage fields /
Manage form display / Manage display tabs — just like a content type. Each menu's
view‑mode options live on its own tab at
`/admin/structure/menu/manage/{menu}/view_modes_settings`, and you set a per‑item view
mode right on the menu link's add/edit form. See
[Configuration](configuration/index.md) for the details.
