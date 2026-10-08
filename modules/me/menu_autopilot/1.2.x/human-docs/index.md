# Menu Autopilot — manual setup guide (1.2.x)

**Menu Autopilot** (`menu_autopilot`) turns Drupal navigation into an automatic,
content-driven system. You curate your top-level menu the way you always have,
then let each item's children build and maintain themselves from your published
content. Publish a new product, article, or landing page and it appears under the
right menu item automatically; unpublish it and it disappears. It is to
navigation what Pathauto is to URL aliases: the automatic, config-driven default.

The problem it solves is the busywork and fragility of hand-curated menus. On
content-heavy or decoupled sites, editors spend real time redoing navigation to
mirror content, and in a headless build a hand-placed link is easy to point at the
wrong URL. You choose each dynamic parent's source — a taxonomy term, a content
type, or a hand-picked ordered list of nodes — and control the order and labels.
Generated child links are ordinary `menu_link_content` entities that store a
**canonical** `entity:node/<id>` URI, so they resolve to the node's real path
alias, never `/node/123` or an editorial route. Because they are plain menu
links, the composed tree is exposed to GraphQL, JSON:API, or a Twig theme with no
extra work, and it fans cache-tag revalidation to a decoupled front end. Synced
links are translatable and language-aware.

> **What's new in 1.2.x.** This branch adds **Keep current order** to the child
> sort options, so automatic children keep the sequence you drag on the menu
> overview (new matches simply append at the end) while the module still adds,
> renames, and prunes them from content. The token pattern field is renamed
> **Child menu label** with a subtitle example (`[node:title] [node:field_subtitle]`)
> and now stores titles as plain text, so an ampersand in a node title is no
> longer escaped. The parent's settings section is retitled **"Menu Autopilot:
> children of …"** so it is obvious which module owns it, and editing an
> automatic child's page from the node form no longer conflicts with core's
> menu-link widget (fixing fatals and draft/pending-revision errors seen in
> 1.1.x). If you are on 1.1.x, these are the reasons to upgrade.

It depends on core's **Menu Link Content** (`menu_link_content`) and **Node**
(`node`) modules, needs Drupal 10.6+ or 11.3+ and PHP 8.1+, and does nothing on
enable alone — you configure which menus it manages and mark links as dynamic
parents, both covered below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core dependencies.
2. [Configuration](configuration/index.md) — the settings page, turning a menu
   link into a dynamic parent, the "existing children" policies, the "Keep
   current order" sort, permissions, and the Drush commands.

## Where it lives in the admin menu

Two places. The module's settings page is **Structure → Menu Autopilot**
(`/admin/structure/menu/autopilot`), where you choose which menus are managed and
the default sort/limit. The per-link controls live on the standard menu-link edit
form under **Structure → Menus** (`/admin/structure/menu`) — edit a link and open
its **"Menu Autopilot: children of …"** section.
