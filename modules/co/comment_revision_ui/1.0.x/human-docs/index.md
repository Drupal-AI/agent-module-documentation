# Comment Revision UI — manual setup guide

**Comment Revision UI** (`comment_revision_ui`) gives comments the same
**version‑history / revert / delete** interface that nodes already have. Comment
entities are revisionable in Drupal core, but core ships no user interface for
those revisions — so this module registers the standard entity‑revision pages for
comments: a version history list, individual revision views, a revert form, and a
revision delete form. It's useful for auditing moderation activity, tracking who
changed a comment and when, and restoring text lost to an accidental edit or
vandalism.

Access is controlled by a mix of "any" permissions and dynamic **per‑comment‑type**
permissions (for example *view* / *revert* / *delete* revisions for a specific
comment bundle), so you can be as broad or as granular as you like. The revision
pages are treated as admin routes, so they render in the admin theme. Under the
hood there are no custom controllers, forms, or external calls — everything flows
through core's own entity‑revision handlers and access system. Because reverting or
deleting a revision is a content‑mutation operation, grant those permissions only
to trusted roles.

**Important prerequisite:** this module relies on **core patches** to make comment
entities revisionable and to provide the generic revision UI it reuses. You must
apply those patches to your Drupal codebase for the module to work — see
[Installation](installation/index.md). It supports Drupal 9.1 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — apply the required core patches, install
   the module, run database updates, and assign permissions.

There is **no settings form** — configuration is entirely a matter of the required
patches and the permissions you grant (see Installation).

## Where it lives in the admin menu

Comment Revision UI adds no central admin page. Once the patches are applied and
permissions granted, the revision pages appear on individual comments (a
**Revisions** / version‑history tab), rendered in the admin theme. Permissions are
managed under the **Comment Revision UI** section at **People → Permissions**
(`/admin/people/permissions`).
