# Hierarchical Taxonomy Menu — manual setup guide

**Hierarchical Taxonomy Menu** (`hierarchical_taxonomy_menu`) turns a taxonomy
vocabulary into a navigation menu. It provides a single, richly configurable
**block** that renders a vocabulary's term hierarchy as a nested, optionally
collapsible menu — perfect for category navigation, a documentation topic tree, a
product‑category sidebar, or a region/location browser.

You place the block wherever you want it (a sidebar, for example), pick the
vocabulary to build from, and the block renders that vocabulary's terms as nested
links. From the block's settings you control how deep the menu goes, whether
branches collapse and expand, and whether the current term's branch stays open. You
can scope the menu to a single "base" term's children, or dynamically to whatever
term the visitor is currently viewing.

The block also has some nice extras: if your terms have an image field it can show a
thumbnail beside each item, and it can display a **count of referencing entities**
(nodes or Commerce products) next to each term — optionally counted recursively down
the subtree, and optionally hiding terms that have no content.

All configuration lives on the block itself — there is **no global settings page and
no permissions** of its own — and it requires only core's Taxonomy module. The markup
is fully themeable through the provided Twig template.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — place the block and configure the
   vocabulary, depth, collapsing, base term, images, and counts.

## Where it lives in the admin menu

It has no admin settings page. You place and configure the block under
**Structure → Block layout** (`/admin/structure/block`).

## How to use it

Go to Block layout, place the **Hierarchical Taxonomy Menu** block in a region,
choose your vocabulary, and adjust the options. The full field‑by‑field walkthrough
is in [Configuration](configuration/index.md).
