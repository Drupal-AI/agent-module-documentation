# Simple Taxonomy Menu — manual setup guide

**Simple Taxonomy Menu** (`simple_taxonomy_menu`) builds site navigation from a
taxonomy vocabulary. It provides blocks that render a vocabulary's terms — with
their hierarchy — as a multi-level menu, so a vocabulary you already maintain can
drive the menu without you hand-building matching menu links. It's positioned as a
simpler, more reliable alternative for people who've had trouble with the older
Taxonomy Menu module.

Its most useful trait is that it keeps the menu **active while visitors browse**.
As someone moves through your content — including landing directly on a node — the
module tracks their position in the taxonomy and highlights the matching place in
the menu, so people always know where they are. This works across one menu or
several. You can also add extra menu items at the top or bottom of the generated
menu when you need a link that isn't a term.

Setup is deliberately light: enable the module, then place a "Simple taxonomy menu"
block for the vocabulary you want, wherever you'd like it to appear. It depends only
on core's **Taxonomy** module and works on Drupal 8.8 through 11. The generated
links follow normal menu and term access; the module has no access-control role of
its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Place a **Simple taxonomy menu** block — there's one available per taxonomy
   vocabulary you've created — into the region where you want the navigation.
4. Configure and save the block.

The block renders the vocabulary's terms as a multi-level menu, and stays
highlighted to match the visitor's current position as they browse terms and nodes.
