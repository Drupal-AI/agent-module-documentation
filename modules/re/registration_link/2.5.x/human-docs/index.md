# Registration Link — manual setup guide

**Registration Link** (`registration_link`) adds a **Register** link to Drupal's user
account menu — the same menu that already holds *Log in* and *My account* — so anonymous
visitors have an obvious way to create an account. Core leaves that link out by default;
this module puts it back without you having to hand‑write a menu YAML file or build a custom
block just to expose `/user/register`.

The link is smart about who sees it. It shows for logged‑out visitors, but only while the
site actually allows self‑registration: if you set *Who can register accounts?* to
"Administrators only" under core's account settings, the link disappears on its own.
Administrators always see it, as a convenient shortcut to the registration form. The
visibility is cache‑aware, so it stays in sync with your account settings automatically.

Because it is just a menu link, you manage it like any other menu item — move it to a
different menu, rename it, re‑order it, or disable it — all from *Structure → Menus →
Account menu*. There is no settings form to fill in and no permissions of its own: enable
the module and the link appears. It depends only on Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## Where it lives in the admin menu

The Register link appears in the **user account menu** (top‑right on most themes), next to
*Log in* and *My account*. To rename, move, re‑order or disable it, go to **Structure →
Menus → Account menu** (`/admin/structure/menu/manage/account`) and edit the *Register* link
like any menu item.

Its visibility follows core's account settings at **Configuration → People → Account
settings** (`/admin/config/people/accounts`) — specifically the *Who can register accounts?*
option.

## How to use it

- After enabling, log out (or open a private/incognito window): the **Register** link is in
  the account menu for anonymous visitors.
- Set *Who can register accounts?* to **Administrators only** and the link hides itself for
  visitors automatically — no need to disable the module.
- Want the link somewhere else (main navigation, footer)? Edit it under *Structure → Menus →
  Account menu* and change its parent menu, just as you would move any menu link.
