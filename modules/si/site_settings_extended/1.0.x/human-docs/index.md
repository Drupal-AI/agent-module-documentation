# Site Settings Extended — manual setup guide

**Site Settings Extended** (`site_settings_extended`) improves the editing experience of
the excellent [Site Settings](https://www.drupal.org/project/site_settings) module.
Where Site Settings gives you a place to store arbitrary site-wide configuration-like
content, this add-on gives that content a **richer, better-organized editing UI**,
using Inline Entity Form and Field Group.

The main change is a complete overhaul of the settings layout, offered in two styles:

- **Single form** — all your settings gathered into vertical tabs on one page. It is
  convenient, but for large collections the form can grow unwieldy, so this suits
  smaller sets of settings.
- **Core config pages** — a landing page of links styled like a core configuration
  overview. You can enrich it by setting up a `menu_description` view mode, whose output
  becomes each link's description (handy for grouped items — for example social links
  where "facebook", "instagram", and so on are shown as descriptions). From there you
  can open each settings form either in a modal or on its own page.

If you choose to open settings forms in **modals**, the maintainer strongly recommends
applying the core patch from issue [#2741877 "Nested modals don't work"], otherwise
media library modals can break inside the settings modal.

The module is a site-building/admin convenience: the settings themselves are still
edited by privileged users under **Site Settings' own permissions**, and this module
adds no access-control role of its own. It depends on **Site Settings**, **Inline Entity
Form**, and **Field Group**, and supports Drupal 10 and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   and its dependencies.

## How to use it

After enabling, configure Site Settings as usual, then choose which layout you want —
**Single form** (vertical tabs) for smaller collections, or **Core config pages** (a
links overview) for larger ones. For the core-config-pages style, optionally set up the
`menu_description` view mode to add descriptive text to each link, and decide whether
settings forms open in modals or on their own pages. If you use modals, apply the nested-
modals core patch noted above so media library modals keep working.
