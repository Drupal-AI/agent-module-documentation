# Paragraphs Admin — manual setup guide

**Paragraphs Admin** (`paragraphs_admin`) is a small companion to the contrib
**Paragraphs** module. Core Paragraphs gives you the paragraph field type and the
editing experience, but it never gives you a single place to see *all* the
paragraph entities on your site — or a way to delete a stray one on its own.
Paragraphs Admin fills exactly that gap.

Enabling it installs a **View** that lists every paragraph entity at
`/admin/content/paragraphs`, protected by the module's single permission,
**Administer paragraphs**. The listing includes a custom **Host Entity** column
that walks up each paragraph's parent chain to the top-level piece of content and
links to it — so you can instantly see which node (or other entity) a paragraph
belongs to. When a paragraph has no reachable host, it shows the label unlinked,
which is a useful signal that the paragraph is **orphaned** (its host content was
deleted). The module also adds a standard confirm-delete form at
`/paragraph/{id}/delete` so administrators can remove individual paragraphs.

There is no settings form and nothing to configure — the behaviour is delivered
entirely by the shipped View, the Host Entity Views field, and the delete route.
Because the listing is an ordinary View, you can clone or extend it (add filters by
paragraph type, exposed sorts, or extra fields) to build your own paragraph
overviews.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.

## Where it lives in the admin menu

Once enabled, the paragraph overview lives at **Content → Paragraphs**
(`/admin/content/paragraphs`), added as a tab under the content administration
area. It is visible only to users who hold the **Administer paragraphs**
permission.

## How to use it

- **Review every paragraph on the site.** Visit `/admin/content/paragraphs` for a
  single table of all paragraph entities, with the **Host Entity** column linking
  to the content each one belongs to.
- **Find orphaned paragraphs.** Rows whose Host Entity shows an unlinked label are
  likely orphans — paragraphs whose host content was deleted, or paragraphs nested
  inside a parent that has no page of its own.
- **Delete a single paragraph.** Go to `/paragraph/{id}/delete` (where `{id}` is
  the paragraph's ID) to get a standard confirm-delete form. This lets you clean up
  stray or orphaned paragraphs without editing their host entity.
- **Extend the listing.** Because `/admin/content/paragraphs` is a normal View
  (machine name `paragraphs`, base table `paragraphs_item_field_data`), you can
  clone it or add filters, sorts, and fields — including adding the **Host Entity**
  field to any other Paragraphs-based view.
