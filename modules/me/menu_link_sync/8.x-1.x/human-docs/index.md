# Menu Link Sync — manual setup guide

**Menu Link Sync** (`menu_link_sync`) helps keep the *positions* of menu links in
step across a multilingual site that uses a separate menu per language — for
example a "Main Menu – English", "Main Menu – French", and "Main Menu – Spanish".
It adds a **Synchronize** button to the *Menu link settings* on the node edit form
of a translated node.

The problem it solves sits between two other approaches. Sometimes the menu trees
for each language are too *different* for `i18n_menu` or Entity Translation to
manage as a single translated structure, yet they're still similar *enough* that you
want the same page to sit in roughly the same spot in every language's menu. Pressing
**Synchronize** on a translation works out the parent and relative tree position
that best matches the source translation's menu link, then updates the form via AJAX
so the correct parent and weight are selected for you — no manual counting.

It depends on the contributed **Menu Link (Menu Node API)** module and has no
settings of its own. It integrates with two optional modules:
[Menu Link Weight](https://www.drupal.org/project/menu_link_weight), which lets it
match the *relative* position ("underneath item X", "above item Y") instead of just
copying a numeric weight, and
[Hierarchical Select](https://www.drupal.org/project/hierarchical_select) for easier
management of large trees.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependency.

There is **no settings page** for this module. You use it directly on the node edit
form, described in "How to use it" below.

## How to use it

1. Set up your site with a separate menu per language and translated nodes.
2. Edit a *translated* node and open the **Menu link settings** section of the form.
3. Click the **Synchronize** button. The module calculates the parent and relative
   position that best mirror the source translation's menu link, and the form's
   parent and weight fields update automatically via AJAX.
4. Review the selected parent and weight, then save the node.

> **Tip:** Add [Menu Link Weight](https://www.drupal.org/project/menu_link_weight)
> to synchronize the *relative* position within the tree rather than just the raw
> numeric weight — usually what you want when the trees differ slightly.
