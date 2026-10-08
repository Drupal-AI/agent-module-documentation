# Parent Link Search — manual setup guide

**Parent Link Search** (`parent_link_search`) fixes a small but real annoyance in
Drupal's admin UI. When you edit a menu link — or set the menu options on a node —
you pick where it belongs from the **Parent link** select dropdown. On a site with
a large menu that dropdown becomes a very long list, and neither Drupal nor the
browser gives you any way to search it. Finding the right parent means scrolling.

This module adds a small text field and a **Highlight** button directly beneath
that dropdown. Type part of a menu item's name, click Highlight, and the module
finds matching options, highlights them, and jumps the select list to the first
match — all client‑side, and crucially it keeps the menu **hierarchy** visible, so
you can still see the ancestors of whatever you matched. Unlike select2‑based
alternatives, it needs no third‑party JavaScript library and does not flatten the
tree.

Under the hood it is a single `hook_form_alter` that activates automatically
wherever the standard **Parent link** element appears — the menu link add and edit
forms, and the *Menu settings* section of a node edit form. It adds no routes, no
permissions, no settings, and stores no data, so it uninstalls cleanly. One thing
to know up front: the highlight color is fixed and not currently adjustable.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form and
works automatically once enabled.

## How to use it

Once enabled, the feature appears on its own — there is nothing to switch on:

1. Go to **Structure → Menus → *(a menu)* → Add link** (or edit an existing menu
   link), or open any node's edit form and expand its **Menu settings**.
2. Beneath the **Parent link** dropdown you will see a small text field and a
   **Highlight** button.
3. Type part of the menu item you are looking for and click **Highlight**. Matches
   are highlighted inline, and the dropdown jumps to the first one — with the
   surrounding hierarchy still shown so you know which branch you are in.

This is purely an editing‑experience enhancement; it changes nothing about how
menus are stored or rendered on the front end.
