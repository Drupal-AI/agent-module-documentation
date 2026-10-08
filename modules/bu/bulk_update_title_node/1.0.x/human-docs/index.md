# Bulk Update Title Node — manual setup guide

**Bulk Update Title Node** (`bulk_update_title_node`) is a find-and-replace tool
for node titles. You choose a content type, type in a piece of text to look for
and the text to replace it with, and the module updates the title of every
matching node in one batch operation. The search is case-insensitive and matches
partial titles, so you can fix a recurring typo, rebrand a product name, or
normalize wording across hundreds of nodes without editing each one by hand.

It runs the updates through Drupal's Batch API, so a large replace won't time
out — it processes the nodes in chunks and shows progress. Before it runs, it
checks that at least one node actually matches, so you get a sense of the scope
first.

The tool is a single admin form and has no other configuration. Access is
controlled by its own **`access bulk update titles nodes`** permission, and the
form respects node access when it looks for matches, so users only affect nodes
they are allowed to see.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

## Where it lives in the admin menu

The tool lives under **Content**, at `/admin/content/bulk-update` (route
`bulk_update_title_node.bulk_update`). You need the **`access bulk update titles
nodes`** permission to reach it.

## How to use it

1. Grant the **`access bulk update titles nodes`** permission to the roles that
   should be able to bulk-rename titles (**People → Permissions**).
2. Go to **Content → Bulk update** (`/admin/content/bulk-update`).
3. Pick a **content type** to scope the change.
4. Enter the text to **find** (a full or partial title) and the text to
   **replace** it with.
5. Submit. The form first confirms how many nodes match, then batch-updates each
   matching title and saves the nodes.

Because this changes many titles at once and cannot be undone in bulk, double-check
your find/replace text — especially with short or common substrings — before you
run it.
