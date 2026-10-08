# Bulk Term Delete — manual setup guide

**Bulk Term Delete** (`bulk_term_delete`) adds a way to delete several taxonomy
terms at once, straight from the terms list page. Normally Drupal makes you
delete taxonomy terms one at a time; this module lets you tick several and
remove them together, which is a big time-saver when you are cleaning up or
reorganizing a large vocabulary.

It builds directly on core's Taxonomy module and doesn't add any new
configuration — the extra bulk-delete capability simply appears on the term
overview page you already use.

Deleting terms is destructive, so the module respects Drupal's taxonomy
administration permissions: a user can only bulk-delete terms they would have
been allowed to delete individually. Use it deliberately — removing a term can
affect any content that references it, so it is worth being sure before you
batch-delete.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Bulk Term Delete has no settings page. It works on the taxonomy term overview
page for each vocabulary, at **Structure → Taxonomy → (your vocabulary) → List**
(`/admin/structure/taxonomy/manage/{vocabulary}/overview`).

## How to use it

1. Go to **Structure → Taxonomy** and open the vocabulary you want to clean up.
2. On the term list, select the terms you want to remove.
3. Delete the selected terms in one operation.

Because deletion is permanent and can affect content that references the terms,
review your selection carefully before confirming. Access is governed by your
normal taxonomy administration permissions.
