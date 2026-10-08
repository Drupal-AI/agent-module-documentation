# Menu Title length — manual setup guide

**Menu Title length** (`menu_title_length`) lets you control the maximum length of
a menu link's **title** field. By default Drupal allows menu link titles up to 255
characters; this module lets you set a shorter (or longer) cap so your navigation
labels stay tidy and consistent. Out of the box it ships with a limit of **20
characters**, so the constraint is active the moment you enable it.

The limit can be set in three ways, checked in order: a value saved through the
module's settings form, then a `settings.php` override (handy for enforcing a limit
per environment), and finally a built‑in default constant of 20 if nothing else is
configured. The module works on all `menu_link_content` links site‑wide.

It is worth understanding *how* the limit is applied: the module changes the menu
link title field's `max_length` **validation** setting — that is, it constrains how
much text an editor may enter — but it does **not** alter the underlying database
column. That makes it a safe, reversible change: you are tightening input
validation, not migrating storage.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the maximum title length through
   the settings form, or override it in `settings.php`.

## Where it lives in the admin menu

Once enabled, the module's settings form sits at **Configuration → System → Menu
Title Length settings** (`/admin/config/system/menu-title-length/settings`). You
need the **Administer site configuration** permission to reach it.
