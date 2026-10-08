# Taxonomy Menu — manual setup guide

**Taxonomy Menu** (`taxonomy_menu`) automatically builds menu links from the
terms in a taxonomy vocabulary, and keeps that menu in sync as terms are added,
renamed, or deleted. Turn a "Categories" or "Topics" vocabulary into real site
navigation without hand‑building and maintaining the menu yourself.

You create a small mapping — one vocabulary to one menu — and Taxonomy Menu
generates a menu link for every term, mirroring the term hierarchy so parent and
child terms become nested menu items. Because the link titles and descriptions
are rendered live from the terms (including their translations), they always
match the taxonomy: rename a term and its menu link updates, delete a term and
its link disappears, unpublish a term and its link is hidden.

You control the depth of the generated tree, which existing menu it hangs under,
whether items are expanded, whether they are ordered by term weight, and which
term field (if any) supplies a description. You can create several of these
mappings — each is its own configuration entity that exports and deploys between
environments. Taxonomy Menu depends only on Drupal core's Taxonomy module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and tune a taxonomy menu,
   option by option.

## Where it lives in the admin menu

Taxonomy menus are managed at **Structure → Taxonomy menu**
(`/admin/structure/taxonomy_menu`). The module defines no permissions of its own —
access is controlled by the core **Administer site configuration** permission.

## How to use it

1. Make sure you have a vocabulary with some terms, and a menu to hold the links
   (the core Main navigation menu works, or create a custom one under
   **Structure → Menus**).
2. Go to **Structure → Taxonomy menu** and click **Add taxonomy menu**.
3. Pick the source vocabulary and the target menu, set the depth and other
   options (see [Configuration](configuration/index.md)), and save.
4. The menu links are generated immediately. Place the menu with a block, or use
   it wherever your theme renders that menu.

Because menu items are heavily cached, clear the site cache after large bulk
changes to terms if the menu does not appear to update.
