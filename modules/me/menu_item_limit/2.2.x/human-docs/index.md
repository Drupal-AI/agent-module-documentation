# Menu Item Limit — manual setup guide

**Menu Item Limit** (`menu_item_limit`) lets you cap how many links a given menu is
allowed to contain. You set a per‑menu maximum right on the menu's edit form, and
once a menu is full, Drupal blocks adding another link with a clear validation
error. It is a simple way to enforce an editorial policy — "the main navigation
holds at most 8 items," "the footer menu holds 4" — without writing any custom code,
which keeps navigation tidy, on‑design, and within accessibility or
performance budgets even when several editors can add links.

The module adds an **Item Limitation** field to core's Menu UI menu edit form. The
number you enter is saved per menu; `0` (or empty) means unlimited, and any positive
integer caps that menu. Enforcement uses an entity validation constraint: when
someone tries to add a **new** menu link to a full menu, the save is rejected with
the message *"New link cannot be added because the menu item limit has been
reached."* Because it validates on save, the cap holds wherever menu links are
created through the UI.

There is **no separate settings page, permission, or Drush command** — the only
state is the per‑menu number, stored in configuration and exportable with the rest
of your site config so limits deploy across environments. Note that the cap applies
to menu links you add through the UI (`menu_link_content` entities), not to links
that modules define in code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — setting a menu's item limit.

## Where it lives in the admin menu

There is no dedicated page. The **Item Limitation** field appears on each menu's
edit form at **Structure → Menus → *(menu)* → Edit menu**
(`/admin/structure/menu/manage/<menu>`).

## How to use it

Enable the module, edit the menu you want to cap, enter a maximum in the **Item
Limitation** field, and save. From then on, editors adding links to that menu are
stopped with a validation error once the cap is reached. Set a menu back to `0` any
time to make it unlimited again.
