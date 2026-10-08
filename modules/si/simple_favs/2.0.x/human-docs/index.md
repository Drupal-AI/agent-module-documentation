# Simple favourites — manual setup guide

**Simple favourites** (`simple_favs`) gives visitors a lightweight way to bookmark
content on your site. Anonymous users' favourites are stored in a browser cookie;
logged‑in users' favourites can optionally be stored in the database so they persist
across devices. It works for ordinary nodes and for generic page paths, not just
node pages.

The module provides two blocks — a **heart/favourite toggle** you place on content,
and a **"My Favourites"** list block — plus a management page at **/my‑favourites**,
and a **Views field** you can add to node‑based tables or Search API indexes of
nodes so a favourite toggle appears right in a listing row. A settings form controls
whether database storage is used, how many favourites a block shows, and various
markup/class options for site builders. If Font Awesome is installed it uses a
prettier heart icon, otherwise it falls back to a built‑in one.

Favourites are always scoped to the current user on the server side: the database
controllers derive the user from the active session, never from the request, and
anonymous writes to the database are rejected — so one user cannot read or change
another user's favourites, and there is no cross‑user data leak. The one public
endpoint (which returns node titles) only ever returns titles of **published,
access‑checked** nodes. The endpoints that *save* favourites are gated by the core
*Access content* permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and place the blocks.
2. [Configuration](configuration/index.md) — the settings form (storage, limits,
   markup) field by field.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → User interface → Simple
Favs Settings** (`/admin/config/simple_favs/settings`), reachable by users with the
**Administer simple favs** permission. Visitors manage their own bookmarks at
**/my‑favourites**.

## How to use it

Place the **heart** block where you want the favourite toggle to appear, and the
**"My Favourites"** block wherever you want the list. Optionally add the Simple Favs
**Views field** to a node table or Search API view to show a toggle per row. A
visitor clicks the heart to favourite a page; the "My Favourites" block and the
`/my-favourites` page show what they have saved.
