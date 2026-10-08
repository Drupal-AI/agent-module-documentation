# Menu Link Config — manual setup guide

**Menu Link Config** (`menu_link_config`) lets you create custom menu links as
*configuration* rather than content. It's a drop‑in complement to — and replacement
for — core's Custom Menu Links, adding a third kind of menu link that exports and
imports cleanly with the rest of your site's configuration.

The problem it solves is a deployment one. Drupal has two kinds of menu link out of
the box: links defined in code by modules (fixed at release, in `*.links.menu.yml`)
and custom links created through the UI, which are *content* entities. Because those
custom links are content, they don't appear in a configuration export (`drush cex`)
and have to be recreated by hand in every environment. Menu Link Config stores its
links as configuration entities, so they travel through your normal config
workflow — export them, commit them, and deploy them like any other setting, or
bundle them into a Feature.

The module is aimed at **small menus** — a handful of structural links you want
under version control. If you need to move large volumes of content‑style links
between environments, the [Deploy](https://www.drupal.org/project/deploy) module is
a better fit. It has no dependencies and adds no settings page of its own; you
create the links from the normal menu UI. Two things worth knowing before you
adopt it: the release has been a long‑standing alpha, and config entities do not
translate through content translation the way content menu links do — check your
multilingual needs first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings page** for this module. You create links from the menu UI,
described in "How to use it" below.

## How to use it

1. Go to **Structure → Menus** (`/admin/structure/menu`) and open the menu you want
   to add a link to (or add a new menu).
2. On the menu's management page you'll find a new **Add config link** action
   (alongside core's *Add link*). Use it to create your link — it appears in the
   normal menu list right beside the other kinds, so editors see one unified list.
3. To move the link between environments, export it at **Configuration →
   Development → Configuration synchronization → Export → Single item**
   (`/admin/config/development/configuration/single/export`), or include it in a
   Feature. It's now part of your config, ready to deploy.

> **Tip:** If core's **Custom Menu Links** module is enabled, you can optionally
> uninstall it once you've moved to Menu Link Config, since this module fills the
> same role while adding config exportability.
