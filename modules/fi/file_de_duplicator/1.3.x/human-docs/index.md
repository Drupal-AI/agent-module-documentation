# File De-Duplicator — manual setup guide

**File De-Duplicator** (`file_de_duplicator`) helps you find and remove
duplicate copies of uploaded files. Over the life of a site the same file often
gets uploaded again and again — the same PDF attached to ten pages, the same
logo re-uploaded by different editors — and every copy takes up disk space on
the server and in every backup. This module detects those duplicates by
comparing a hash of each managed file, then lets you consolidate them so that
all the references point at a single stored copy.

Because de-duplication *rewrites file references* — pointing many entities at one
shared file and removing the redundant copies — it is a trusted-operator tool,
not something to hand to everyday editors. It ships its own permission so you can
restrict who may run it, and the sensible habit is to **take a backup before you
run a de-duplication pass**, since the reference rewriting is not something you
want to undo by hand. The module has no access-control role beyond its own
permission; it simply saves storage.

It depends only on core's **File** module and works on Drupal 8, 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no dedicated settings form for this module — you grant its permission
and run the de-duplication as a maintenance task, described below.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Grant the module's permission (on **People → Permissions**) only to a trusted
   administrator role — de-duplication rewrites file references site-wide.
3. **Back up your database and files first.** The consolidation step is a bulk
   rewrite and there is no one-click undo.
4. Run the de-duplication pass to find files that share the same hash and merge
   their usage onto a single retained copy, freeing the duplicate storage.

Treat it as an occasional housekeeping/maintenance operation rather than
something that runs on every upload.
