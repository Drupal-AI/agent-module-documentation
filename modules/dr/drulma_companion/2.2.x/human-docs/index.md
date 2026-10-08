# Drulma Companion — manual setup guide

**Drulma Companion** (`drulma_companion`) is a helper module for the
[Drulma](https://www.drupal.org/project/drulma) theme, which is built on the
**Bulma** CSS framework. Some functionality belongs in a module rather than a
theme — Drupal blocks, template suggestions, and a Drush command — and this is
where Drulma puts it. In practice it does three things:

- **Bulma‑styled blocks** — a **Navbar with branding** (a Bulma navbar that can
  carry a logo, the site name, and optional left/right menus, ideal at the top of
  the page or a hero header), **Bulma tabs** (Drupal's primary/secondary tabs
  rendered as Bulma tabs), and **Menu as Bulma tabs** (a Drupal menu shown as Bulma
  tabs) — the tab blocks are meant to sit at the footer of a hero.
- **Font Awesome 5 template suggestions** for inputs, submit buttons, and similar
  elements.
- A **Drush subtheme generator** — `drush generate drulma` — to scaffold a Drulma
  subtheme (this lives in the module because Drush cannot run generate commands
  that ship inside a theme).

It depends on the **Block Class** module, because Bulma relies on CSS classes to
style elements: Block Class lets you add container or section classes to any block
so its display is transformed. The module has no content or access role of its
own, and no settings form. This release targets Drupal 11.1.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (required) and
   enable the module.

There is **no configuration page** for this module — the blocks it provides are
configured individually where you place them, as described below.

## Where it lives in the admin menu

Drulma Companion adds no settings page. You use it from **Structure → Block
layout** (`/admin/structure/block`), where its Bulma blocks (Navbar with branding,
Bulma tabs, Menu as Bulma tabs) become available to place into regions. Extra CSS
classes on blocks are managed through the Block Class module on each block's
configuration form.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)); this
   also brings in the Drulma theme.
2. Set Drulma (or a Drulma subtheme) as your active theme.
3. In **Structure → Block layout**, place the **Navbar with branding** block at the
   top of the page, and the tab blocks in a hero footer, as suits your design.
4. To scaffold your own subtheme, run `drush generate drulma` (prefix with `ddev`
   from the host).
5. To use Font Awesome 5 icons, install the Libraries‑provider **Font Awesome**
   module (Font Awesome is optional for Bulma).
