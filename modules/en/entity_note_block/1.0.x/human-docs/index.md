# Entity Note Block — manual setup guide

**Entity Note Block** (`entity_note_block`) lets editors and admins attach
**internal notes to any entity** — a node, a user, a taxonomy term, a product,
whatever — through a clean, AJAX-powered modal form. It provides a reusable
**block** that you place once; wherever that block appears, an "Add/View Notes"
control opens a modal where you can add a note, see all existing notes in a table
with their dates, and edit or delete them, all without reloading the page.

It's designed for private, staff-only jottings: change logs, moderation notes,
instructions for other editors, per-user or per-page reminders — the kind of
context you want recorded against the content but never shown to the public. Notes
are stored in the module's own database table, and it can optionally also create a
hidden `note_log` node for each note. Handily, the first time it's used it
**automatically creates** a `note_log` content type and its `field_entity_notes`
field, so there's nothing to build by hand.

Entity Note Block uses **Drupal core only** — no contrib dependencies — relying on
the core Node module and core's AJAX dialog and jQuery. It works with any entity
type and runs on Drupal 10, 11, and 12. It provides its own permissions, and since
the notes are internal you should make sure only staff can reach the block: no
special configuration is required to start saving notes, but do restrict the
block's visibility or access so its contents stay private. Note that it is **not**
covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** — you place the block and start using it, as
described in "How to use it" below.

## Where it lives in the admin menu

Entity Note Block adds a placeable block. You manage it from **Structure → Block
layout**, where you place the block labeled **Entity Note Block** in a region.

## How to use it

1. Go to **Structure → Block layout** and place the **Entity Note Block** block in
   a region (and, if you like, restrict its visibility to the pages or content
   types where you want notes).
2. **Restrict access to staff** — use the block's visibility settings, its access
   configuration, or the module's permissions so only trusted roles can see and add
   notes.
3. Visit a page where the block appears and click **Add/View Notes** to open the
   modal.
4. Add, edit, or delete notes in the modal — changes are saved via AJAX without a
   page reload. The first note also triggers automatic creation of the `note_log`
   content type and field.
