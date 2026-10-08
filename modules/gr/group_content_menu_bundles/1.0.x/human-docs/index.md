# Group Content Menu Bundles — manual setup guide

**Group Content Menu Bundles** (`group_content_menu_bundles`) bridges the
[Group Content Menu](https://www.drupal.org/project/group_content_menu) module and
the [Menu Item Extras](https://www.drupal.org/project/menu_item_extras) module. It
exposes each Group Content Menu type as a **menu link bundle**, so the per‑group
menus that Group Content Menu creates can carry the extra **fields** that Menu Item
Extras provides — giving group menu items richer, fieldable content instead of
plain links.

On a site built with the [Group](https://www.drupal.org/project/group) module, this
is what you reach for when per‑group menus need more than a label and a URL — for
example a description, an icon reference, or any custom field on each menu link.

The module is an integration layer only: menu behaviour and group access continue
to follow Group, Group Content Menu, and Menu Item Extras. It has no access‑control
role of its own.

> **Install it early.** At present this module can only be installed **before**
> any content menu link has been created. Enable it as part of setting up group
> menus, not after group menus are already populated.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its Group Content Menu, Menu Item Extras, and Field UI
   dependencies.

There is **no settings form** for this module (`configure` is null). Once enabled,
Group Content Menu types become fieldable menu‑link bundles; you add and manage
their fields through the standard **Field UI**, described under "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin page of its own. Because it turns Group Content Menu types
into menu‑link bundles, you manage their fields through **Field UI** — the same
*Manage fields* / *Manage form display* / *Manage display* screens you use for
other bundles — reached from the menu configuration provided by Group Content Menu.

## How to use it

1. Enable this module **before** creating any group content menu links.
2. With it enabled, each Group Content Menu type is exposed as a fieldable menu
   link bundle.
3. Use **Field UI** to add the fields you want on those group menu links, and
   configure their form and display as usual.
4. Build your per‑group menus through Group Content Menu — the menu links now carry
   the fields you defined.
