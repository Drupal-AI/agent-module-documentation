# Configuration

Entity Submenu Block has no global settings page. You configure it **per placed
block**, on the block's settings form when you place it (or later via its
**Configure** link).

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`) and choose the
   region where the submenu should appear.
2. Click **Place block** and select the derivative for the menu you want,
   labelled *"(Menu name) (Entity Submenu Block)"* — e.g. the one for your **Main
   navigation** menu.
3. Set the options below, choose a region, add any core visibility conditions
   (pages, roles, content types) as you would for any block, and **Save**.

The block shows child items only when the current page is somewhere in that menu's
trail — it renders the children at the level *below* the current page.

## Block options

Alongside the standard core menu-block settings, the block adds these:

- **View modes (per entity type)** — for each eligible entity type (always
  `node`, plus any entity type that has a field UI and can be rendered), pick the
  **view mode** used to render that type's child links. For example, set `node` to
  **Teaser** to show child pages as teasers. Choosing **"- None -"** for a type
  disables rendering for it, so its links are skipped.
- **Display non-entities** — when on, menu links that don't point to a content
  entity (including external links) are still rendered, as plain `<a>` links.
  When off *(default)*, only entity-backed links appear.
- **Only current language** — when on, entities that don't have a translation in
  the current content language are skipped. Useful on multilingual sites so the
  submenu only shows content available in the visitor's language.
- **Show the block, even if empty** — when on, the block's wrapper still renders
  even when there are no child items (handy as a placeholder that a template can
  target). When off *(default)*, the block hides itself entirely on pages with no
  children.

## What "eligible entity type" means

The per-type view-mode list is built from `node` plus any entity type that has a
Field UI base route and a view builder — in practice the content entity types you
can render, such as nodes and taxonomy terms. Types that can't be rendered simply
don't appear in the list.

## Theming (optional)

Output goes through the `entity_submenu` wrapper template
(`entity-submenu.html.twig`) and, for plain links, `entity-submenu-item.html.twig`.
A template suggestion `entity_submenu__<menu_name>` lets you theme one menu's block
specifically — copy the template into your theme and adjust the markup. The block
caches correctly per menu active trail, so it updates as the visitor moves through
the site.
