# Term Revision — manual setup guide

**Term Revision** (`term_revision`) brings revision support to taxonomy terms.
Once enabled, edits to a term keep a history you can review and roll back, giving
terms the kind of accountability that nodes and other content entities already
enjoy in Drupal core.

Out of the box, Drupal keeps a version history for content like nodes, but plain
taxonomy terms do not track their changes — once a term is edited, the previous
wording is gone. Term Revision fills that gap. It lets you view all the revisions
of a term in a tabular list, open any specific revision to see what it contained,
delete a revision, and revert a term to an earlier version. That is valuable
anywhere term changes need history or accountability — a controlled vocabulary
maintained by several editors, for example, where you want to see who changed what
and be able to undo a mistaken edit.

The module works essentially on‑enable: install it, clear the cache, and taxonomy
terms gain revision support. It has **no special dependencies beyond core** and
ships no submodules. What it *does* add is its own set of **permissions**, which
govern who may view or revert term revisions — grant these to trusted editors, as
reverting a term is an editorial action. It supports **Drupal 8.8 through 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, clear the cache, and grant the revision permissions.

## How to use it

After enabling the module and clearing cache, revision support appears on taxonomy
terms:

1. Grant the module's revision permissions to the roles that should manage term
   history, under **People → Permissions** (`/admin/people/permissions`). These
   control who can view and revert term revisions — keep them to trusted editors.
2. Edit a taxonomy term as usual. A new revision is recorded for the change.
3. On the term, use the revisions view to see the tabular list of revisions, open a
   specific revision to inspect it, delete a revision you no longer need, or
   **revert** the term to a previous version.

Term Revision is an editorial/history feature only — it does not control who can
*read* content. Who may view or revert revisions is governed entirely by its
permissions.
