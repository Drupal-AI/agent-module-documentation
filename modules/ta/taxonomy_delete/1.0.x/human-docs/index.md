# Taxonomy Delete — manual setup guide

**Taxonomy Delete** (`taxonomy_delete`) is a small utility that bulk‑deletes
**every term in one or more vocabularies** in a single action — from either an
admin form or a Drush command. It exists to save you from the tedious core
workflow of clicking "Delete" on terms one at a time, which is painful for large,
imported, or test vocabularies. Typical uses: clearing out a trial migration's
terms, resetting a "Tags" vocabulary full of spam, or wiping demo terms between
QA runs.

The admin form lists all your vocabularies as checkboxes; tick the ones you want
emptied and submit, and the module deletes their terms using Drupal's Batch API —
one term per operation, so even huge vocabularies delete without PHP timeouts.
For developers and scripts, the Drush command `taxonomy-delete:term-delete` (alias
`tdel`) does the same job and prompts for confirmation.

The module has **no third‑party dependencies** and works on Drupal 8.8 through
11. It stores no configuration — it is purely an action tool. Access is
deliberately locked down: it provides a dedicated **Delete taxonomy terms**
permission (marked security‑sensitive), and the admin form additionally requires
the **Administer site configuration** permission, so a user needs **both** to
reach it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — using the delete form, the Drush
   command, permissions, and important warnings.

## Where it lives in the admin menu

The delete form is at **Structure → Taxonomy → Taxonomy Delete**
(`/admin/structure/taxonomy/taxonomy-delete`), and is also surfaced as a
"Taxonomy Delete" action link on the main Taxonomy vocabularies page.

## How to use it

Enable the module, grant the right permissions, then either open the Taxonomy
Delete form and tick the vocabularies to empty, or run
`drush tdel <vocabulary>` from the command line. Both are covered on the
[Configuration](configuration/index.md) page — read the warnings there first,
because deletion is immediate and irreversible.
