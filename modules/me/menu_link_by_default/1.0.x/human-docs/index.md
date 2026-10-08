# Menu Link by Default — manual setup guide

**Menu Link by Default** (`menu_link_by_default`) lets site builders switch on the
*Provide a menu link* option by default for specific content types. When an editor
creates a new node of that type, the "Provide a menu link" checkbox under **Menu
settings** starts out already ticked — a gentle nudge to file the page into the
site's navigation.

The problem it solves is one of habit. Evergreen content is easiest to manage when
it lives in a menu, especially on sites using Pathauto for automated path aliases.
Left to the default, editors often forget the menu‑link checkbox and pages drift
outside the navigation. This module makes inclusion the path of least resistance
without forcing it: the checkbox is pre‑checked, but editors remain free to untick
it for any page that genuinely doesn't belong in a menu.

It's a lightweight, encouragement‑style tool — not an enforcement one. It depends
on core's **Menu UI** and **Node** modules and adds no settings page of its own;
you switch the behavior on per content type from that content type's own settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central configuration page** for this module. You enable the default
per content type, described in "How to use it" below.

## How to use it

1. Go to **Structure → Content types** (`/admin/structure/types`) and edit the
   content type you want (for example, *Basic page*).
2. Open the **Menu settings** vertical tab.
3. Tick the new **Provide a menu link by default** option.
4. Click **Save**.

From then on, when an editor creates a node of that type, the "Provide a menu link"
checkbox under Menu settings is already ticked. Editors can still untick it on any
individual node. Repeat for each content type where you want the default applied.
