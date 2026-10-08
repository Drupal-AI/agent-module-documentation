# Menu Perms per Menu — manual setup guide

**Menu Perms per Menu** (`menu_perms_per_menu`) extends the **Menu Admin per
Menu** module with fine‑grained, per‑menu permissions. Where Menu Admin per Menu
lets you grant a role administration of *specific menus* (rather than all of
them), this module goes a level deeper and controls *which operations* a role may
perform on each menu: adding links, deleting links, enabling/disabling them,
toggling "show as expanded", editing a link's URL, and translating links.

The clever part is that it generates six permissions **for every menu on your
site automatically**. Create a new menu and its six permissions appear right away
on the permissions page. That lets you build setups like "the editor role can
rename and reorder links in the Main menu but cannot add or delete them," or "the
marketing role manages the Promotions menu end to end while every other menu stays
read‑only for them."

There is **no configuration screen of its own** — you do everything from Drupal's
standard **People → Permissions** page. The permission labels each name the menu
they apply to, so you simply tick the operations you want each role to have on
each menu.

> **Note.** The restrictions on the *Link (URL)*, *Enabled*, and *Show as
> expanded* fields are applied by disabling those form controls. The *add*,
> *delete*, and *translate* operations are enforced by route access checks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its dependency)
   with Composer and enable it.
2. [Configuration](configuration/index.md) — the six per‑menu permissions and how
   to assign them.

## Where it lives in the admin menu

There is no dedicated settings page. Everything happens at **People →
Permissions** (`/admin/people/permissions`), where the module's per‑menu
permissions appear grouped under its name. The menus themselves are managed as
usual at **Structure → Menus** (`/admin/structure/menu`).
