# Entity Revision Diff — manual setup guide

**Entity Revision Diff** (`entity_revision_diff`) brings the **Diff** module's
visual revision comparison to non‑node content entities: **Block Content**,
**Media**, **Taxonomy Term**, and — when the Group module is present —
**Group**. On each entity's revisions tab you get radio buttons to pick two
revisions, and the Diff module renders the difference in a unified, split or
visual‑inline layout.

The gap it fills is a real one. Drupal 10.2+ and 11 core give these entities a
version‑history UI, but only a plain list — no visual comparison and no way to
select two revisions to diff. The Diff module adds that comparison, but out of the
box only for nodes. Entity Revision Diff wires Diff's comparison into the other
revisionable entity types, so editors and auditors can see exactly what changed
between two versions of a custom block, a media item, a taxonomy term, or a group.

It works once you enable it alongside Diff and grant the relevant revision
permissions — there is no settings form to fill in. The module also handles
translation‑aware reverts and exposes a Views field for the current revision ID.
It replaces the deprecated `entity_diff_ui` module, keeping the same URLs and
permissions for backward compatibility. Access follows the Drupal model: every
revision route requires the appropriate entity view/update access **and** the
module's own revision permissions, so it never loosens who can see or revert
content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its Diff dependency.

This module has no settings form. Setup is a matter of granting the right
permissions and using each entity's revisions tab, described below.

## Where it lives in the admin menu

Entity Revision Diff adds no central admin page. You use it from each entity's
**Revisions** tab, and control access from **People → Permissions**. The revision
and comparison paths are:

| Entity type | Version history | Diff comparison |
|-------------|-----------------|-----------------|
| Block Content | `/admin/content/block/{id}/revisions` | `.../revisions/view/{left}/{right}` |
| Media | `/media/{id}/revisions` | `.../revisions/view/{left}/{right}` |
| Taxonomy Term | `/taxonomy/term/{id}/revisions` | `.../revisions/view/{left}/{right}` |
| Group | `/group/{id}/revisions` | `.../revisions/view/{left}/{right}` |

(Node revisions are handled by the Diff module directly.)

## How to use it

1. Under **People → Permissions**, grant the revision permissions your editors
   need. The module provides global permissions per entity type — **view all /
   revert all / delete all {entity_type} revisions** — and, generated dynamically
   per bundle, **view / revert / delete {bundle} revisions**.
2. Open a supported entity's **Revisions** tab. You will see the revision list with
   radio buttons.
3. Select two revisions and compare them. The Diff module renders the difference in
   your chosen layout (unified, split, or visual inline).
4. To roll back, use the revert action — reverts are translation‑aware.
