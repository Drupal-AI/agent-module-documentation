# Public Preview — manual setup guide

**Public Preview** (`public_preview`) lets your editors share unpublished content
with people who don't have an account. Say you've drafted a node and want a
colleague, a client, or a publishing partner to review it before it goes live —
normally they'd need an account with permission to see unpublished content.
Public Preview solves this by generating a secret, shareable link that grants
anyone who holds it read access to that node, published or not.

Here's how it works in this Drupal 8/9/10 version. On any node, users with the
right permission get a **preview‑links form** at `/node/{node}/preview-links`,
where they can generate a unique **hash** for each translation of the node. The
node is then served at `/node/{node}/preview-link/{hash}` — and that URL works
for anonymous visitors regardless of the node's published status. Share the link
and your reviewer can see the content without logging in; the security rests on
the hash being long and unguessable, so treat these links as sensitive and only
send them to people who should see the draft.

Because access hinges entirely on possession of the secret link, anyone the link
is forwarded to can also view the content. There's no per‑person login, so if a
link leaks, generate a fresh hash to invalidate the old one. This makes Public
Preview ideal for lightweight review workflows rather than for locking down
genuinely confidential material.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

Public Preview has **no central settings form** — there is nothing to configure
site‑wide. You use it per‑node, as described in "How to use it" below, and you
control who can create preview links through a permission.

## Where it lives in the admin menu

The module adds no configuration page. Its controls appear **on individual
nodes**: the preview‑links form lives at `/node/{node}/preview-links`. Access to
that form is gated by the **access preview links form** permission, which you
grant at **People → Permissions** (`/admin/people/permissions`).

## How to use it

1. Grant the **access preview links form** permission to the roles that should be
   able to create preview links (for example, your Editor role).
2. As a user with that permission, open the node you want to share and go to
   `/node/{node}/preview-links`.
3. Generate a preview hash — you'll get one per translation of the node.
4. Copy the resulting link, `/node/{node}/preview-link/{hash}`, and send it to
   your reviewer. They can open it without an account, even while the node is
   unpublished.
5. If a link should no longer work, return to the preview‑links form and
   regenerate the hash to invalidate the old URL.
