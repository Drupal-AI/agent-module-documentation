# Taxonomy Menu UI — manual setup guide

**Taxonomy Menu UI** (`taxonomy_menu_ui`) gives taxonomy terms the same convenient
**"Menu settings"** experience that content nodes already have. In core, you can tick
"Provide a menu link" while editing a node and it drops a link to that node into a
menu — but terms have no such option. This module adds it: choose which menus a
vocabulary's terms are allowed to appear in, and then, right on the term add/edit
form, tick a box to create a real menu link pointing at that term.

That makes it easy to build taxonomy-driven navigation. Put every term of a
"Departments" vocabulary into the main menu without hand-building links at
`/admin/structure/menu`; let editors add a category to the footer menu straight from
the term form; give a glossary a sidebar menu of its sections. The links it creates
are ordinary Drupal menu links (pointing at `/taxonomy/term/<id>`), so everything else
in Drupal treats them normally — you can reorder, reparent, and translate them just
like any other menu link.

Under the hood it's a lightweight layer over core's Menu UI: it adds no new entity
types, services, or permissions. You configure allowed menus and a default parent
per vocabulary, and access to the term-form menu options follows core's **Administer
menus** permission (or a per-menu grant if you use the
[Menu Admin per Menu](https://www.drupal.org/project/menu_admin_per_menu) module). It
also registers a `[term:menu-link:*]` token for use in templates and patterns. It
requires core's **Taxonomy** and **Menu UI** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — allowing menus per vocabulary and adding
   term menu links.

## Where it lives in the admin menu

There's no dedicated settings page. You work on the taxonomy screens:

- **Structure → Taxonomy → *(vocabulary)* → Edit**
  (`/admin/structure/taxonomy/manage/<vocabulary>`) — a **Menu settings** tab for
  choosing allowed menus and a default parent.
- The term add/edit form — a **Menu settings** section for creating the link.

## How to use it

On a vocabulary's edit form, open **Menu settings** and tick the menu(s) its terms may
go into (and optionally a default parent). Then, on any term of that vocabulary, open
**Menu settings**, tick **Provide a menu link**, and save. Full details are in
[Configuration](configuration/index.md).
