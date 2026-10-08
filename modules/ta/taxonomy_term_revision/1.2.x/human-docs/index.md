# Taxonomy Term Revision — manual setup guide

**Taxonomy Term Revision** (`taxonomy_term_revision`) gives taxonomy terms the
same revision experience that nodes have had for years. Drupal core actually
*stores* term revisions under the hood, but it exposes almost nothing for working
with them. This module fills in the missing pieces: a Revisions tab that lists
every saved version of a term, with view, revert and delete operations, a
revision log message field on the term form, and content moderation support for
terms.

Once enabled, **every term save creates a new revision**, stamped with the
current user and time — there is no per-vocabulary toggle, so terms start behaving
like always-revisioned content. Editors get a *Revision log message* box on the
term edit form to record why they made a change, and a Revisions tab where they
can review history, roll back a bad edit, or delete an unwanted revision.

The module also enables Drupal's content moderation workflows on taxonomy terms —
something core deliberately leaves switched off — so terms can move through
editorial states just like nodes. Four permissions let you decide who can see
revision history, view individual revisions, revert, and delete.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the revision permissions.

## Where it lives in the admin menu

There is no central settings page. The features appear on individual taxonomy
terms:

- **Revisions tab** — `/taxonomy/term/{term}/revisions` lists every revision.
- **View a revision** — `/taxonomy/term/{term}/revision/{revision_id}`.
- **Revert** and **Delete** — confirmation forms linked from the Revisions tab.
- **Revision log message** — a text box added to the term add/edit form.

Who can use each operation is controlled by permissions at **People →
Permissions** (`/admin/people/permissions`).

## How to use it

1. Grant the relevant permissions to your editorial roles (see
   [Installation](installation/index.md)).
2. Edit a taxonomy term. You will see a new **Revision log message** field —
   optionally note what you changed — then save. A new revision is recorded
   automatically on every save.
3. Open the term's **Revisions** tab to see the history. From there you can view
   an older version, **revert** the term to it, or **delete** a revision you no
   longer need.
4. If you use content moderation, you can now target taxonomy terms with a
   workflow, because this module registers the moderation handler that core
   leaves unset.

> **Heads-up for sites that save terms programmatically** (migrations, imports,
> cron sync): because every save creates a revision and there is no opt-out,
> term-revision tables will grow. That is expected behaviour, but worth planning
> for on high-volume sites.

The four permissions are:

| Permission | What it allows |
|---|---|
| **View term revision list** (`view term revision list`) | See the Revisions tab and its list of versions. |
| **View term revision data** (`view term revision data`) | Access to revision data. |
| **Revert term revision** (`revert term revision`) | Roll a term back to an earlier revision. |
| **Delete term revision** (`delete term revision`) | Remove a revision. |

Grant *view* to editors while keeping *revert* and *delete* limited to trusted
roles or administrators. Note that viewing a single revision page uses normal term
view access, so anyone who can view the term can view an individual revision by
its id.
