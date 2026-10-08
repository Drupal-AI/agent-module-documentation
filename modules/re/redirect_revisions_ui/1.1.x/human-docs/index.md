# Redirect Revision UI — manual setup guide

**Redirect Revision UI** (`redirect_revisions_ui`) surfaces the **revision
history** of Redirect entities in the admin UI. The Redirect module can keep
revisions of each redirect, but out of the box there's no comfortable way to
browse that history. This module adds a **Revisions** tab to each redirect so you
can view the version history, look at an individual revision, revert to an earlier
one, or delete a revision — each action gated by its own dedicated permission.

Technically it adds no routes of its own. It hooks into the revision routes
Drupal already provides for redirects and marks them as admin routes (so they
render in the admin theme), then gates each with a specific permission. That means
you can hand out **view**, **revert**, and **delete** capabilities independently
to the roles you trust, on top of core's normal redirect access checks.

The permissions it provides are:

- `view any redirect history` — see the Revisions tab / version‑history list.
- `view any redirect revisions` — view an individual past revision.
- `revert any redirect revisions` — roll a redirect back to an earlier revision.
- `delete any redirect revisions` — delete a specific revision.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Redirect.

There is **no configuration page** for this module. The only "setup" after
enabling it is granting the revision permissions to the right roles at **People →
Permissions** (`/admin/people/permissions`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. At **People → Permissions**, grant the four revision permissions above to the
   roles that should manage redirect history.
3. Edit any redirect under **Configuration → Search and metadata → URL
   redirects** (`/admin/config/search/redirect`). A **Revisions** tab now appears
   on that redirect, where authorized users can view, revert, or delete
   revisions.
