# Display Suite — manual setup guide

**Display Suite** (`ds`) gives you drag-and-drop control over how entities are
displayed — without writing a single Twig template. Instead of hand-editing
theme files, you pick a **layout** (a set of rows and columns) for a view mode,
then drag each field into one of the layout's **regions**. On top of that you can
add virtual **custom fields** (token, Twig, block, or copy fields), reset or wrap
field markup with **field templates**, and attach reusable **CSS classes** to
regions — all from the admin UI.

Display Suite builds on Drupal core's Layout API (the `layout_discovery`
module), so the layouts it applies are ordinary layout plugins and everything it
configures is stored as exportable configuration on the entity view display. That
means displays you build in one environment deploy cleanly to the next.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to applying your
first layout. If you are looking for terse, token-cheap references for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Display Suite Displays overview at /admin/structure/ds](images/structure.png)

## Where it lives in the admin menu

Display Suite's own control panel sits under **Structure → Display Suite**
(`/admin/structure/ds`). As the screenshot above shows, that page is organised
into a set of primary tabs:

- **Displays** — the landing tab. It lists every entity type and bundle on the
  site (Article, Blog post, Basic page, and so on), each with a **Manage
  display** button that jumps straight to that bundle's display settings. This
  tab has its own secondary tabs: **List** (the entity list you see here),
  **Settings** (global Display Suite options), and **Emergency** (disable all DS
  layouts if one breaks a page).
- **Classes** — define reusable CSS classes that you can later attach to layout
  regions.
- **Fields** — define reusable custom (virtual) fields — token, Twig, block, and
  copy fields — that you can then place on any display.

The layouts themselves are not applied here — you apply them on each entity's own
**Manage display** screen, which this page links to. See
[Configuration](configuration/index.md) for the full workflow.

## Contents

1. [Installation](installation/index.md) — install Display Suite with Composer,
   enable it, and note its optional submodules.
2. [Configuration](configuration/index.md) — tour the Display Suite control panel
   and walk through applying a layout, arranging fields into regions, and adding
   custom fields and classes.
