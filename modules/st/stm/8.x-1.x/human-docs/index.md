# Simple Taxonomy Menu — manual setup guide

**Simple Taxonomy Menu** (`stm`) is a time-saver for turning a taxonomy vocabulary
into a navigation menu. It adds a **Sync To Menu** tab to a vocabulary's term
overview page; from there you pick a menu, and the module generates menu links
that mirror the vocabulary's term hierarchy — parent terms become parent links,
child terms become child links — so you do not have to hand-create a menu link for
every term.

It covers similar ground to the older Taxonomy Menu module but with a simpler
approach and a couple of useful extras: it uses core's menu-link-content entities,
respects term weight so ordering and hierarchy carry over, and lets you set a
custom path pattern (so links can point at `/category/%tid` or `/vocabulary/%tid/all`
instead of the default `/taxonomy/term/%tid`).

The module works on demand — there is no settings page and nothing to configure
after enabling it. Each time you want to (re)build a menu from a vocabulary, you
open that vocabulary's Sync To Menu tab and click **Sync**. It has no dependencies
beyond Drupal core and supports Drupal 9 and 10.

Access to the Sync To Menu form follows the vocabulary's **view** access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Make sure you have a taxonomy vocabulary (for example *Category*) with some
   terms in it.
2. Navigate to that vocabulary's term overview and open the **Sync To Menu** tab —
   the URL is `/admin/structure/taxonomy/manage/{vocabulary}/overview/menu`
   (e.g. `/admin/structure/taxonomy/manage/category/overview/menu`).
3. Choose the **menu** the terms should be synced into — *Main navigation*, for
   example.
4. Set the **path pattern** if you want something other than the default
   `/taxonomy/term/%tid` — such as `/category/%tid`.
5. Click **Sync**. The module creates menu links mirroring the term hierarchy. Run
   it again after adding terms to refresh the menu.
