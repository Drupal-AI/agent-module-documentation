# Entity Delete — manual setup guide

**Entity Delete** (`entity_delete`) adds a single admin form for deleting
content entities *in bulk*. Instead of ticking rows one page at a time in a
content listing, you pick an entity type (Content, Users, Taxonomy terms,
Comments, Files, Log entries, or any custom content entity type), optionally
narrow it to one bundle, and delete everything that matches in one operation.
The work runs through Drupal's Batch API in chunks of 25, so even very large
content sets are removed without hitting a PHP timeout.

This is a maintenance and cleanup tool, and it is deliberately blunt. There is
nothing to configure — the module *is* a two-step delete form. You choose what
to delete on the first screen, then confirm on a second, token-protected screen
before anything is removed. A few entity types get sensible special handling:
deleting **Users** never touches the anonymous (uid 0) or main admin (uid 1)
accounts, and clearing **Log entries** truncates the `watchdog` table directly.

Because the deletions are permanent, with no dry-run and no undo, the whole
feature sits behind one security-sensitive permission (`use entity_delete`) that
you should grant only to trusted administrators. It is a great fit for wiping a
staging or QA site before a fresh import, resetting content after a
content-generation run, or decommissioning a data set — and a dangerous thing to
hand to anyone you would not trust with `drush entity:delete`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

## Where it lives in the admin menu

Once enabled, the delete form lives at **Configuration → Entity Delete**
(`/admin/config/entity-delete`). You will only see it if your account has the
**Use entity delete module** permission.

## How to use it

1. Go to **Configuration → Entity Delete** (`/admin/config/entity-delete`).
2. **Pick an entity type** from the *Entity type* dropdown. Only content entity
   types are listed (nodes, users, taxonomy terms, comments, files, log entries,
   plus any custom content entity types other modules provide).
3. **Pick a bundle** (or leave it on *All*). This second dropdown appears via
   AJAX once you choose an entity type — for example, choose *Content* and then a
   single content type such as *Article*, or leave it on *All* to delete every
   node. Some types (like comments) have no bundle to choose and show a note
   instead.
4. Submit the form. You are taken to a **confirmation screen** with a
   security token in the URL.
5. Click **Confirm** to run the deletion, or **Cancel** to go back. On confirm,
   the matching items are deleted in batches of 25 and you get a "Successfully
   deleted N …" message when it finishes.

A few things worth knowing before you click Confirm:

- **There is no undo.** Deletions go through normal entity storage (so hooks
  fire and translations are removed), except *Log entries → All*, which clears
  the `watchdog` table with a direct SQL truncate.
- **Users are protected.** Deleting all users always excludes the anonymous
  account (uid 0) and the main administrator (uid 1).
- **It respects bundles.** Choosing a bundle deletes only that bundle's content
  and leaves the other bundles untouched.
