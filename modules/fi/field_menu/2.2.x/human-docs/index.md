# Field Menu — manual setup guide

**Field Menu** (`field_menu`) adds a new field type, **Menu item**, that stores a
pointer to a spot in one of your Drupal menus and renders the menu tree starting
from there. In other words, you can drop a live, self‑maintaining slice of a menu
onto any content — the classic use is a hand‑curated HTML **sitemap** page, but it
works equally well for "in this section" sub‑navigation or a documentation index.

Because the field reads the live menu tree at display time, the rendered list stays
in sync automatically: add or remove a menu link and every Field Menu that includes
that branch updates itself. It only outputs enabled links, so disabled menu items
never leak into your content.

You attach it like any other field, through the Field UI. Each field value lets an
editor choose a **root** menu item, an optional **title/heading** to show above the
tree, a **maximum depth** (how many levels deep to render), and whether to
**include the root** link itself or only its children. At the field level, a site
builder can restrict which menus the editor may choose from.

There is **no settings page** — everything is configured on the field and on the
entity's form/display, and there are no permissions or Drush commands of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Field Menu has no configuration page. You use it under **Structure → (content type
or other entity) → Manage fields** (the Field UI), and its output is themed through
the entity's display settings.

## How to use it

1. Go to the entity you want to add the menu to — for example **Structure → Content
   types → Basic page → Manage fields**.
2. **Add field**, choose **Menu item** as the field type, give it a label (such as
   "Sitemap"), and save.
3. On the field settings, optionally restrict which menus editors can pick a root
   from:
   - **Menu restriction** — list the menus to offer in the Root selector; leave it
     empty to offer all menus.
   - **Negate** — treat that list as a *hide* list instead, offering every menu
     except the ones you named (handy for hiding admin menus).
4. Now edit a piece of content of that type. The Menu item widget shows:
   - **Title** — an optional heading rendered above the tree.
   - **Root** — the menu item the tree should start from.
   - **Max depth** — how many levels deep to render (0 means unlimited).
   - **Include root?** — leave off to render only the children of the root; turn on
     to include the root link itself.
5. Save. The formatter renders the chosen menu branch as a nested list wherever the
   field appears in the entity's display.

You can set the field to allow more than one value to compose a multi‑branch
sitemap, and the rendered tree exposes extra theme hook suggestions (by entity
type, bundle, view mode, and menu name) if you want to style a particular one
differently.
