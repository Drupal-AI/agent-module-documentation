# Notebook — manual setup guide

**Notebook** (`notebook`) is a small admin tool for jotting down quick notes inside
Drupal. Each note has a **subject**, a **body**, and an optional **10‑digit phone
number**, stored in a dedicated `notebook_table` database table. It's handy for
keeping lightweight reminders, operational memos, or follow‑up contact details
without creating full content nodes.

After enabling the module and clearing caches, a **Notebook** link appears in the
admin menu. From there you get a page that combines an add‑note form with a paged
list of saved notes (four per page); each note can be opened to read in full,
edited, or deleted. Everything goes through Drupal's database API, and the phone
field is validated to ten digits.

A few things are worth knowing before you rely on it. Every notebook page requires
the **administer notebook** permission, so notes are never exposed to anonymous
visitors — but there is **no per‑user ownership**: it's a single **shared** notebook
that everyone with the permission can see and edit, not private per‑user notes.
Grant the permission only to trusted staff. This is an actively maintained but
simple module (not covered by Drupal's security advisory policy), so treat it as a
convenient internal scratchpad rather than a place for anything sensitive.

There is **nothing to configure** — no settings form. Once enabled and the
permission is granted, you use it entirely through its own pages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant the permission.

There is **no configuration page** — the module has no settings form. Setup is just
installing it and granting the *administer notebook* permission; usage is described
below.

## Where it lives in the admin menu

Once enabled (and after a cache clear), a **Notebook** link appears in the admin
menu. The main page lives at `notebook/page`, with related pages at `add/notes`
(add a note) and `notes/desplay` (the paged list, with View and Remove links).

## How to use it

All pages require the **administer notebook** permission:

1. Open **Notebook** from the admin menu (or go to `notebook/page`).
2. **Add a note:** fill in the subject (required), body (required) and optionally a
   10‑digit phone number, then save. You can also use the standalone add form at
   `add/notes`.
3. **Browse notes:** the list shows four notes per page, each with a link to view
   the full note and a link to remove it.
4. **View / edit / delete:** open a note to read it in full, edit its subject, body
   or phone, or delete it when it's no longer needed.

Because the notebook is shared among everyone with the permission, treat it as a
team scratchpad and avoid storing confidential information in it.
