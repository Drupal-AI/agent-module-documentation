# Taxonomy Multi-delete Terms — manual setup guide

**Taxonomy Multi-delete Terms** (`taxonomy_multidelete_terms`) adds a checkbox to
every row of a vocabulary's term list, plus a **Delete** button, so an editor can
select many taxonomy terms and delete them all at once instead of removing them
one at a time. It is the quick answer to cleaning up an imported vocabulary full
of junk terms, purging test tags, or clearing out a whole vocabulary while keeping
the vocabulary itself.

The feature appears right on the standard core **Manage terms** page — there is no
separate admin screen. When you select some terms and click **Delete**, the module
shows a confirmation page listing exactly which terms will go (with a reminder that
deleting a term also deletes its child terms), and on confirm it runs the deletion
as a batch process so even large vocabularies don't time out. Afterwards you get a
tidy "N terms deleted" message.

Access is gated by a single permission, **Users can delete multiple taxonomy terms
at the same time** (`access taxonomy multidelete terms`) — the checkboxes and
Delete button simply don't appear for users who lack it, so you can keep bulk
deletion in trusted hands. The module has no settings form, no configuration, and
no Drush commands; it depends only on core **Taxonomy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

## Where it lives in the admin menu

There is no dedicated page. The bulk‑delete controls appear on the existing
**Structure → Taxonomy → *(your vocabulary)* → Manage terms** overview page
(`/admin/structure/taxonomy/manage/{vocabulary}/overview`), for users who hold the
`access taxonomy multidelete terms` permission.

## How to use it

1. Grant the **Users can delete multiple taxonomy terms at the same time**
   permission to the roles that should have it, at **People → Permissions**
   (`/admin/people/permissions`).
2. Go to a vocabulary's **Manage terms** page. Each term row now has a checkbox,
   and there is a "select all" checkbox in the header.
3. Tick the terms you want to remove and click **Delete**.
4. On the confirmation page, review the list of terms (remember that a term's
   children are deleted along with it) and confirm. The terms are deleted in a
   batch, and you'll see a "terms deleted" message when it finishes.
