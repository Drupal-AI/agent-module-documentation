# Configuration

A **taxonomy menu** is a configuration entity that maps one vocabulary to one
menu and generates a menu link per term. You can create as many as you like.

## Manage taxonomy menus

Go to **Structure → Taxonomy menu** (`/admin/structure/taxonomy_menu`). This page
lists your existing taxonomy menus and offers an **Add taxonomy menu** button.
Every page here requires the core **Administer site configuration** permission.
From the list you can also edit or delete each mapping.

## Creating or editing a taxonomy menu

The add/edit form has these options:

- **Label** — a human‑readable name for this mapping (its machine name is
  derived from it).
- **Vocabulary** — the source vocabulary whose terms become menu links.
- **Menu** — the target menu the generated links are added to (for example Main
  navigation, Footer, or a custom menu).
- **Depth** — the maximum term depth to generate, from 1 to 9 levels. Use this to
  keep a deeply nested vocabulary from producing an unwieldy menu.
- **Expanded** — when on, all generated entries render expanded, so child terms
  show without the visitor having to click a parent first.
- **Menu parent** — an existing menu link to hang the generated tree under, so
  the taxonomy tree becomes a branch of a larger menu rather than sitting at the
  top level.
- **Description field** — an optional term field whose value is used as each menu
  item's description (its hover title). Leave it unset for no descriptions.
- **Use term weight order** *(on by default)* — order the menu items by the
  terms' weight; turn it off to fall back to alphabetical order.

Saving the form generates (or regenerates) the menu links immediately. The
entity records configuration dependencies on the chosen menu and vocabulary, and
being a config entity it exports and deploys with `drush config:export` /
`config:import`.

## How the menu stays in sync

You do not maintain the generated links by hand:

- **Adding a term** creates its menu link automatically.
- **Renaming a term** updates the link title (titles are rendered live from the
  term, including translations, so they always match).
- **Deleting a term** removes its link.
- **Unpublishing a term** disables its link so it stops showing.

## What you can and cannot change on generated links

Generated menu items are partly editable: you may reorder them and toggle their
**weight**, **expanded**, **enabled**, and **parent** settings. Their titles,
descriptions, and which menu they belong to are locked so the menu keeps
resembling the taxonomy tree.

Menu items are heavily cached — if a menu does not reflect recent bulk changes,
clear the site cache (`drush cr`).
