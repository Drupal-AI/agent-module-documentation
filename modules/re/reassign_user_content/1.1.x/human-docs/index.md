# Reassign Deleted User Content / Media — manual setup guide

**Reassign Deleted User Content / Media** (`reassign_user_content`) solves a
common cleanup problem: when you delete a user account, what happens to
everything they authored? Out of the box Drupal can delete that content or make
it anonymous, but it can't simply hand it to a colleague. This module adds a new
account‑cancellation method that transfers a deleted user's **nodes (and their
revisions), media, and groups** to another user you choose, while **anonymizing
their comments** so comment threads stay intact.

It also ships a second, standalone tool: a **"Reassign selected content to user"**
bulk action on the content overview, which lets you re‑author a batch of nodes to
a single owner without deleting anyone.

The module has **no settings page** — it works by extending Drupal's existing
user‑cancellation flow and adding one content action. When you cancel an account
and pick its method, a "Choose user to assign" autocomplete appears so you can
name the destination user (it won't let you pick a user who is also being deleted
in the same batch). Large amounts of media, groups, or comments are processed in
batches so a cancellation doesn't time out. Media, Group, Comment, and Content
Moderation handling only kick in when those modules are present.

It requires only core **Node** and **User**. It's a handy fit for offboarding a
departing employee, GDPR‑driven account deletions where content must stay live,
or consolidating a spam account's content before removing it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no configuration page. The module gives you two ways to move content
ownership.

### Flow 1 — reassign when deleting a user

1. Cancel a single account from its **Cancel account** tab
   (`/user/{uid}/cancel`), or bulk‑cancel several accounts from **People**
   (`/admin/people`).
2. Choose the cancellation method **"Delete the account and make its content,
   media, and groups belong to another user."**
3. A required **Choose user to assign** autocomplete appears — pick the
   destination user. (You cannot choose a user who is also being deleted.)
4. Confirm. The deleted user's nodes, node revisions, content‑moderation drafts,
   media, and groups are transferred to the chosen user, and their comments are
   anonymized (owner set to anonymous, author name set to the site's anonymous
   name).

### Flow 2 — bulk re‑author selected nodes

1. Go to the content overview at **Content** (`/admin/content`).
2. Tick the nodes you want to re‑author and run the action **"Reassign selected
   content to user."** (The action only offers nodes you're allowed to update.)
3. You're taken to a short form at `/admin/content/reassign-author` — pick the
   destination user and choose **Assign**. The selected nodes are re‑authored to
   that user.
