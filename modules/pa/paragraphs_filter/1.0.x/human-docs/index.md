# Paragraphs Filter — manual setup guide

**Paragraphs Filter** (`paragraphs_filter`) helps you keep large paragraph
libraries manageable by tying each paragraph type to the **content types** it
belongs to. Once you've made those associations, it filters two things by them: the
**paragraph types admin list** (so administrators can narrow it to the types used by
a chosen content type) and the **paragraph reference widget on a node** (so a node's
Paragraphs field only offers the paragraph types relevant to that content type).

This is most useful when a site has grown many paragraph types and it has become
confusing for editors and admins to find the right one. You assign one or more
content types to each paragraph type; leaving a paragraph type's selection **empty**
means "no filtering — available everywhere." The associations are stored in
configuration (keyed by paragraph type), so they export and deploy with the rest of
your config, and when you delete a paragraph type its stored association is cleaned
up automatically.

Two things are worth knowing. The reference‑widget filtering applies to **node**
entity‑reference (Entity Reference Revisions) Paragraphs fields. And **chained**
paragraphs — paragraphs nested inside other paragraphs — are **not** restricted by
the filter. The module is configuration‑only: it works entirely inside the standard
structure and field admin forms, defines no routes, permissions, or services of its
own, and therefore inherits those admin pages' existing access controls.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** for this module. You set the
associations directly on each paragraph type's add/edit form, and use the filter on
the paragraph types list — both described in "How to use it" below.

## Where it lives in the admin menu

- Associations are set on each paragraph type at **Structure → Paragraph types →
  *(type)* → Edit** (`/admin/structure/paragraphs_type`), where the module adds a
  **Content types** checkboxes element.
- The filtered list and its exposed filter also live at **Structure → Paragraph
  types** (`/admin/structure/paragraphs_type`); you can deep‑link a filtered view
  with a `?content_type=` query parameter.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Paragraph types**, edit a paragraph type, and in the
   **Content types** checkboxes choose the content types where that paragraph type
   should be offered. Leave the boxes empty to keep it available everywhere. Repeat
   for each paragraph type you want to scope.
3. Back on the **Paragraph types** list, use the filter to narrow the list to the
   paragraph types tied to a chosen content type (and reset it to show all again).
4. On a node's Paragraphs (Entity Reference Revisions) field, the drag‑and‑drop list
   of target paragraph types is now restricted to those associated with that node's
   content type — reducing editor confusion. (Remember that nested/chained
   paragraphs are not restricted.)

> **Tip:** to remove the filtering entirely and restore the full, unfiltered
> paragraph types list, simply disable the module.
