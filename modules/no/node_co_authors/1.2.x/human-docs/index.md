# Node Co-Authors — manual setup guide

**Node Co-Authors** (`node_co_authors`) lets a node have **additional co-authors who
share the original author's rights over that content**. Drupal's ownership model
allows exactly one author per node, and every "own content" permission keys off that
single author. That's fine until two people write something together, a page is
handed over, or a team shares responsibility for a section — at which point your only
built‑in choices are to grant everyone *edit any content* (far too much) or to
reassign the author (which loses the record of who actually wrote it). Co-authorship
is the missing middle ground.

The module adds a **`co_authors`** field to nodes. Just like the normal author
field, only users with *administer nodes* can edit the co-author list by default, and
by default the field appears in the sidebar of the node form, right after the author
field. A user who is named as a co-author, and who also holds the relevant *own
content* permission, can then edit or delete that node just as if it were their own.

The important design detail: **being a co-author never grants a capability the user's
role doesn't already carry.** Co-authorship is combined with the matching *own
content* permission using "and" logic — a co-author gets exactly the rights they
would have over their own content of that type, and no more. So naming someone a
co-author on an article lets them edit it only if they could already edit their own
articles.

This module **requires no configuration** — it works as soon as it's enabled, and
depends only on core's **Node** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — see "How to use it" below.

## Where it lives

Node Co-Authors adds no admin settings page. The **Co-authors** field appears on the
node add/edit form (in the sidebar by default). If you want to move it or change how
it renders, you can adjust it under the content type's **Manage form display** and
**Manage display** like any other field.

## How to use it

1. Grant the co-author permissions to the appropriate roles at **People →
   Permissions** (`/admin/people/permissions`). There are three, controlling *who may
   edit the co-author list*:
   - **Edit co-authors of own content** — manage co-authors on nodes you authored.
   - **Edit co-authors of co-authored content** — manage co-authors on nodes you are
     already a co-author of. Think about this one carefully: it lets a co-author add
     *further* co-authors, a chain worth deciding on deliberately.
   - **Edit co-authors of all content** — manage the co-author list on any node.
2. Edit a node and add one or more users to the **Co-authors** field, then save.
3. Those users can now edit (and delete) the node exactly to the extent their role's
   *edit own / delete own* permission for that content type allows — and they can view
   it if unpublished under the same "own content" logic. The original author remains
   recorded.
