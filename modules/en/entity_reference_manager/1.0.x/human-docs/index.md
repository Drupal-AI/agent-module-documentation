# Entity Reference Manager — manual setup guide

**Entity Reference Manager** (`entity_reference_manager`) is an administrative tool
for safely **merging** taxonomy terms, nodes, and media entities. When you end up
with duplicate content — two vocabularies terms that mean the same thing, two node
records for the same subject — you usually want to keep one, delete the rest, and
make sure every reference that pointed at the deleted entities now points at the
survivor instead. Doing that by hand is risky and doing it with a custom script is
slow; this module gives you a guided interface for it.

You pick one or more **source** entities and a single **target** entity. The
module scans every reference field across the system that points at your sources
(including fields on revisions), shows you a detailed pre‑execution summary — which
field, which entity type, and how many references are involved — and then, after
you confirm, re‑points all those references to the target using Drupal's Batch API
so large jobs run reliably. You can choose to keep or delete the source entities
once the merge completes.

Because merging rewrites references and can delete entities, it is a powerful,
destructive operation: **restrict it to trusted administrators**. The module
provides its own permission for exactly this reason. It has no third‑party
dependencies and runs on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no site‑wide settings form** — there is nothing to configure in
advance. You use it directly through its merge interface, described in "How to use
it" below. Grant its permission only to administrators you trust.

## How to use it

1. Log in as a trusted administrator who has been granted the module's merge
   permission (see the permissions note below).
2. Open the Entity Reference Manager interface and choose the entity type you are
   working with (nodes, taxonomy terms, or media).
3. Select one or more **source** entities (the duplicates you want to merge away)
   and the single **target** entity they should be merged into.
4. Review the **analysis summary** the module generates — it lists each reference
   field, its entity type, and the number of references that will be re‑pointed.
   Nothing has changed yet at this stage.
5. **Confirm** to run the merge. The module re‑points every reference to the
   target using batch processing, and — depending on the option you chose —
   either keeps or deletes the source entities afterwards.

Because the operation is destructive, take a database backup before running a
large merge on a production site.

## A note on permissions

Entity Reference Manager defines its own permission controlling who may run
merges. Grant it at **People → Permissions** (`/admin/people/permissions`) only to
roles you fully trust, since a merge can rewrite references site‑wide and delete
content.
