# Menu Parent Selector — manual setup guide

**Menu Parent Selector** (`menu_parent_selector`) provides a new field type,
**Menu Parent Item**, that lets an editor pick a menu and a parent link on a piece of
content. When the content is displayed, the field renders that parent link's
children — a compact way to surface a sub‑section of your navigation on a node.

The problem it solves is showing "the links under this section" without hand‑building
a block or hard‑coding a menu name. An editor chooses the menu and the parent item
from the content form; the display then lists exactly the children beneath that
parent. As they change the menu, the available parent options update via an AJAX
request behind the field.

It's a fielded feature, so setup follows the normal Field UI: add the field to a
content type, enable it on the form and display, then use it per node. It has no
dependencies beyond core and adds no settings page of its own.

> **Security note:** the AJAX endpoint that supplies parent options returns menu
> link titles for any menu name to any caller, including anonymous visitors and
> administrative menus. Treat menu link titles in this context as non‑sensitive; the
> endpoint exposes structure only (no content is mutated and no protected content is
> revealed).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** for this module — you add and configure the
field per content type, described in "How to use it" below.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields** and add a new
   field of type **Menu Parent Item**. Optionally set a default value.
2. Under **Manage form display**
   (`/admin/structure/types/manage/XXX/form-display`), make sure the field is enabled
   so editors can set it on the content form.
3. Under **Manage display** (`/admin/structure/types/manage/XXX/display`), enable the
   field so its output (the parent's children) shows on the rendered content.
4. Make sure the menu you'll point at has a clear structure — a parent item with
   child items beneath it.
5. Create or edit a node of that type, choose the **menu** and the **parent item**,
   and save. The node will display the links found under that parent.
