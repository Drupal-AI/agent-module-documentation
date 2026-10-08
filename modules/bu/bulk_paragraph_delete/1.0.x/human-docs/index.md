# Bulk Paragraph Delete — manual setup guide

**Bulk Paragraph Delete** (`bulk_paragraph_delete`) lets administrators delete
multiple Paragraphs types at once from the admin UI, instead of removing them one
at a time. It is handy when you are cleaning up a site's paragraph configuration —
for example after a redesign that leaves several unused paragraph types behind.

Deleting paragraph types is **destructive** — it affects configuration and any
content built from those types — so the module follows the normal Paragraphs
administration access and should be restricted to trusted admins. As with any
bulk delete, back up first. It depends on the **Paragraphs** module and supports
Drupal 10.3+ and 11 (this release is `1.0.1`).

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires Paragraphs).

## Where it lives in the admin menu

The module adds bulk deletion for Paragraphs types into the admin UI, gated by
Paragraphs administration access — so it is available to the same trusted admins
who already manage paragraph types.

## How to use it

1. Install and enable `bulk_paragraph_delete` (see
   [Installation](installation/index.md)).
2. Make sure only trusted admins have Paragraphs administration access, since
   that is what governs this tool.
3. **Back up first** — deleting paragraph types is destructive and affects both
   configuration and content.
4. From the admin UI, select the paragraph types you want to remove and delete
   them in one operation.
