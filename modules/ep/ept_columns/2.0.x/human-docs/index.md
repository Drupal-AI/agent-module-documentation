# Extra Paragraph Types (EPT): Columns / Container — manual setup guide

**EPT Columns / Container** (`ept_columns`) adds paragraph types that **hold other
paragraphs** — a **columns** layout and a plain **container** — with the EPT
family's shared presentation settings. These are the structural pieces of a
paragraph‑based page builder, the ones without which the other components can only
be stacked.

A page assembled from a flat list of paragraphs can only stack them top to bottom.
Putting two components side by side, or wrapping several in a band with a
background, needs a paragraph that *contains* paragraphs. The **columns** type does
the side‑by‑side arrangement (with settings for column width); the **container** is
the more useful of the two in practice, because it is what turns a group of
components into a **section** — something you can give a background, constrain to a
width, space as a unit, and move as a unit. That is how designers describe pages and
how editors want to work with them.

It is part of the **Extra Paragraph Types (EPT)** family, sharing the
[`ept_core`](https://www.drupal.org/project/ept_core) base and its design options
(CSS box spacing, borders; background by colour, image or video; edge‑to‑edge or
container width).

Three things follow from nesting, worth deciding early:

- **Depth is where paragraph interfaces become unusable.** Two levels is
  manageable; three is hard to navigate in the edit form; four means an editor is
  scrolling through a nested structure trying to work out which "Add paragraph"
  button belongs to which container. Limiting the allowed depth is a design decision
  worth making up front.
- **Column order on narrow screens is a content decision, not a styling one.**
  Which column comes first when they stack is what an editor cares about — a columns
  component that guesses will be wrong half the time.
- **Nesting multiplies revisions.** Paragraphs are revisioned with their host, so a
  deeply nested page creates many paragraph revisions per save — a real contributor
  to database growth on a page‑built site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, pull
   in the EPT base and Paragraphs, and enable it.

There is **no site‑wide configuration page** for this module. Like the rest of the
EPT family, it is configured **per paragraph instance** as an editor builds a page —
see "How to use it" below.

## Where it lives in the admin menu

EPT Columns / Container adds no standalone admin settings page. The Columns and
Container paragraph types become available wherever a **Paragraphs** field allows
them, and their shared design options come from `ept_core`. To let a content type
use them, add or edit a Paragraphs field at **Structure → Content types → *(type)* →
Manage fields** and allow the Columns and/or Container types — including as nested
Paragraphs fields inside them.

## How to use it

1. Make sure a content type has a **Paragraphs** field permitting the **Columns**
   and **Container** types, and that those types are allowed to contain the child
   paragraph types you want to nest.
2. Edit content, add a **Container** to group components into a section (give it a
   background and width via the `ept_core` design options), or add a **Columns**
   paragraph and set the column widths.
3. Add child paragraphs inside — and keep the nesting shallow (two levels is
   comfortable). For columns, decide the stacking order for narrow screens.
4. Save. The container/columns render as a structured section of the page.

Because the whole family shares `ept_core`, adopting one EPT module makes adopting
the others cheap — sites often end up using several together.
