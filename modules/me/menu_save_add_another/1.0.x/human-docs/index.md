# Menu Link Save and Add Another — manual setup guide

**Menu Link Save and Add Another** (`menu_save_add_another`) is a small
quality‑of‑life module for anyone who builds out menus by hand. Out of the box,
Drupal bounces you all the way back to the menu listing after you save each new
menu link, so stubbing out a navigation structure means a tedious loop of clicks.
This module smooths that flow in three ways:

- It removes the `?destination` parameter from the **+ Add link** button at the top
  of the menu edit form, so the redirect is controlled sensibly by the form.
- It makes the ordinary **Save** button on a menu link return you to the *menu edit
  page* you were working in, rather than the front page or the top‑level menu list.
- It adds a new **Save and Add Another** button on the menu link edit form that
  saves the current link and drops you straight back onto the *add link* form for
  the same menu — so you can rattle off a whole set of links in a row.

The result is dramatically fewer clicks when you are populating a large menu. The
module depends only on core's **Menu UI** module, and it needs no configuration —
the improved buttons and redirects appear automatically. Access rides the standard
core **Administer menus and menu links** (`administer menu`) permission, so anyone
who can already edit menus gets the benefit.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module has no settings form and adds
nothing to the admin menu. Its improvements appear automatically on the existing
menu editing screens.

## How to use it

1. Go to **Structure → Menus** (`/admin/structure/menu`) and edit any menu.
2. Click **+ Add link** and fill in a menu link as usual.
3. Instead of the single **Save** button, you now also have **Save and Add
   Another**. Click it to save the link and immediately land back on the add‑link
   form for the same menu — repeat until the menu is built.
4. When you are done, use the ordinary **Save** button; it returns you to the menu
   edit page rather than the top‑level menu list.
