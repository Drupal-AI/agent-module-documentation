# Taxonomy term locks — manual setup guide

**Taxonomy term locks** (`taxonomy_term_locks`) lets you flag individual taxonomy
terms as *"locked"* so that ordinary editors cannot edit or delete them through the
term forms. It is an editorial guardrail for protecting canonical or reference terms —
official category names, structural terms, anything you want to keep stable — from
accidental change on a site with many editors.

The way it works: on the term add/edit form, users who hold the **set taxonomy term
lock** permission see a **Locked** checkbox. Once a term is locked, only users with the
**bypass taxonomy term lock** permission (a restricted permission for trusted roles)
can reach its edit or delete pages or see its operations links — for everyone else the
delete and edit forms return a 403 and the operations links are stripped from the
taxonomy overview. The module also offers a service (`taxonomy_term_lock.term_lock`)
with `bulkSetLocks` and `bulkDeleteLocks` functions for setting or removing locks
programmatically in bulk. Lock flags are stored in the module's own database table. It
depends on no other modules beyond core taxonomy.

**Important — this is a UI guardrail, not a hard access boundary.** Enforcement is
**form-level only**: the module alters the standard term edit, delete, and overview
forms, but it does **not** implement `hook_entity_access`. That means term edits or
deletes performed through other paths — JSON:API or REST, Views Bulk Operations, or
custom code — are **not** blocked by the lock. Treat it as protection against accidental
changes in the admin UI, and if you need a genuine access boundary, pair it with proper
entity-access controls. Note also this project is **not covered by Drupal's security
advisory policy**.

There is no settings page — you lock terms right on the term forms, and you control who
can lock and who can bypass through two permissions.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and set the two permissions.

## How to use it

1. Grant the two permissions on **People → Permissions**
   (`/admin/people/permissions`): give **set taxonomy term lock** to editors who
   should be able to lock and unlock terms, and reserve **bypass taxonomy term lock**
   for the trusted roles that should still be able to edit or delete locked terms.
2. Edit (or add) a taxonomy term as a user with the *set* permission. You will see a
   **Locked** checkbox — tick it to lock the term, untick it to unlock.
3. Once a term is locked, editors without the *bypass* permission no longer see its
   edit/delete operations, and attempts to reach those forms return a 403. Users with
   *bypass* still see and can use the operations.
4. To lock or unlock many terms at once, use the `taxonomy_term_lock.term_lock`
   service's `bulkSetLocks` / `bulkDeleteLocks` functions from custom code.
