# Extra Paragraph Types (EPT): Block — manual setup guide

**EPT Block** (`ept_block`) adds a paragraph type whose content is a **referenced
Drupal block** — so an existing block can be placed into a page's flow like any
other paragraph component.

Component‑built pages create a specific gap: the page is assembled from paragraphs,
but some of the things that belong in it already exist as blocks — a shared call to
action, a contact panel, a Views listing, something a module provides. Rebuilding
those as paragraph types would duplicate them and leave two things to maintain.
Referencing them instead keeps a single definition and lets the editor position it.
That is the reasoning behind the `block_field` field type this paragraph is built on.

It is part of the **Extra Paragraph Types (EPT)** family, sharing the
[`ept_core`](https://www.drupal.org/project/ept_core) base and its design options
(CSS box spacing, borders; background by colour, image or video; edge‑to‑edge or
container width).

**The permission question is the one to raise**, because a block reference is a
broader capability than it looks. A block can render arbitrary markup and attach
JavaScript libraries, so an editor who can place *any* block into a page has
something closer to a site‑building capability than an editing one. **Which blocks
the field offers is the real control** — an unrestricted list of every block on the
site is a much larger grant than a curated set, so restrict the allowed blocks
deliberately. Two related points: a **Views block** embedded this way runs a view
inside the page, with its own access and filters, so the result varies by viewer and
the page's cache metadata must account for it; and a block placed in content is
**rendered at display time**, so updating the block updates every page that
references it — which is the point, and worth editors knowing.

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

EPT Block adds no standalone admin settings page. The Block paragraph type becomes
available wherever a **Paragraphs** field allows it, and its shared design options
come from `ept_core`. To let a content type use it, add or edit a Paragraphs field
at **Structure → Content types → *(type)* → Manage fields** and allow the Block
paragraph type — and, importantly, restrict which blocks the field may reference.

## How to use it

1. Make sure a content type has a **Paragraphs** field permitting the **Block**
   paragraph type. On the field settings, **limit the selectable blocks** to a
   curated set rather than every block on the site.
2. Edit content, add a **Block** paragraph, and choose the block to embed (for
   example a shared CTA, a contact panel, or a Views listing).
3. Adjust the `ept_core` design options (spacing, background, width) so the embedded
   block sits well in the section, and save.
4. Remember the block is rendered at display time: editing the referenced block
   updates every page that references it, and a Views block's output will vary by
   viewer.

Because the whole family shares `ept_core`, adopting one EPT module makes adopting
the others cheap — sites often end up using several together.
