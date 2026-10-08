# LocalGov menu link group — manual setup guide

**LocalGov menu link group** (`localgov_menu_link_group`) lets you gather existing
menu links under a new grouping link — most often to tidy a crowded admin menu into
logical sections. You describe a group (its label, where it hangs in the menu, and
which links belong in it) and the module moves those links underneath it at menu
build time. A nice touch: because the group link is synthetic and has no page of its
own, the module hides an empty group automatically from any user who cannot reach a
single one of its child links.

Despite the "LocalGov" name and package, this module has **no module
dependencies** — it works on any Drupal 10 or 11 site, front-end menus included, not
just LocalGov distributions. It stores each group as a **config entity**, so your
groupings export and deploy with the rest of your site configuration. It has no
permissions of its own beyond the standard entity admin routes, and no Drush
commands.

Enabling the module does nothing visible on its own — the point is the config UI it
adds. You create one or more groups at **Structure → Menus → LocalGov menu link
group**, and each group re-parents the links you list under a new grouping link.
Whenever you add, change, or delete a group, the menu is rebuilt so the change takes
effect immediately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — creating and editing menu link groups,
   field by field.

## Where it lives in the admin menu

The group admin UI is at **Structure → Menus → LocalGov menu link group**
(`/admin/structure/menu/localgov_menu_link_group`) — a list of your groups with add,
edit, and delete forms.

## How to use it

Create a group, tell it which existing menu links to gather and where the new
grouping link should sit, and save. The listed links move under the group. See
[Configuration](configuration/index.md) for the walkthrough and each field's
meaning.
