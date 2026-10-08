# Domain Menu Access — manual setup guide

**Domain Menu Access** (`domain_menu_access`) brings Domain Access rules to
individual **menu links**. It is an extension of the **Domain Access** ecosystem
and depends on the base `domain` module, `domain_access`, and core's
`menu_link_content` module.

Domain Access already controls which domains a *node* belongs to, but menus stay
global — every domain shows every link. This module closes that gap by reusing the
very same field. Each menu link gains the standard `field_domain_access` and "all
affiliates" values, grouped into a *Domain* section on the menu link edit form, so
you decide per link which domains it belongs to. At display time a menu tree
manipulator walks each menu and hides links that do not belong to the domain being
served — including the whole subtree beneath a hidden link — while adding the
correct per-domain cache context so menus still cache properly. The menu overview
table also gains a *Domains* column so you can see each link's assignments at a
glance.

The module does not filter every menu automatically. You choose which menus
participate on its settings form; for any menu that is *not* on that list, the
domain fields are hidden from the link form and no filtering happens. It ships a
permission, **`administer menu items across domains`**, letting trusted staff edit
links belonging to any domain rather than only the one they are currently on, and
an optional submodule adds support for the **Menu Block** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   optionally add the Menu Block submodule.
2. [Configuration](configuration/index.md) — choose which menus participate, then
   assign links to domains from the standard menu link form.

## Where it lives in the admin menu

The module's settings form — the list of participating menus — sits at
**Configuration → Domain → Domain Menu Access**
(`/admin/config/domain/domain_menu_access/config`), reachable by users with the
**Administer domains** permission. The per-link domain assignments happen on the
ordinary menu link edit pages under **Structure → Menus**.
