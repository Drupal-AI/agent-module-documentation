# Change Requests — manual setup guide

**Change Requests** (`change_requests`) brings a "pull request" style workflow to
Drupal content. Instead of editing a node directly, an authorised user opens the
familiar edit form, makes their changes, and submits them as a proposal. The
changes are not written to the node — they are stored in a separate *patch
entity*, field by field, completely independent of the node's revision history.
A reviewer can then look the proposal over and accept or reject it. It's designed
for collaborative editing without "edit wars", inspired by how open‑source
developers collaborate on code.

What makes it clever is *how* the changes are stored: not as a full copy of the
content, but as precise change statements — for example, "in `field_tag` remove
the item with target_id 23 and add target_id 45" or "in `field_body` replace the
words 'Peter and Mary' with 'Peter or Mary'". Proposals are always shown in a
diff view with the author's changes highlighted. Because time can pass between a
proposal being written and accepted, the module handles **merge conflicts**: when
you accept a request, you get a side‑by‑side interface with the diff on the left
and an editable, auto‑merged result on the right, so you can resolve any
conflicts before saving. Accepting a request creates a new node revision whose
log message records the patch author, date, link, and title — so the history
stays transparent (and pairs well with the Diff module).

Almost all Drupal core field types are supported, and a documented plugin
interface lets developers add support for custom field types. The module lives in
the *Argue* package and provides its own permissions but no central settings
page — the workflow is driven by permissions and the per‑node change‑request UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** for this module. Behaviour is controlled by
permissions (who can propose versus who can approve) and the change‑request
interface on each node, described in "How to use it" below.

## Where it lives in the admin menu

Change Requests adds no settings page under Configuration. Instead it works from
the content itself — the change‑request and review interfaces appear on the nodes
where the workflow is used. Grant the module's permissions at **People →
Permissions** (`/admin/people/permissions`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. At **People → Permissions**, grant the Change Requests permissions to the
   right roles. Keep **who can propose** separate from **who can approve** — if
   the whole point is review, a proposer should not be able to approve their own
   change request.
3. An authorised user opens a node, edits it as usual, and submits the edit as a
   change request rather than saving it to the node. Their changes are stored as
   a patch entity.
4. A reviewer opens the change request, reads the highlighted diff, and accepts
   or rejects it. If the node changed in the meantime, the merge interface lets
   them resolve conflicts before saving.
5. On acceptance, a new node revision is created with the patch author and title
   recorded in the log message.
