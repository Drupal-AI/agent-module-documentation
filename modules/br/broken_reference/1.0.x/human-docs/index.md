# Broken reference — manual setup guide

**Broken reference** (`broken_reference`) helps you find broken entity references
across your content — reference fields that point at entities which have been
deleted or no longer exist. Those dangling references can cause errors or produce
empty output, and they are easy to miss, so this module surfaces them for editors
and administrators to fix.

It is an administration and content‑integrity tool. It reads your reference fields
and reports the ones whose targets are missing; it is informational and has no
access‑control role of its own. It provides its own permissions to control who can
run the audit, and it works across Drupal 8 through 11 with no additional module
dependencies.

It is especially handy after bulk deletions or content migrations, when references
can be left pointing at content that is no longer there. Use it to audit content
integrity, then clean up or repoint the broken references it finds.

This guide is written for a **human** using the module through the admin UI. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.

## Where it lives in the admin menu

The module provides its own permissions, which you grant under **People →
Permissions** (`/admin/people/permissions`) to decide who may run the reference
audit. It reports broken references for you to act on; it does not change content
on its own.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Grant its audit permission to the administrator/editor role that should run it.
3. Run the detection to get a list of broken entity references, then fix the
   dangling references — for example by repointing the field to an existing entity
   or clearing it. Running it again after cleanup confirms the references are
   resolved.
